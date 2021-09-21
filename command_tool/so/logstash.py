import yaml
from so.config.config_logstash import create_new_config
from so.proc_yaml.modify_pillar_file import safe_load_yml, check_item, add_new_config


directory = 'C:/Users/Ngo Quang Thien/OneDrive - actvn.edu.vn/SIEM/CODE/command_tool/'


def add_pipeline_to_server(server_name, server_role):
    file_path = directory + server_name + '_' + server_role + '.sls'
    data = safe_load_yml(file_path)
    if not data:
        return
    key = 'logstash'
    if check_item(key, data):
        cur_config = data[key]
        print('================== CURRENT CONFIG ==================')
        print(yaml.safe_dump_all([cur_config], indent=2, sort_keys=False))
    else:
        file_name = input('Enter file name: ')
        new_config = create_new_config(file_name)
        add_new_config(file_path, new_config)
