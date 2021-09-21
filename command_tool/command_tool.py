import sys
from so.filebeat import add_input_filebeat
from so.firewall import add_host_group, add_ip_to_the_host_group, add_port_group, add_required_port_to_the_port_group, \
    associate_port_group_redefinition_to_a_node
from so.logstash import add_pipeline_to_server
from so.proc_yaml.modify_pillar_file import sync_config


def menu():
    print("1.   Firewall")
    print("2.   Filebeat")
    print("3.   Logstash")


def function_firewall():
    print('1.   Add host group')
    print('2.   Add IP to the host group')
    print('3.   Add port group')
    print('4.   Add the required ports to the port group')
    print('5.   Associate port group redefinition to a node')
    print('6.   Apply the firewall state to the node')


def function_filebeat():
    print('1.   Add new input')
    print('2.   Enable the module - chua hoan thien')
    print('3.   Apply the filebeat state to the node')


def function_logstash():
    print('1.   Create new pipeline - chua hoan thien')
    print('2.   Add pipeline to the server')
    print('3.   Apply the logstash state to the node')


def get_number_from_keyboard():
    try:
        x = int(input(">>> "))
    except ValueError:
        print('Input ERROR')
        sys.exit(1)
    return x


def get_string_from_keyboard():
    x = input(">>> ")
    return x


if __name__ == '__main__':
    menu()
    choose = get_number_from_keyboard()

    # FIREWALL
    if choose == 1:
        function_firewall()
        choose = get_number_from_keyboard()
        if choose == 1:
            while choose != 0:
                host_group = input('Enter host group: ')
                add_host_group(host_group)
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        elif choose == 2:
            while choose != 0:
                host_group = input('Enter host group: ')
                ip = input('Enter ip: ')
                add_ip_to_the_host_group(host_group, ip)
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        elif choose == 3:
            while choose != 0:
                port_group = input('Enter port group: ')
                add_port_group(port_group)
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        elif choose == 4:
            while choose != 0:
                host_group = input('Enter port group: ')
                protocol = input('Enter protocol: ')
                try:
                    port = int(input('Enter port: '))
                except ValueError:
                    print('Input ERROR')
                    sys.exit(1)
                add_required_port_to_the_port_group(host_group, protocol, port)
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        elif choose == 5:
            while choose != 0:
                name = input('Enter server name: ')
                role = input('Enter server role: ')
                associate_port_group_redefinition_to_a_node(name, role)
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        elif choose == 6:
            while choose != 0:
                name = input('Enter server name: ')
                role = input('Enter server role: ')
                sync_config(name, role, 'firewall')
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        else:
            print("""No choice exists""")

    # FILEBEAT
    elif choose == 2:
        function_filebeat()
        choose = get_number_from_keyboard()
        if choose == 1:
            while choose != 0:
                name = input('Enter server name: ')
                role = input('Enter server role: ')
                add_input_filebeat(name, role)
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        elif choose == 2:
            pass

        elif choose == 3:
            while choose != 0:
                name = input('Enter server name: ')
                role = input('Enter server role: ')
                sync_config(name, role, 'filebeat')
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        else:
            print("""No choice exists""")

    # LOGSTASH
    elif choose == 3:
        function_logstash()
        choose = get_number_from_keyboard()
        if choose == 1:
            pass

        elif choose == 2:
            while choose != 0:
                name = input('Enter server name: ')
                role = input('Enter server role: ')
                add_pipeline_to_server(name, role)
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        elif choose == 3:
            while choose != 0:
                name = input('Enter server name: ')
                role = input('Enter server role: ')
                sync_config(name, role, 'logstash')
                print('Continue? Press 0 to quit.')
                choose = get_number_from_keyboard()

        else:
            print("""No choice exists""")
    else:
        print("""No choice exists""")
