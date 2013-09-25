
default[:simian_army][:home_dir] = "/usr/local/simianarmy"
default[:simian_army][:log_dir] = "/var/log/simianarmy"
default[:simian_army][:user] = "monkey"

default[:simian_army][:aws][:region] = "eu-west-1"

default[:simian_army][:sdb_domain] = "SIMIAN_ARMY"

default[:simian_army][:scheduler][:frequency] = 1
default[:simian_army][:scheduler][:frequencyUnit] = "HOURS"
default[:simian_army][:scheduler][:threads] = 1

default[:simian_army][:calendar][:isMonkeyTime] = true
default[:simian_army][:calendar][:openHour] = 0
default[:simian_army][:calendar][:closeHour] = 0
default[:simian_army][:calendar][:timezone] = "Europe/Dublin"

default[:simian_army][:chaos][:enabled] = true
default[:simian_army][:chaos][:leashed] = true
default[:simian_army][:chaos][:terminateOndemand][:enabled] = false
default[:simian_army][:chaos][:mandatoryTermination][:enabled] = false
default[:simian_army][:chaos][:ASG][:enabled] = false
default[:simian_army][:chaos][:ASG][:probability] = 1.0
default[:simian_army][:chaos][:ASG][:maxTerminationsPerDay] = 1.0

default[:simian_army][:chaos][:notification][:enabled] = false
default[:simian_army][:chaos][:notification][:sourceEmail] = "from.someone@email.com"
default[:simian_army][:chaos][:notification][:global][:enabled]= true
default[:simian_army][:chaos][:notification][:global][:receiverEmail]= "john.recipient@email.com"
default[:simian_army][:chaos][:notification][:subject][:prefix]= "Chaos Monkey Notification: "
default[:simian_army][:chaos][:notification][:subject][:suffix]= ""
default[:simian_army][:chaos][:notification][:body][:prefix]= "Chaos Monkey Notification: "
default[:simian_army][:chaos][:notification][:body][:suffix]= ""
default[:simian_army][:chaos][:notification][:subject][:isBody]= true

default[:simian_army][:janitor][:calendar][:openHour] = 11
default[:simian_army][:janitor][:calendar][:closeHour] = 11
default[:simian_army][:janitor][:enabled] = true
default[:simian_army][:janitor][:leashed] = true
default[:simian_army][:janitor][:sdb_domain] = "SIMIAN_ARMY"
default[:simian_army][:janitor][:notification][:enabled] = false
default[:simian_army][:janitor][:notification][:sourceEmail] = "foo@bar.com"
default[:simian_army][:janitor][:notification][:defaultEmail] = "foo@bar.com"
default[:simian_army][:janitor][:notification][:daysBeforeTermination] = 2
default[:simian_army][:janitor][:summary][:emailTo] = "foo@bar.com"
default[:simian_army][:janitor][:enabledResources] = "Instance, ASG, EBS_Volume, EBS_Snapshot, Launch_Config, Image"

default[:simian_army][:janitor][:rule][:orphanedInstanceRule][:enabled] = true
default[:simian_army][:janitor][:rule][:orphanedInstanceRule][:instanceAgeThreshold] = 2
default[:simian_army][:janitor][:rule][:orphanedInstanceRule][:retentionDaysWithOwner] = 3
default[:simian_army][:janitor][:rule][:orphanedInstanceRule][:retentionDaysWithoutOwner] = 8

default[:simian_army][:janitor][:rule][:oldDetachedVolumeRule][:enabled] = true
default[:simian_army][:janitor][:rule][:oldDetachedVolumeRule][:detachDaysThreshold] = 30
default[:simian_army][:janitor][:rule][:oldDetachedVolumeRule][:retentionDays] = 7

default[:simian_army][:janitor][:rule][:noGeneratedAMIRule][:enabled] = true
default[:simian_army][:janitor][:rule][:noGeneratedAMIRule][:ageThreshold] = 30
default[:simian_army][:janitor][:rule][:noGeneratedAMIRule][:retentionDays] = 7

default[:simian_army][:janitor][:rule][:oldEmptyASGRule][:enabled] = true
default[:simian_army][:janitor][:rule][:oldEmptyASGRule][:launchConfigAgeThreshold] = 50
default[:simian_army][:janitor][:rule][:oldEmptyASGRule][:retentionDays] = 10

default[:simian_army][:janitor][:rule][:suspendedASGRule][:enabled] = true
default[:simian_army][:janitor][:rule][:suspendedASGRule][:suspensionAgeThreshold] = 2
default[:simian_army][:janitor][:rule][:suspendedASGRule][:retentionDays] = 5

default[:simian_army][:janitor][:rule][:oldUnusedLaunchConfigRule][:enabled] = true
default[:simian_army][:janitor][:rule][:oldUnusedLaunchConfigRule][:ageThreshold] = 4
default[:simian_army][:janitor][:rule][:oldUnusedLaunchConfigRule][:retentionDays] = 3

default[:simian_army][:janitor][:rule][:unusedImageRule][:enabled] = true
default[:simian_army][:janitor][:rule][:unusedImageRule][:lastReferenceDaysThreshold] = 45
default[:simian_army][:janitor][:rule][:unusedImageRule][:retentionDays] = 3
default[:simian_army][:janitor][:rule][:image_crawler_lookbackdays] = 60

default[:simian_army][:conformity][:calendar][:openHour] = 0
default[:simian_army][:conformity][:calendar][:closeHour] = 24
default[:simian_army][:conformity][:enabled] = true
default[:simian_army][:conformity][:leashed] = true
default[:simian_army][:conformity][:sdb_domain] = "SIMIAN_ARMY"
default[:simian_army][:conformity][:notification][:sourceEmail] = "foo@bar.com"
default[:simian_army][:conformity][:notification][:defaultEmail] = "foo@bar.com"
default[:simian_army][:conformity][:summary][:emailTo] = "foo@bar.com"

default[:simian_army][:conformity][:rule][:SameZonesInElbAndAsg][:enabled] = true

default[:simian_army][:conformity][:rule][:InstanceInSecurityGroup][:enabled] = true
default[:simian_army][:conformity][:rule][:InstanceInSecurityGroup][:requiredSecurityGroups] = "foo,bar"

default[:simian_army][:conformity][:rule][:InstanceTooOld][:enabled] = true
default[:simian_army][:conformity][:rule][:InstanceTooOld][:instanceAgeThreshold] = 180

default[:simian_army][:conformity][:rule][:InstanceInVPC][:enabled] = true

default[:simian_army][:conformity][:rule][:InstanceHasStatusUrl][:enabled] = false
default[:simian_army][:conformity][:rule][:InstanceHasHealthCheckUrl][:enabled] = false
default[:simian_army][:conformity][:rule][:CheckSoloInstances][:enabled] = true

default[:java][:jdk_version] = 6
default[:java][:oracle][:accept_oracle_download_terms] = true


