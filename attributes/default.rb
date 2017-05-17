default['rancher']['docker']['script'] = 'https://releases.rancher.com/install-docker/17.03.sh'

# image and tag to use for rancher server image
default['rancher']['server']['image'] = 'rancher/server'
default['rancher']['server']['version'] = 'latest'

# IP or hostname of rancher server.  Agents use this to communicate to it.
# Leave as `nil` if you wish to use chef search
default['rancher']['server']['host'] = nil

# run rancher server with a data volume
default['rancher']['server']['volume_container'] = true

# Port to expose on host running the rancher server.
# in the form of 'port' or 'ip:port'
default['rancher']['server']['port'] = '8080'

# image and tag to use for rancher agent image
default['rancher']['agent']['image'] = 'rancher/agent'
default['rancher']['agent']['version'] = 'latest'
