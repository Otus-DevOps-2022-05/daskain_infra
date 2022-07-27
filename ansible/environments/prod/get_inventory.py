#!/usr/bin/python

import subprocess
import argparse

try:
    import json
except ImportError:
    import simplejson as json

class Inventory(object):

    def __init__(self):
        self.inventory = {}
        self.read_cli_args()

        # Called with `--list`.
        if self.args.list:
            self.inventory = self.build_dyn_inventory()
            # Called with `--host [hostname]`.
        elif self.args.host:
            # Not implemented, since we return _meta info `--list`.
            self.inventory = self.build_dyn_inventory()
        # If no groups or vars are present, return an empty inventory.
        else:
            self.inventory = self.build_dyn_inventory()

        print(json.dumps(self.inventory))


    def get_inventori(self):
        return subprocess.getoutput('yc compute instances list --format json')

    def build_dyn_inventory(self):

        data = { "_meta": { "hostvars": {} }}
        yc_json = json.loads(self.get_inventori())
        for hosts in yc_json:
            host_name = hosts['name']
            net_interface = hosts['network_interfaces']
            ext = json.loads(json.dumps(net_interface[0]))
            ip = ext['primary_v4_address']['one_to_one_nat']['address']
            app_name = host_name.replace('reddit-','')
            app_server_name = app_name + 'server'
            data[app_name] = { "hosts" : [app_server_name] }
            data['_meta']['hostvars'][app_server_name] = { "ansible_host": ip }

        return data

    def empty_inventory(self):
        return {'_meta': {'hostvars': {}}}

    def read_cli_args(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--list', action = 'store_true')
        parser.add_argument('--host', action = 'store')
        self.args = parser.parse_args()

# Get the inventory.
Inventory()
