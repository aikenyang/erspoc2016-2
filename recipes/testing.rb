#check hostname number if primary

#hostname format: ers-dev-instancename001-timstamp
#hostname = node["opsworks"]["instance"]["hostname"]
region = node["opsworks"]["instance"]["region"]
Chef::Log.info("##### the hostname is #{region} ######")

id = region.split(",")
id = #{id[2]}

Chef::Log.info("##### the hostname is #{id} ######")

#Chef::Log.info("deploy #{hostname}")

Chef::Log.info("******Creating a data directory.******")

bash "echo something" do
   code <<-EOF
     echo "I am a #{region}"
	 touch /tmp/#{region}.txt
   EOF
end
