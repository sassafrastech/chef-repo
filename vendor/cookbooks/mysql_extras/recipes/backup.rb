git "/opt/db-backup" do
  repository "https://github.com/sassafrastech/db-backup.git"
  revision "master"
  action :sync
end

cron "mysql_backup" do
  minute "0"
  user "root"
  rootpwd = node[:mysql][:root_password]
  dump_command = "mysqldump -u root -p#{rootpwd} -h 127.0.0.1 elmo"
  command %Q{/bin/bash -l -c '/opt/db-backup/db-backup.rb ./db-backups "#{dump_command}" >> backup.log 2>&1'}
end
