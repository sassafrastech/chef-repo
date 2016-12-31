name "mysql"
description "This role sets up a MySQL database with timezones and local backup"
run_list(
  "role[base]",
  "recipe[mysql_extras::init]",
  "recipe[mysql_extras::timezones]",
  "recipe[mysql_extras::backup]"
)
