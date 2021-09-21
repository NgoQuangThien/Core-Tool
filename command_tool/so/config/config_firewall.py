import yaml


def create_new_config(chain, host_group, port_group):
    config = [{
        "firewall": {
            "assigned_hostgroups": {
                "chain": {
                    chain: {
                        "hostgroups": {
                            host_group: {
                                "portgroups": [
                                    "portgroups." + port_group
                                ]
                            }
                        }
                    }
                }
            }
        }
    }]
    return yaml.safe_dump_all(config, indent=2, sort_keys=False)


def create_new_chain(host_group, port_group):
    config = {
        "hostgroups": {
            host_group: {
                "portgroups": [
                    "portgroups." + port_group
                ]
            }
        }
    }
    return config


def create_new_host_group(port_group):
    config = {
        "portgroups": [
            "portgroups." + port_group
        ]
    }
    return config


def create_new_port_group(port_group):
    port_group = ''.join(['portgroups.', port_group])
    return port_group
