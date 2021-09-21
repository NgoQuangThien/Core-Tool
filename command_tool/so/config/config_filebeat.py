import yaml


def create_new_config(log_type, log_path, module, dataset, category, clean_removed, close_removed):
    config = [{
        "filebeat": {
            "config": {
                "inputs": [
                    {
                        "type": log_type,
                        "paths": [
                            log_path
                        ],
                        "fields": {
                            "module": module,
                            "dataset": dataset,
                            "category": category
                        },
                        "processors": [
                            {
                                "drop_fields": {
                                    "fields": "[\"source\", \"prospector\", \"input\", \"offset\", \"beat\"]"
                                }
                            }
                        ],
                        "fields_under_root": 'true',
                        "clean_removed": clean_removed,
                        "close_removed": close_removed
                    }
                ]
            }
        }
    }]
    return yaml.safe_dump_all(config, indent=2, sort_keys=False)


def create_new_input(log_type, log_path, module, dataset, category, clean_removed, close_removed):
    config = {
        "type": log_type,
        "paths": [
            log_path
        ],
        "fields": {
            "module": module,
            "dataset": dataset,
            "category": category
        },
        "processors": [
            {
                "drop_fields": {
                    "fields": "[\"source\", \"prospector\", \"input\", \"offset\", \"beat\"]"
                }
            }
        ],
        "fields_under_root": 'true',
        "clean_removed": clean_removed,
        "close_removed": close_removed
        }
    return config
