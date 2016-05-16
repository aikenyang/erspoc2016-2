cookbook_file "/etc/yum.repos.d/mongodb-org-3.2.repo" do
  source "mongodb-org-amazon-3.2.repo"
  mode 0644
  action :create_if_missing
end

yum_package 'mongodb-org-3.2.6' do
	action :install
end

yum_package 'mongodb-org-server-3.2.6' do
	action :install
end

yum_package 'mongodb-org-shell-3.2.6' do
	action :install
end

yum_package 'mongodb-org-mongos-3.2.6' do
	action :install
end

yum_package 'mongodb-org-tools-3.2.6' do
	action :install
end
     
