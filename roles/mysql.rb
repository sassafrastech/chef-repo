name "mysql"
description "This role sets up a MySQL database with timezones and local backup"
run_list(
  "role[base]",
  "recipe[mysql::mysql]",
  "recipe[mysql::timezones]",
  "recipe[mysql::backup]"
)
