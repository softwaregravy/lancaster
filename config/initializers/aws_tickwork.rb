require 'aws_tickwork'

AwsTickwork::Engine.setup do |c|
  c.https_only = true
  c.http_username = 'aws'
  # Digest::MD5.hexdigest(["aws", AwsTickwork::REALM, password].join(":"))
  c.http_password = '572d9b6e19967396e3acbfd56687bc13'
end

