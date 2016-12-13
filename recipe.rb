include_recipe "selinux::disabled"

# AWS consoleで80番ポートを開ける
# ssh ec2-user@54.152.105.95 -i ~/Downloads/redmine.pem
# install "Development Tools"

execute "install development tools" do
  user "root"
  command "yum -y groupinstall 'Development Tools'"
end


# yum -y install openssl-devel readline-devel zlib-devel curl-devel libyaml-devel libffi-devel
%w(
  openssl-devel
  readline-devel
  zlib-devel
  libcurl-devel
  libyaml-devel
  libffi-devel
).each do |pkg|
  package pkg
end


# yum -y install postgresql-server postgresql-devel
%w(
  postgresql-server
  postgresql-devel
).each do |pkg|
  package pkg
end

# yum -y install httpd httpd-devel
package "httpd"
package "httpd-devel"

# yum -y install ImageMagick ImageMagick-devel ipa-pgothic-fonts
package "ImageMagick"
package "ImageMagick-devel"
package "ipa-pgothic-fonts"
__END__
# ruby

%w(
  epel-release gcc bzip2 openssl-devel libyaml-devel libffi-devel readline-devel
  zlib-devel gdbm-devel ncurses-devel
).each do |pkg|
  package pkg
end

execute "curl -O https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.3.tar.gz"
execute "tar xvf ruby-2.3.3.tar.gz"
execute "cd ruby-2.3.3"
execute "./configure --disable-install-doc"
execute "make"
execute "make install"