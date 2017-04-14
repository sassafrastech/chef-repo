applications_root = node[:rails][:applications_root]

if node[:active_applications]
  node[:active_applications].each do |app, app_info|
    shared_dir = "#{applications_root}/#{app}/shared"
    config_dir = "#{shared_dir}/config"
    elmo_config = app_info["elmo_config"]

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
      variables elmo_config
    end

    template "#{config_dir}/thinking_sphinx.yml" do
      source "thinking_sphinx.yml"
      owner "deploy"
      group "deploy"
      mode 0600
    end

    if theme = elmo_config["theme"]
      variables_dir = "#{shared_dir}/app/assets/stylesheets/all/variables"
      images_dir = "#{shared_dir}/app/assets/images"

      [variables_dir, images_dir].each do |dir|
        directory dir do
          owner "deploy"
          group "deploy"
          recursive true
        end
      end

      cookbook_file "#{variables_dir}/_theme.scss" do
        source "themes/#{theme}/_theme.scss"
        owner "deploy"
        group "deploy"
        mode 0600
        action :create
      end

      cookbook_file "#{images_dir}/logo-override.png" do
        source "themes/#{theme}/logo.png"
        owner "deploy"
        group "deploy"
        mode 0600
        action :create
      end
    end
  end
end
