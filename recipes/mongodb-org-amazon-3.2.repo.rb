template '/etc/yum.repos.d/mongodb-org-3.2.repo' do
  source 'mongodb-org-amazon-3.2.repo.erb'
  owner 'root'
  group 'root'
  mode 0644
end

package 'mongodb-org-3.2.6' do
	action :install
end

package 'mongodb-org-server-3.2.6' do
	action :install
end

package 'mongodb-org-shell-3.2.6' do
	action :install
end

package 'mongodb-org-mongos-3.2.6' do
	action :install
end

package 'mongodb-org-tools-3.2.6' do
	action :install
end
     