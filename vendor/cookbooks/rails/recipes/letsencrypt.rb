domains = node[:active_applications].map { |_, info| info[:domain_names] }.reduce(:+)
site = domains.first # Only supporting one domain for now.

package "letsencrypt"
package "openssl"

cert_dir = "/etc/letsencrypt/live/#{site}"
acme_challenge_dir = "/var/www/letsencrypt"

directory cert_dir do
  recursive true
end

directory acme_challenge_dir do
  recursive true
end

# Generate temporary self signed cert so that nginx doesn't complain
execute "self_signed" do
  cwd cert_dir
  not_if { ::File.exist?("#{cert_dir}/fullchain.pem") }
  command %Q{
    openssl genrsa -des3 -passout pass:x -out privkey.pass.pem 2048 &&
    openssl rsa -passin pass:x -in privkey.pass.pem -out privkey.pem &&
    rm privkey.pass.pem &&
    openssl req -new -key privkey.pem -out server.csr \
      -subj "/C=US/ST=Michigan/L=Ann Arbor/O=Sassafras Tech Collective./OU=/CN=#{site}" &&
    openssl x509 -req -days 365 -in server.csr -signkey privkey.pem -out fullchain.pem &&
    rm server.csr &&
    touch selfsigned
  }
  notifies :reload, "service[nginx]", :immediate
end

execute "real_cert" do
  command "rm -rf #{cert_dir} &&
    letsencrypt certonly --webroot --noninteractive -w #{acme_challenge_dir} \
      --agree-tos --email #{node[:letsencrypt][:email]} -d #{site}"
  only_if { ::File.exist?("#{cert_dir}/selfsigned") }
  notifies :reload, "service[nginx]", :immediate
end

cron "letsencrypt_renewal" do
  minute (Digest::MD5.hexdigest(site).hex % 60).to_s # Consistent but random minute based on domain name.
  user "root"
  command "/usr/bin/letsencrypt renew --agree-tos > /dev/null 2>&1"
end
