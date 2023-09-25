#Read Me
#Quick little script to verify your time servers are sync'd up

import ntplib
from datetime import datetime

ntp_servers = ['tick.nisdtx.org', 'tock.nisdtx.org', 'time.nisdtx.org']
client = ntplib.NTPClient()

for ntp_server in ntp_servers:
    response = client.request(ntp_server, version=3)
    ntp_time = datetime.fromtimestamp(response.tx_time)
    print(f'{ntp_server}: {ntp_time}')
