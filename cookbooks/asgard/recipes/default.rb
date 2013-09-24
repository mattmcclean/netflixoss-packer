include_recipe "java::oracle"
include_recipe "htpasswd"

package "nginx" do
  action :install
end

cookbook_file "#{node[:nginx][:conf_dir]}/nginx.conf" do
  source "nginx.conf"
  owner "root"
  group "root"
  mode 0755
  action :create
end

# add user "foo" with password "bar" to "/etc/nginx/htpassword"
htpasswd "#{node[:nginx][:conf_dir]}/htpassword" do
  user node[:nginx][:username]
  password node[:nginx][:password]
end

user "asgard" do
  comment "asgard system user"
  system true
  shell "/bin/false"
end

directory node[:asgard][:base_dir] do
  owner "root"
  mode 0755
  action :create
end

directory node[:asgard][:log_dir] do
  owner "asgard"
  mode 0755
  action :create
end

directory node[:asgard][:home_dir] do
  owner "asgard"
  mode 0755
  action :create
  recursive true
end

remote_file "#{node[:asgard][:base_dir]}/asgard_standalone.jar" do
  source "https://mmcclean-sw-assets.s3.amazonaws.com/asgard-standalone.jar"
  owner "root"
  group "root"
  mode 0755
  action :create_if_missing
end

service "asgard" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true
end

template "asgard.upstart.conf" do
  path "/etc/init/asgard.conf"
  source "asgard.upstart.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "asgard")
end

template "#{node[:asgard][:home_dir]}/Config.groovy" do
  source "Config.groovy.erb"
  owner "asgard"
  mode "0644"
  notifies :restart, resources(:service => "asgard")
end

service "asgard" do
  action [:enable, :start]
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
