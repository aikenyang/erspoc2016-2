#send instance meta data to sqs
bash "add_metadata_to_sqs" do
  user "root"
  code <<-EOF
    var=$(curl http://169.254.169.254/latest/meta-data/local-ipv4/)
    aws sqs send-message --queue-url https://sqs.us-east-1.amazonaws.com/595704032741/mongod-az1 --message-body $var --region us-east-1
  EOF
end