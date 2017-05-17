# # encoding: utf-8

# Inspec test for recipe cb_rancherhost::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe command('docker ps | grep rancher/agent') do
  its('stdout') { should match (/rancher\/agent/) }
end
