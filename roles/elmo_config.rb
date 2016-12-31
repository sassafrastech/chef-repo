name "elmo_config"
description "This role sets up ELMO's config files"
run_list(
  "role[base]",
  "recipe[elmo::config]"
)
