ruby_block "Find-VM-Hostname" do
   block do
     require 'rexml/document'
     require 'net/http'
     url = 'http://chef-workstation/services.xml'
     file = Net::HTTP.get_response(URI.parse(url)).body
     doc = REXML::Document.new(file)
     REXML::XPath.each(doc, "service_parameters/parameter") do |element|
     if element.attributes["name"].include?"Hostname"
        fqdn = element.attributes["value"]  #this statement does not give value to fqdn
     end
     end
    end
    action :nothing
end
if fqdn
  fqdn = fqdn.sub('*', node.name)
  fqdn =~ /^([^.]+)/
  hostname = Regexp.last_match[1]

  case node['platform']
   when 'freebsd'
    directory '/etc/rc.conf.d' do
      mode '0755'
    end

    file '/etc/rc.conf.d/hostname' do
      content "hostname=#{fqdn}\n"
      mode '0644'
      notifies :reload, 'ohai[reload]'
     end
   else
    file '/etc/hostname' do
       content "#{hostname}\n"
       mode '0644'
       notifies :reload, 'ohai[reload]', :immediately
    end
end