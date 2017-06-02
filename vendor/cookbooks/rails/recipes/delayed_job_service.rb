node[:active_applications].each do |app, app_info|
  directory "/etc/systemd/system" do
    owner "root"
    group "root"
    recursive true
  end

  svc_name = "delayed-job-#{app}"

  template "/etc/systemd/system/#{svc_name}.service" do
    source "delayed-job.service.erb"
    owner "root"
    group "root"
    mode 0600
    variables({
      app: app,
      current_dir: "#{node['rails']['applications_root']}/#{app}/current"
    })
  end

  execute "daemon-reload" do
    command "/bin/systemctl daemon-reload"
  end

  execute "enable" do
    command "/bin/systemctl enable #{svc_name}"
  end

  execute "restart" do
    command "/bin/systemctl restart #{svc_name}"
  end
end
