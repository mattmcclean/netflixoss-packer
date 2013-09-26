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

git node[:simian_army][:home_dir] do
  repository "https://github.com/Netflix/SimianArmy.git"
  reference "master"
  user node[:simian_army][:user]
  action :sync
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


