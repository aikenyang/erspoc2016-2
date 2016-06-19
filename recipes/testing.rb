#require 'aws-sdk'

#region = node["opsworks"]["instance"]["region"]
#hostname = node["opsworks"]["instance"]["hostname"]

#Chef::Log.info("deploy #{region}")
#Chef::Log.info("deploy #{hostname}")

Chef::Log.info("******Creating a data directory.******")

bash "echo something" do
   code <<-EOF
     echo 'I am a chef!'
   EOF
end