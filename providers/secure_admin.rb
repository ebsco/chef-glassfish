#
# Copyright Peter Donald
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

include Chef::Asadmin

action :enable do
  bash "asadmin_enable-secure-admin" do
    only_if "#{asadmin_command('get secure-admin.enabled')} | grep -x -- 'secure-admin.enabled=false'"
    user node['glassfish']['user']
    group node['glassfish']['group']
    code asadmin_command("enable-secure-admin")
    notifies :restart, resources(:service => "glassfish-#{new_resource.domain_name}"), :delayed
  end
end

action :disable do
  bash "asadmin_disable-secure-admin" do
    only_if "#{asadmin_command('get secure-admin.enabled')} | grep -x -- 'secure-admin.enabled=true'"
    user node['glassfish']['user']
    group node['glassfish']['group']
    code asadmin_command("disable-secure-admin")
    notifies :restart, resources(:service => "glassfish-#{new_resource.domain_name}"), :delayed
  end
end
