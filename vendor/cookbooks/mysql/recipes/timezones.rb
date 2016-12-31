logfile = "/var/log/tzimport.log"
rootpwd = node[:mysql][:root_password]
execute "mysql_timezones" do
  command "mysql_tzinfo_to_sql /usr/share/zoneinfo 2> #{logfile} | mysql -u root -p#{rootpwd} -h 127.0.0.1 mysql"
  not_if { ::File.exist?(logfile) }
end
