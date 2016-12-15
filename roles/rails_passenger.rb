name "rails_passenger"
description "This role configures a Rails stack using Passenger"
run_list(
  "role[base]",
  "recipe[packages]",
  "recipe[rails::passenger]",
  "recipe[rails::letsencrypt]",
  "recipe[ruby_build]",
  "recipe[rails::mysql]",
  "recipe[rails::mysql_timezones]",
  "recipe[rails::mysql_backup]",
  "recipe[rails::elmo_config]",
  "recipe[rbenv]",
  "recipe[rails::databases]",
  "recipe[rails::env_vars]",
  "recipe[git]",
  "recipe[ssh_deploy_keys]",
  "recipe[apt::unattended-upgrades]"
)

default_attributes(
  "nginx" => { "server_tokens" => "off", "package_name" => "nginx-extras" },
  "rbenv" => {
    "group_users" => ["deploy"]
  },
  "deploy_users" => ["deploy"]
)
