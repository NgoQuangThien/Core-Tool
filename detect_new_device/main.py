import subprocess
import json
import time
from datetime import datetime
import threading

from lib import regex_host_info
from lib import alert_logging


interface = "bond0"
protocol = "arp"
ignore_interval = 3600 # 1 hour
ignore_list = {}
log_path = "/nsm/raw_log/detect_new_device/"
file_path = "/source/bids/detect_new_device/device.list"
message_template = """{
                        "@timestamp": "*",
                        "rule": {
                            "name": "Detected new device"
                        },
                        "host": {
                            "ip": "*",
                            "mac": "*"
                        },
                        "event": {
                            "dataset": "alert",
                            "event.severity_label": "critical",
                            "module": "bids"
                        }
                    }"""

def get_device_list():
    with open(file_path, 'r', encoding='UTF-8') as f:
        devices = [device.rstrip() for device in f]
        return devices    

def message_processor(current_time, ip_addr, mac_addr):
    msg = json.loads(message_template)
    msg['@timestamp'] = current_time
    msg['host']['ip'] = ip_addr
    msg['host']['mac'] = mac_addr
    return msg

def interval_countdown_ignore():
    temp_list = []
    while True:
        current_time = datetime.now().timestamp()
        if len(ignore_list):
            for value in ignore_list:
                if ((current_time - ignore_list[value]) > ignore_interval) and value not in temp_list:
                    temp_list.append(value)

            if temp_list:
                for value in temp_list: 
                    del ignore_list[value]
                    temp_list.remove(value)

        time.sleep(1)

if __name__ == "__main__":
    white_list = get_device_list()
    alert_logging.create_time_based_rotating_log(log_path)
    countdown_thread = threading.Thread(name='interval_countdown_ignore', target=interval_countdown_ignore)
    countdown_thread.setDaemon(True)
    countdown_thread.start()

    p = subprocess.Popen(('sudo', 'tcpdump', '-i', interface, protocol, '--immediate-mode', '-l'), stdout = subprocess.PIPE)
    for row in iter(p.stdout.readline, b''):
        # process here
        mac_addr = regex_host_info.get_mac_addr(str(row.rstrip()))
        if mac_addr and mac_addr not in white_list and mac_addr not in ignore_list:
            now = datetime.now()
            current_time = now.strftime("%Y-%m-%d %H:%M:%S")
            ip_addr = regex_host_info.get_ip_addr(str(row.rstrip()))

            # Logging event
            message = message_processor(current_time, ip_addr, mac_addr)
            logger = alert_logging.logging.getLogger("Rotating Log")
            logger.propagate = False
            logger.critical(message)

            # Add device to ignore_list
            ignore_list[mac_addr] = now.timestamp()

            # Keep alive countdown_thread
            if not countdown_thread.isAlive: countdown_thread.start()

