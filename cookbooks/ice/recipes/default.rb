include_recipe "java::oracle"
include_recipe "sudo"
include_recipe "htpasswd"

package "nginx" do
  action :install
end

# add user "foo" with password "bar" to "/etc/nginx/htpassword"
htpasswd "#{node[:nginx][:conf_dir]}/htpassword" do
  user "foo"
  password "bar"
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
  home node[:ice][:home_dir]
  system true
  shell "/bin/false"
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

ark "grails" do
  url "https://mmcclean-sw-assets.s3.amazonaws.com/grails-2.2.1.zip"
  version "2.2.1"
  has_binaries [ 'bin/grails', 'bin/grails-debug', 'bin/startGrails' ]
  action :install
end

ENV['GRAILS_HOME'] = node[:grails][:home_dir]
file "/etc/profile.d/grails.sh" do
  content "export GRAILS_HOME=#{node[:grails][:home_dir]}"
  mode 0755
end

ENV['ICE_HOME'] = node[:ice][:home_dir]
file "/etc/profile.d/ice.sh" do
  content "export ICE_HOME=#{node[:ice][:home_dir]}"
  mode 0755
end

ark "ice" do
  url "https://github.com/Netflix/ice/tarball/master"
  owner "ice"
  extension "tar.gz"
  version "master"
  action :install
end

execute "setup_grails" do
  command "grails wrapper 2>&1 >> #{node[:ice][:log_dir]}/grails-wrapper.log"
  cwd node[:ice][:home_dir]
  environment 'GRAILS_HOME' => node[:grails][:home_dir]
  user "ice"
  action :run
  not_if { ::File.exists?("#{node[:ice][:home_dir]}/.grails")}
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
end

template "ice.properties" do
  path "#{node[:ice][:home_dir]}/src/java/ice.properties"
  source "ice.properties.erb"
  owner "ice"
  mode "0644"
end

service "ice" do
  action [:enable, :stop]
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
