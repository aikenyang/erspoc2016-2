#receive message from SQS
bash "get_ip_from_sqs" do
  user "root"
  code <<-EOF
    ipJson=$(aws sqs receive-message --queue-url https://sqs.us-east-1.amazonaws.com/595704032741/mongod-az1 --max-number-of-messages 1 --region us-east-1)
	sec1=$(echo $ipJson | /usr/bin/jq '.Messages[0].Body')
	sec1=$(echo $sec1|tr \" ' ')
	sec1="'$sec1:27017'"
	

  EOF
end


#initial replica set
bash "init_replicaSet" do
  user "root"
  code <<-EOF
    ip1=$(curl http://169.254.169.254/latest/meta-data/local-ipv4/)
	host1="$ip1:27017"
	str=$"cfg = {_id:'abc', members:[{_id:0, host:'"$host1"'}, {_id:1, host:'10.10.0.138:27017'}]}"
	echo $str > init.js
	echo 'rs.initiate(cfg)' >> init.js
	mongo admin init.js
  EOF
end