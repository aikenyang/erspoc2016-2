#install JSON parser- jp
bash "install_jp" do
  user "root"
  code <<-EOF
	wget http://stedolan.github.io/jq/download/linux64/jq
	chmod +x ./jq
	sudo cp jq /usr/bin
  EOF
end

#receive message from SQS
bash "get_ip_from_sqs" do
  user "root"
  code <<-EOF
    ip1=$(aws sqs receive-message --queue-url https://sqs.us-east-1.amazonaws.com/595704032741/mongod-az1 --max-number-of-messages 1 --region us-east-1)
	host1=$(echo $ip1 | /usr/bin/jq '.Messages[0].Body')
	host1=$(echo $host1|sed 's/\"//g')
	host1="'$host1:27017'"
	
	ip2=$(aws sqs receive-message --queue-url https://sqs.us-east-1.amazonaws.com/595704032741/mongod-az1 --max-number-of-messages 1 --region us-east-1)
	host2=$(echo $ip2 | /usr/bin/jq '.Messages[0].Body')
	host2=$(echo $host2|sed 's/\"//g')
	host2="'$host2:27017'"
	
	ip0=$(curl http://169.254.169.254/latest/meta-data/local-ipv4/)
	host0="$ip0:27017"
	str=$"cfg = {_id:'RS1', members:[{_id:0, host:'"$host0"'}, {_id:1, host:"$host1"}]}"
	echo $str > init.js
	echo 'rs.initiate(cfg)' >> init.js
  EOF
end


#initial replica set
bash "init_replicaSet" do
  user "root"
  code <<-EOF
	mongo admin init.js
  EOF
end