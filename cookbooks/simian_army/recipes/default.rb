include_recipe "java::oracle"

package "unzip" do
  action :install
end

package "git" do
  action :install
end

user node[:simian_army][:user] do
  comment "simian army user"
  home node[:simian_army][:home_dir]
  system true
  shell "/bin/false"
end

directory node[:simian_army][:home_dir] do
  owner node[:simian_army][:user]
  mode 0755
  action :create
end

directory node[:simian_army][:log_dir] do
  owner node[:simian_army][:user]
  mode 0755
  action :create
end

#ark "grails" do
#  url "https://mmcclean-sw-assets.s3.amazonaws.com/grails-2.2.1.zip"
#  version "2.2.1"
#  has_binaries [ 'bin/grails', 'bin/grails-debug', 'bin/startGrails' ]
#  action :install
#end

#ENV['GRAILS_HOME'] = node[:grails][:home_dir]
#file "/etc/profile.d/grails.sh" do
#  content "export GRAILS_HOME=#{node[:grails][:home_dir]}"
#  mode 0755
#end

#ark "simianarmy" do
#  url "https://github.com/Netflix/SimianArmy/tarball/master"
#  owner "#{node[:simian_army][:user]}"
#  extension "tar.gz"
#  version "latest"
#  action :install
#end

git "#{node[:simian_army][:home_dir]}" do
  repository "https://github.com/Netflix/SimianArmy.git"
  reference "master"
  user node[:simian_army][:user]
  action :sync
end

execute "setup_army" do
  command "./gradlew build 2>&1 >> #{node[:simian_army][:log_dir]}/grails-build.log"
  cwd node[:simian_army][:home_dir]
  user node[:simian_army][:user]
  action :run
  not_if { ::File.exists?("#{node[:simian_army][:home_dir]}/.gradle")}
end

%w(client chaos simianarmy janitor conformity).each do |config_file|
  template "#{config_file}.properties" do
    path "#{node[:simian_army][:home_dir]}/src/main/resources/#{config_file}.properties"
    source "#{config_file}.properties.erb"
    owner node[:simian_army][:user]
    mode "0644"
  end
end

template "simian.upstart.conf" do
  path "/etc/init/simianarmy.conf"
  source "simian.upstart.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

#service "simianarmy" do
#  action [:enable]
#end

