require 'spec_helper'

%w{gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel git}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe command('~/.rbenv/shims/ruby -v') do
  its(:stdout) { should match /2\.7\.3/ }
end

describe command('source ~/.nvm/nvm.sh &&  node -v') do
  its(:stdout) { should match /15\.11\.0/ }
end

describe command('source ~/.nvm/nvm.sh && npm -v') do
  its(:stdout) { should match /7\.6\.0/ }
end

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port("80") do
  let(:disable_sudo) { false }
  it { should be_listening }
end

# sock
describe file('/var/www/app/rails/tmp/sockets/.unicorn.sock') do
  it { should be_socket }
end

describe command('ps aux | grep unicorn') do
  its(:stdout) { should match /unicorn_rails/ }
end

describe file('/var/www/app/react/static') do
  it { should exist }
end

describe file('/etc/nginx/conf.d/app.conf') do
  it { should be_file }
end

#describe file('/var/www/app/rails/config/unicorn.conf.rb') do
#  it { should be_file }
#end

describe command('curl http://52.194.191.132/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end

# Serverspecがどの権限で実行されているかを確認
describe command('whoami') do
  its(:stdout) { should match "ec2-user" }
end
