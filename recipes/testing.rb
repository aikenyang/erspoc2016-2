require 'aws-sdk'

region = node["opsworks"]["instance"]["region"]
hostname = node["opsworks"]["instance"]["hostname"]

Chef::Log.info("deploy #{region}")
Chef::Log.info("deploy #{hostname}")