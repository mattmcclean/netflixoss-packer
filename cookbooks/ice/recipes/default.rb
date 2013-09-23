include_recipe "java::oracle"

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

user "ice" do
  comment "ice system user"
  system true
  shell "/bin/false"
end

directory node[:ice][:base_dir] do
  owner "root"
  mode 0755
  action :create
end

directory node[:ice][:log_dir] do
  owner "ice"
  mode 0755
  action :create
end

directory node[:ice][:processor][:log_dir] do
  owner "ice"
  mode 0755
  action :create
end

directory node[:ice][:reader][:log_dir] do
  owner "ice"
  mode 0755
  action :create
end

directory node[:ice][:home_dir] do
  owner "ice"
  mode 0755
  action :create
  recursive true
end

ark "grails" do
  url "https://mmcclean-sw-assets.s3.amazonaws.com/grails-2.2.1.zip"
end

service "ice" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true
end

template "ice.upstart.conf" do
  path "/etc/init/ice.conf"
  source "ice.upstart.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "ice")
end

service "ice" do
  action [:enable, :start]
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
