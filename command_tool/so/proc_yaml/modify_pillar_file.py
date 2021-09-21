import subprocess
import yaml


def safe_load_yml(file):
    try:
        with open(file, 'r') as f:
            try:
                x = yaml.safe_load(f)
            except yaml.YAMLError as error:
                print(error)
                return False
            return x
    except FileNotFoundError as error:
        print(error)
        return False


def check_item(item, yml_string):
    if item in yml_string:
        return True
    else:
        return False


def add_new_config(file, config):
    with open(file, 'a') as f:
        f.write(config)


def overwrite_pillar(file, new_config):
    new_config = [new_config]
    config = yaml.safe_dump_all(new_config, indent=2, sort_keys=False)
    with open(file, 'w') as f:
        f.write(str(config))


def sync_config(server_name, server_role, service):
    cmd = 'sudo salt' + ' ' + server_name + '_' + server_role + 'state.apply' + ' ' + service
    result = subprocess.Popen(cmd,
                              stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE,
                              shell=True
                              )
    stdout, stderr = result.communicate()
    if not stderr:
        if stdout:
            print(stdout.decode('UTF-8'))
        return True
    else:
        print(stderr.decode('UTF-8'))
        return False
