git "/opt/db-backup" do
  repository "https://github.com/sassafrastech/db-backup.git"
  revision "master"
  action :sync
end

cron "mysql_backup" do
  minute "0"
  user "deploy"
  rootpwd = node[:mysql][:server_root_password]
  dump_command = "mysqldump -u root -p#{rootpwd} elmo"
  command %Q{/bin/bash -l -c '/opt/db-backup/db-backup.rb ./db-backups "#{dump_command}" >> backup.log 2>&1'}
end
