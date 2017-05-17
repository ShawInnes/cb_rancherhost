#
# Cookbook:: cb_rancherhost
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
end

docker_image node['rancher']['server']['image'] do
  tag node['rancher']['server']['version']
  action :pull
end

docker_container 'rancher-server-data' do
  image node['rancher']['server']['image']
  tag node['rancher']['server']['version']
  volume ['/var/lib/mysql','/var/lib/cattle']
  entrypoint '/bin/true'
  action :create
  container_name 'rancher-server-data'
  only_if { node['rancher']['server']['volume_container'] }
end

docker_container 'rancher-server' do
  image node['rancher']['server']['image']
  tag node['rancher']['server']['version']
  detach true
  container_name 'rancher-server'
  volumes_from 'rancher-server-data' if node['rancher']['server']['volume_container']
  port "#{node['rancher']['server']['port']}:8080"
  restart_policy 'always'
  action :run_if_missing
end
