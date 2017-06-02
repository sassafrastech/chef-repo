name "rails_passenger"
description "This role configures a Rails stack using Passenger"
run_list(
  "role[base]",
  "recipe[packages]",
  "recipe[rails::passenger]",
  #"recipe[rails::letsencrypt]", <-- This is broken and needs to be redone using newer methods.
  "recipe[ruby_build]",
  "recipe[rbenv]",
  "recipe[rails::databases]",
  "recipe[rails::env_vars]",
  "recipe[rails::delayed_job_service]",
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
