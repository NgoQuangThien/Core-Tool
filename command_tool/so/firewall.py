import subprocess
import sys

import yaml

from so.config.config_firewall import create_new_config, create_new_chain, create_new_host_group, create_new_port_group
from so.proc_yaml.modify_pillar_file import safe_load_yml, check_item, add_new_config, overwrite_pillar


directory = '/opt/so/saltstack/local/pillar/minions/'


def add_host_group(group_name):
    cmd = 'sudo so-firewall addhostgroup' + ' ' + group_name
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


def add_ip_to_the_host_group(group_name, ip):
    cmd = 'sudo so-firewall includehost' + ' ' + group_name + ' ' + ip
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


def add_port_group(group_name):
    cmd = 'sudo so-firewall addportgroup' + ' ' + group_name
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


def add_required_port_to_the_port_group(group_name, protocol, port):
    cmd = 'sudo so-firewall addport' + ' ' + group_name + ' ' + protocol + ' ' + str(port)
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


def associate_port_group_redefinition_to_a_node(server_name, server_role):
    file_path = directory + server_name + '_' + server_role + '.sls'
    data = safe_load_yml(file_path)
    if not data:
        return
    key = 'firewall'
    if check_item(key, data):
        cur_config = data['firewall']['assigned_hostgroups']['chain']
        print('================== CURRENT CONFIG ==================')
        print(yaml.safe_dump_all([cur_config], indent=2, sort_keys=False))

        print('================== MENU ==================')
        print('1.   Add new port group')
        print('2.   Delete host group - chua hoan thanh')
        print('3.   Delete port group - chua hoan thanh')

        try:
            choose = int(input('>>> '))
        except ValueError:
            print('Input ERROR')
            sys.exit(1)

        if choose == 1:
            chain = input('Enter chain (DOCKER-USER/INPUT): ')
            host_group = input('Enter host group: ')
            port_group = input('Enter port group: ')
            new_port_group = create_new_port_group(port_group)

            if chain not in data['firewall']['assigned_hostgroups']['chain']:
                new_chain = create_new_chain(host_group, port_group)
                data['firewall']['assigned_hostgroups']['chain'][chain] = new_chain
                overwrite_pillar(file_path, data)
                new_config = data['firewall']['assigned_hostgroups']['chain']
                print('================== NEW CONFIG ==================')
                print(yaml.safe_dump_all([new_config], indent=2, sort_keys=False))

            elif host_group not in data['firewall']['assigned_hostgroups']['chain'][chain]['hostgroups']:
                new_host_group = create_new_host_group(port_group)
                data['firewall']['assigned_hostgroups']['chain'][chain]['hostgroups'][host_group] = new_host_group
                overwrite_pillar(file_path, data)
                new_config = data['firewall']['assigned_hostgroups']['chain']
                print('================== NEW CONFIG ==================')
                print(yaml.safe_dump_all([new_config], indent=2, sort_keys=False))

            elif new_port_group not in data['firewall']['assigned_hostgroups']['chain'][chain]['hostgroups'][host_group]['portgroups']:
                data['firewall']['assigned_hostgroups']['chain'][chain]['hostgroups'][host_group]['portgroups'].append(new_port_group)
                overwrite_pillar(file_path, data)
                new_config = data['firewall']['assigned_hostgroups']['chain']
                print('================== NEW CONFIG ==================')
                print(yaml.safe_dump_all([new_config], indent=2, sort_keys=False))

            else:
                print('====================================')
                print('Port group does exist ')

        elif choose == 2:
            pass
        else:
            print("""No choice exists""")

    else:
        print('Dont have config in ' + server_name + '_' + server_role + '.sls')
        print('Create new config here')
        chain = input('Enter chain (DOCKER-USER/INPUT): ')
        host_group = input('Enter host group: ')
        port_group = input('Enter port group: ')
        new_config = create_new_config(chain, host_group, port_group)
        add_new_config(file_path, new_config)

        data = safe_load_yml(file_path)
        cur_config = data['firewall']['assigned_hostgroups']['chain']
        print('================== CURRENT CONFIG ==================')
        print(yaml.safe_dump_all([cur_config], indent=2, sort_keys=False))
