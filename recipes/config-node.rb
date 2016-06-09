#install JSON parser- jp
bash "install_jp" do
  user "root"
  code <<-EOF
	wget http://stedolan.github.io/jq/download/linux64/jq
	chmod +x ./jq
	sudo cp jq /usr/bin
  EOF
end

#generate the replica set config file 'init.js'
bash "gen_init.js" do
  user "root"
  code <<-EOF
	ip1=$(aws sqs receive-message --queue-url https://sqs.us-east-1.amazonaws.com/595704032741/mongod-az1 --max-number-of-messages 1 --region us-east-1)
	host1=$(echo $ip1 | /usr/bin/jq '.Messages[0].Body')
	host1=$(echo $host1|sed 's/\"//g')
	#host1="11.2.3.4"

	ip2=$(aws sqs receive-message --queue-url https://sqs.us-east-1.amazonaws.com/595704032741/mongod-az1 --max-number-of-messages 1 --region us-east-1)
	host2=$(echo $ip2 | /usr/bin/jq '.Messages[0].Body')
	host2=$(echo $host2|sed 's/\"//g')
	#host2="11.2.3.4"
		
	for (( i=1; i<=5; i++ ))
	do
	 echo "try $i time(s)..."
	 if [ ! -z $host1 ] && [ ! -z $host2 ]; then
	  host1="'$host1:27017'"
	  host2="'$host2:27017'"
	  #echo "host1 is $host1"
	  #echo "host2 is $host2"
	  
	  ip0=$(curl http://169.254.169.254/latest/meta-data/local-ipv4/)
	  host0="$ip0:27017"
	  
	  str=$"cfg = {_id:'RS1', members:[{_id:0, host:'"$host0"'}, {_id:1, host:"$host1"}, {_id:2, host:"$host2"}]}"
	  echo $str > /data/init.js
	  echo 'rs.initiate(cfg)' >> /data/init.js
	  
	  break
	 else
	  echo "one of them is not ready"
	  sleep 60
	 fi
	done

  EOF
end


#initial replica set
bash "init_replicaSet" do
  user "root"
  code <<-EOF
	mongo admin /data/init.js
  EOF
end