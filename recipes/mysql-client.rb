# encoding: UTF-8
#
# Cookbook Name:: openstack-ops-database
# Recipe:: mysql-client
#
# Copyright 2013, Opscode, Inc.
# Copyright 2013, AT&T Services, Inc.
# Copyright 2014, SUSE Linux, GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

mysql_client 'default' do
  action :create
end

mysql2_chef_gem 'default' do
  action :install
end

# Note(frickler): Work around for https://github.com/chef/chef-dk/issues/966
bash 'fix gem ext dir' do
  code "rmdir ~/.chefdk/gem/ruby/2.1.0/extensions && ln -s /opt/chefdk/embedded/lib/ruby/gems/2.1.0/extensions ~/.chefdk/gem/ruby/2.1.0/extensions || true"
end

node['openstack']['db']['python_packages']['mysql'].each do |pkg|
  package pkg
end
