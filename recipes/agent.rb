#
# Cookbook:: cb_rancherhost
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
end

if node['rancher']['server']['host']
  server_host = node['rancher']['server']['host']
else
  ## server = search('node', "name:#{node['rancher']['server']['node_name']}").first
  ## server_host = best_ip_for(server)
end

Chef::Log.info("Agent will connect to server: http://#{server_host}:#{node['rancher']['server']['port']}")

docker_image node['rancher']['agent']['image'] do
  tag node['rancher']['agent']['version']
  action :pull
end

docker_container 'rancher-agent' do
  image node['rancher']['agent']['image']
  tag node['rancher']['agent']['version']
  command "http://#{server_host}:#{node['rancher']['server']['port']}"
  volume '/var/run/docker.sock:/var/run/docker.sock'
  container_name 'rancher-agent-init'
  detach false
  not_if 'docker inspect rancher-agent'
end
