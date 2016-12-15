mysql_client "default" do
  action :create
end

mysql_service "default" do
  version "5.7"
  bind_address "127.0.0.1"
  initial_root_password node[:mysql][:root_password]
  action [:create, :start]
end

# Install the mysql2 Ruby gem.
mysql2_chef_gem "default" do
  action :install
end
