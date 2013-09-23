include_recipe "java::oracle"
include_recipe "sudo"

package "nginx" do
  action :install
end

package "unzip" do
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
  home "/home/ice"
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

directory node[:ice][:processor][:local_dir] do
  owner "ice"
  mode 0755
  action :create
end

directory node[:ice][:reader][:local_dir] do
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
  version "2.2.1"
  has_binaries [ 'bin/grails', 'bin/grails-debug', 'bin/startGrails' ]
  action :install
end

#execute "create_grails_env" do
#  command "echo \"GRAILS_HOME=/usr/local/grails\" | sudo tee /etc/profile.d/grails.sh && sudo chmod 777 /etc/profile.d/grails.sh"
#  not_if { ::File.exists?("/etc/profile.d/grails.sh") }
#  user "root"
#  action :run
#end

ark "ice" do
  url "https://github.com/Netflix/ice/tarball/master"
  owner "ice"
  extension "tar.gz"
  version "master"
  action :install
end

execute "setup_grails" do
  command "grails wrapper 2>&1 >> /var/log/ice/grails-wrapper.log"
  cwd "/usr/local/ice"
  environment 'GRAILS_HOME' => "/usr/local/grails"
  user "ice"
  action :run
  not_if { ::File.exists?("/home/ice/.grails")}
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
