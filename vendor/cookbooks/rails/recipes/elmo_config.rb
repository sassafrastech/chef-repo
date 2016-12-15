applications_root = node[:rails][:applications_root]

if node[:active_applications]
  node[:active_applications].each do |app, app_info|
    config_dir = "#{applications_root}/#{app}/shared/config"
    directory config_dir do
      owner "deploy"
      group "deploy"
      recursive true
    end

    template "#{config_dir}/local_config.rb" do
      source "elmo_config.rb.erb"
      owner "deploy"
      group "deploy"
      mode 0600
      variables app_info["config"]
    end

    template "#{config_dir}/thinking_sphinx.yml" do
      source "thinking_sphinx.yml"
      owner "deploy"
      group "deploy"
      mode 0600
    end
  end
end
