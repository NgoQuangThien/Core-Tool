# SERVICE STATUS

## Getting status of the SystemD services using Telegraf with InfluxDB & Grafana

  This script send a JSON format with services statuses coded by digits:
```
  active (running) = 1
  active (exited) = 2
  inactive (dead) = 3
  failed  = 4
  no match = 0
```  
## Installation

```
$ cd /opt && git clone https://github.com/ratibor78/srvstatus.git
$ cd /opt/srvstatus
$ python3 -m venv venv && source venv/bin/activate
$ pip3 install -r requirements.txt
$ chmod +x ./service.py
```

  Rename **settings.ini.back** to **settings.ini** and specify a list of services that you need to check in one string
  separated with spaces:

```
   [SERVICES]
    name = docker.service nginx.service
```
  You can also add your own **user services** list same to (systemctl --user some.service):

```
   [USER_SERVICES]
    name = syncthing.service
```

Then configure the telegraf **exec** plugin this way:

```
    [[inputs.exec]]

    commands = [
     "/opt/srvstatus/venv/bin/python3 /opt/srvstatus/service.py"
    ]

    timeout = "5s"
    name_override = "services_stats"
    data_format = "json"
    tag_keys = [
      "service"
    ]
```
That's all, now you can create nice and pretty Grafana dashboards for system services with alerting.

Good luck.
