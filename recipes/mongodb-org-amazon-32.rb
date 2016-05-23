cookbook_file "/etc/yum.repos.d/mongodb-org-3.2.repo" do
  source "mongodb-org-amazon-3.2.repo"
  mode 0644
  action :create_if_missing
end

 cookbook_file "/tmp/parms_to_append.conf" do
   source "limits.conf"
 end

 bash "append_to_config" do
   user "root"
   code <<-EOF
      cat /tmp/parms_to_append.conf >> /etc/security/limits.conf
      rm /tmp/parms_to_append.conf
   EOF
   not_if "grep -q nproc /etc/security/limits.conf"
 end

yum_package 'mongodb-org' do
	action :install
	version '3.2.6-1.amzn1'
end
