
default[:ice][:base_dir] = "/opt/ice"
default[:ice][:log_dir] = "/var/log/ice"
default[:ice][:home_dir] = "/home/ice/"
default[:ice][:java_options] = "-Xmx1024M -XX:MaxPermSize=128m"

default[:ice][:aws_account_id] = "123456789012"
default[:ice][:aws_access_key] = "ABCDEFGHIJKL"
default[:ice][:aws_secret_key] = "ABCDEFGHIJKL"


default[:ice][:company_name] = 'Matt McClean'
default[:ice][:processor][:enabled] = true
default[:ice][:processor][:local_dir] = '/var/ice_processor'

default[:ice][:reader][:enabled] = true
default[:ice][:reader][:local_dir] = '/var/ice_reader'

default[:ice][:work_s3_bucket_name] = 'work_s3bucketname'
default[:ice][:work_s3_bucket_prefix] = 'work_s3bucketprefix'
default[:ice][:start_millis] = 1364774400000

default[:java][:jdk_version] = 6
default[:java][:oracle][:accept_oracle_download_terms] = true

default[:nginx][:conf_dir] = "/etc/nginx"

default[:authorization][:sudo][:sudoers_defaults] = [
	'env_reset',
	'secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"',
	'env_keep = "JAVA_HOME GRAILS_HOME"'
]
