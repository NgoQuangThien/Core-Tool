import calendar
import glob
import os
import threading
import time
from datetime import datetime
from pathlib import Path
import logging
import logging.handlers as handlers
import signal

import redis

# Global variable
redis_host = 'localhost'
redis_port = 6379
batch_events = 125
storage_time = 604800  # 7 days

#################################################
log_directory = '/nsm/raw_log/'
logging_folder = '/source/Redis/redis-pull/logs/'

#################################################
keys = list()
new_keys = list()
ignore_keys = list()
threads = dict()


class GracefulKiller:
    kill_now = False

    def __init__(self):
        signal.signal(signal.SIGINT, self.exit_gracefully)
        signal.signal(signal.SIGTERM, self.exit_gracefully)

    def exit_gracefully(self, *args):
        self.kill_now = True


killer = GracefulKiller()
Path(logging_folder).mkdir(parents=True, exist_ok=True)
file_path = logging_folder + 'redis-pull.log'
log_format = logging.Formatter('%(asctime)s [%(levelname)s] %(message)s')
logger = logging.getLogger('redis-pull')
logger.setLevel(logging.DEBUG)
log_handler = handlers.TimedRotatingFileHandler(filename=file_path, when='d', interval=1, backupCount=7)
log_handler.setLevel(logging.DEBUG)
log_handler.setFormatter(log_format)
logger.addHandler(log_handler)


def get_keys(redis_connection):
    while True:
        current_keys = redis_connection.keys(pattern='*')
        for key in current_keys:
            try:
                value = key.decode()
                if value not in keys:
                    new_keys.append(value)
                    keys.append(value)
            except UnicodeDecodeError:
                logger.error("Could not decode KEY: {0}".format(key))
        time.sleep(1)


def get_values(redis_connection, key):
    result = [redis_connection.blpop(keys=key, timeout=3)]
    pipe = redis_connection.pipeline()
    pipe.lrange(name=key, start=0, end=(batch_events - 2))
    pipe.ltrim(name=key, start=(batch_events - 1), end=-1)
    result.append(pipe.execute())
    return result


def parsing(data):
    if data[0] is None: return None
    try:
        result = [data[0][1].decode() + '\n']
        sub_result = data[1][0]
        if sub_result:
            for content in sub_result: result.append(content.decode() + '\n')
        return result
    except UnicodeDecodeError:
        return False


def write_2_file(key, content):
    now = datetime.now().strftime('%Y-%m-%d')
    log_folder = log_directory + key
    Path(log_folder).mkdir(parents=True, exist_ok=True)
    file_path = log_folder + '/' + now + '.log'
    with open(file_path, mode='a', encoding='utf-8') as file:
        file.writelines(content)


def processor(redis_connection, key):
    while not killer.kill_now:
        data = get_values(redis_connection, key)
        result = parsing(data)
        if result is None:
            logger.info('Thread ID: {0}. KEY: {1}. Action: close. Reason: non-metric for 3 seconds'.format(
                threading.current_thread().ident, key))
            return
        elif not result:
            logger.error("Could not decode VALUE of KEY: {0}".format(key))
            continue
        else: write_2_file(key, result)
    logger.info('Thread ID: {0}. KEY: {1}. Action: close. Reason: terminated by someone'.format(
        threading.current_thread().ident, key))


def compress_file(file_path):
    cmd = 'gzip -f --best "{0}"'.format(file_path)
    logger.info("Compress file: {0}".format(file_path))
    os.system(cmd)


def delete_file(file_path):
    logger.info("Delete file by logrotate: {0}".format(file_path))
    try:
        os.remove(file_path)
    except Exception as e:
        logger.warning("File deletion failed: {0}. Exception: {1}. Try to delete the file again".format(file_path, e))
        time.sleep(1)
        try:
            os.remove(file_path)
        except Exception as e:
            logger.error(
                "Ignore the file: {0}. Reason: failed attempt to delete file with exception: {1}".format(file_path, e))


def logrotate():
    while not killer.kill_now:
        current_minute = datetime.now().strftime('%M')
        if current_minute != '00':
            time.sleep(1)
        else:
            current_file_name = datetime.now().strftime('%Y-%m-%d') + '.log'
            current_timestamp = calendar.timegm(time.strptime(datetime.now().strftime('%Y-%m-%d'), '%Y-%m-%d'))
            for key in keys:
                log_folder = log_directory + key
                Path(log_folder).mkdir(parents=True, exist_ok=True)
                os.chdir(log_folder)
                for file in glob.glob("*.log"):
                    if file != current_file_name: compress_file(log_folder + '/' + file)
                for file in glob.glob("*.log.gz"):
                    try:
                        file_creation_date = file.split('.')[0]
                        file_timestamp = calendar.timegm(time.strptime(file_creation_date, '%Y-%m-%d'))
                        if (current_timestamp - file_timestamp) >= storage_time: delete_file(log_folder + '/' + file)
                    except Exception as e:
                        logger.warning(
                            "File name parsing failed: {0}. Exception: {1}. Try to parse the file name again".format(
                                (log_folder + '/' + file), e))
                        time.sleep(1)
                        try:
                            file_creation_date = file.split('.')[0]
                            file_timestamp = calendar.timegm(time.strptime(file_creation_date, '%Y-%m-%d'))
                            if (current_timestamp - file_timestamp) >= storage_time: delete_file(
                                log_folder + '/' + file)
                        except Exception as e:
                            logger.error(
                                "Ignore the file: {0}. Reason: failed attempt to parse file name with exception: {1}".format(
                                    (log_folder + '/' + file), e))
    logger.info('Thread ID: {0}. Thread name: {1}. Action: close. Reason: terminated by someone'.format(
        threading.current_thread().ident, 'Logrotate'))


if __name__ == '__main__':
    r = redis.Redis(host=redis_host, port=redis_port)
    # pool = redis.ConnectionPool(host='localhost', port=6379)
    # r = redis.Redis(connection_pool=pool)

    t1 = threading.Thread(target=get_keys, args=(r,), daemon=True)
    t1.start()
    threads['Scan'] = t1
    logger.info("Start thread with ID: {0} for key-scanning".format(threads.get('Scan').ident))

    t2 = threading.Thread(target=logrotate)
    t2.start()
    threads['Logrotate'] = t2
    logger.info("Start thread with ID: {0} for log-rotating".format(threads.get('Logrotate').ident))

    logger.info("Service started")
    number_keys = 0
    logger.info("Current key number: {0}".format(number_keys))
    while not killer.kill_now:
        for key in new_keys:
            x = threading.Thread(target=processor, args=(r, key,))
            x.start()
            threads[key] = x
            logger.info("Start thread with ID: {0}. KEY: {1}".format(threads.get(key).ident, key))
            number_keys += 1
            logger.info("Current key number: {0}".format(number_keys))
            new_keys.remove(key)

        current_second = datetime.now().strftime('%S')
        if current_second == '00':
            for key in threads:
                if not threads.get(key).is_alive():
                    if key == 'Scan':
                        t1.start()
                        threads['Scan'] = t1
                        logger.info(
                            "Key scanning thread is dead. Create new thread with ID: {0} for key scanning".format(
                                threads.get('Scan').ident))
                    elif key == 'Logrotate':
                        t2.start()
                        threads['Logrotate'] = t2
                        logger.info("Logrotate thread is dead. Create new thread with ID: {0} for log-rotating".format(
                            threads.get('Logrotate').ident))
                    else:
                        logger.info("Thread with ID: {0}. KEY: {1}. Action: remove. Reason: the thread is dead".format(
                                threads.get(key).ident, key))
                        ignore_keys.append(key)
            for key in ignore_keys:
                keys.remove(key)
                del threads[key]
                number_keys -= 1
            if ignore_keys:
                logger.info("Current key number: {0}".format(number_keys))
            ignore_keys.clear()
    logger.info('Thread ID: {0}. Thread name: {1}. Action: close. Reason: terminated by someone'.format(
        threading.current_thread().ident, 'Main'))
