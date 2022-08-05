import re


regex_mac = r"([a-f\d]{2}:){5}[a-f\d]{2}"
regex_ip = r"(?:2[0-4][0-9]|25[0-5]|1?[0-9]?[0-9])[.](?:2[0-4][0-9]|25[0-5]|1?[0-9]?[0-9])[.](?:2[0-4][0-9]|25[0-5]|1?[0-9]?[0-9])[.](?:2[0-4][0-9]|25[0-5]|1?[0-9]?[0-9])"

def get_mac_addr(dump_str):
    matches = re.finditer(regex_mac, dump_str)
    for matchNum, match in enumerate(matches, start=1):
        return ("{match}".format(match = match.group()))

def get_ip_addr(dump_str):
    matches = re.finditer(regex_ip, dump_str)
    for matchNum, match in enumerate(matches, start=1):
        return ("{match}".format(match = match.group()))
