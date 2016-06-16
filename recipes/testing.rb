region = node["opsworks"]["instance"]["region"]
hostname = node["opsworks"]["instance"]["hostname"]
environment_type = node["deploy"]["arq"]["environment_variables"]["environment_type"]

file '/tmp/file' do
  content "region=#{region}; hostname=#{hostname}; environment_type=#{environment_type}"
end