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
   not_if "grep -q 32000 /etc/security/limits.conf"
 end

 cookbook_file "/etc/security/limits.d/90-nproc.conf" do
  source "90-nproc.conf"
  mode 0644
  action :create_if_missing
end
 
 cookbook_file "/etc/udev/rules.d/85-ebs.rules" do
  source "85-ebs.rules"
  mode 0644
  action :create_if_missing
end 
 
cookbook_file "/etc/init.d/disable-transparent-hugepages" do
  source "disable-transparent-hugepages"
  mode 0755
  action :create_if_missing
end 
 
yum_package 'mongodb-org' do
	action :install
	version '3.2.6-1.amzn1'
end

directory "/data/" do
  mode 0755
  owner 'mongod'
  group 'mongod'
  action :create
end 

cookbook_file "/etc/mongod.conf" do
  source "mongod.conf"
  mode 0644
  action :create
end 

cookbook_file "/data/keyfile" do
  source "keyfile"
  owner 'mongod'
  group 'mongod'
  mode 0600
  action :create_if_missing
end 