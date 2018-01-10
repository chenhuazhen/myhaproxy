#
# Cookbook:: myhaproxy
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# node.default['haproxy']['members'] =
#   [
#     {
#       "hostname" => "ec2-107-21-86-131.compute-1.amazonaws.com",
#       "ipaddress" => "107.21.86.131",
#       "port" => 80,
#       "ssl_port" => 80
#     },
#     {
#       "hostname" => " ec2-54-205-195-8.compute-1.amazonaws.com",
#       "ipaddress" => "54.205.195.8",
#       "port" => 80,
#       "ssl_port" => 80
#     }
#   ]

all_web_nodes = search('node', 'role:web_server')

members = []

all_web_nodes.each do |web_node|
  member = {
    "hostname" => web_node['cloud']['public_hostname'],
    "ipaddress" => web_node['cloud']['public_ipv4'],
    "port" => 80,
    "ssl_port" => 80
  }
  members.push(member)
end

node.default['haproxy']['members'] = members;

include_recipe 'haproxy::manual'
