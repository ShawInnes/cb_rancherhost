# # encoding: utf-8

# Inspec test for recipe cb_rancherhost::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.

describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe command('docker ps | grep rancher/server') do
  its('stdout') { should match (/rancher\/server/) }
end

describe port(8080) do
  it { should be_listening }
end
