cookbook_file "/etc/yum.repos.d/mongodb-org-3.2.repo" do
  source "mongodb-org-amazon-3.2.repo"
  mode 0644
  action :create_if_missing
end

yum_package 'mongodb-org' do
	action :install
	version '3.2.6'
end

yum_package 'mongodb-org-server' do
	action :install
	version '3.2.6'
end

yum_package 'mongodb-org-shell' do
	action :install
	version '3.2.6'
end

yum_package 'mongodb-org-mongos' do
	action :install
	version '3.2.6'
end

yum_package 'mongodb-org-tools' do
	action :install
	version '3.2.6'
end
     
