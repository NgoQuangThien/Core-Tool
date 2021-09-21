import yaml
from so.config.config_filebeat import create_new_config, create_new_input
from so.proc_yaml.modify_pillar_file import safe_load_yml, check_item, add_new_config, overwrite_pillar


directory = 'C:/Users/Ngo Quang Thien/OneDrive - actvn.edu.vn/SIEM/CODE/command_tool/'


def add_input_filebeat(server_name, server_role):
    file_path = directory + server_name + '_' + server_role + '.sls'
    data = safe_load_yml(file_path)
    if not data:
        return
    key = 'filebeat'
    if check_item(key, data):
        cur_config = data[key]
        print('================== CURRENT CONFIG ==================')
        print(yaml.safe_dump_all([cur_config], indent=2, sort_keys=False))
        print('Start to create a new input to filebeat')

        log_type = input('Enter log type: ')
        log_path = input('Enter log path: ')
        module = input('Enter module: ')
        dataset = input('Enter datase: ')
        category = input('Enter category: ')
        clean_removed = input('Enter clean_removed (true/false): ')
        close_removed = input('Enter close_removed (true/false): ')

        new_input = create_new_input(log_type, log_path, module, dataset, category, clean_removed, close_removed)
        data[key]['config']['inputs'].append(new_input)

        overwrite_pillar(file_path, data)

        new_config = data[key]['config']['inputs']
        print('================== NEW CONFIG ==================')
        print(yaml.safe_dump_all(new_config, indent=2, sort_keys=False))

    else:
        print('Dont have config in ' + server_name + '_' + server_role + '.sls')
        print('Create new config here')
        log_type = input('Enter log type: ')
        log_path = input('Enter log path: ')
        module = input('Enter module: ')
        dataset = input('Enter datase: ')
        category = input('Enter category: ')
        clean_removed = input('Enter clean_removed (true/false): ')
        close_removed = input('Enter close_removed (true/false): ')
        new_config = create_new_config(log_type, log_path, module, dataset, category, clean_removed, close_removed)
        add_new_config(file_path, new_config)
