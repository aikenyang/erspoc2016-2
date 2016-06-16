region = node["opsworks"]["instance"]["region"]
hostname = node["opsworks"]["instance"]["hostname"]
#environment_type = node["deploy"]["arq"]["environment_variables"]["environment_type"]

file '/tmp/file' do
  #content 'region=#{region}; hostname=#{hostname}; environment_type=#{environment_type}'
  content 'region=#{region}; hostname=#{hostname}}'
  mode '0755'
  owner 'root'
  grout 'root'
end