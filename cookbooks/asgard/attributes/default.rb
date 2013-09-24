
default[:asgard][:base_dir] = "/opt/asgard"
default[:asgard][:log_dir] = "/var/log/asgard"
default[:asgard][:home_dir] = "/home/asgard/.asgard"
default[:asgard][:java_options] = "-Xmx1024M -XX:MaxPermSize=128m"

default[:asgard][:aws_account_id] = "123456789012"
default[:asgard][:aws_access_key] = "ABCDEFGHIJKL"
default[:asgard][:aws_secret_key] = "ABCDEFGHIJKL"
default[:asgard][:aws_env_name] = "prod"

default[:java][:jdk_version] = 6
default[:java][:oracle][:accept_oracle_download_terms] = true

default[:nginx][:conf_dir] = "/etc/nginx"
default[:nginx][:username] = "foo"
default[:nginx][:password] = "bar"

