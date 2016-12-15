require 'spec_helper'

describe selinux do
  it { should be_disabled }
end

# yum -y groupinstall "Development Tools"
%w(
  autoconf
  automake
  binutils
  bison
  flex
  gcc
  gcc-c++
  gettext
  libtool
  make
  patch
  pkgconfig
  rpm-build
  byacc
  cscope
  ctags
  diffstat
  doxygen
  elfutils
  gcc-gfortran
  git
  indent
  intltool
  patchutils
  rcs
  subversion
  swig
  systemtap
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# Ruby
# yum -y install openssl-devel readline-devel zlib-devel curl-devel libyaml-devel libffi-devel
%w(
  openssl-devel
  readline-devel
  zlib-devel
  libcurl-devel
  libyaml-devel
  libffi-devel
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# yum -y install postgresql-server postgresql-devel
%w(
  postgresql92-server-compat-9.2.18-1.59.amzn1.x86_64
  postgresql92-devel-9.2.18-1.59.amzn1.x86_64
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# yum -y install httpd httpd-devel
%w(
  httpd-2.2.31-1.8.amzn1.x86_64
  httpd-devel-2.2.31-1.8.amzn1.x86_64
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# yum -y install ImageMagick ImageMagick-devel ipa-pgothic-fonts
%w(
  ImageMagick
  ImageMagick-devel
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# rubyのインストール
# yum -y install gdbm-devel epel-release
%w(
  epel-release gcc bzip2 openssl-devel libyaml-devel libffi-devel readline-devel
  zlib-devel gdbm-devel ncurses-devel
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe command("ruby -v") do
  let(:disable_sudo) { true }
  its(:stdout) { should match /ruby 2\.3\.3p.+/ }
end

describe file("/var/lib/pgsql9/data/pg_hba.conf") do
  its(:content) { should match /host    redmine         redmine         127.0.0.1\/32            md5/ }
  its(:content) { should match /host    redmine         redmine         ::1\/128                 md5/ }
end

describe service("postgresql") do
  it { should be_running }
  it { should be_enabled }
end
__END__
describe file("/var/lib/redmine/config/database.yml") do
  it { should exist }
end

# describe file("/bin/gem")do
#   it { should_not exist }
# end

# sudo /usr/local/bin/passenger-install-apache2-module --auto

describe file("/etc/httpd/conf.d/redmine.conf") do
  it { should exist }
end

#
describe service("httpd") do
  it { should be_running }
  it { should be_enabled }
end

# sudo chown -R apache:apache /var/lib/redmine
describe file("/var/lib/redmine") do
  it { should be_owned_by "apache" }
end

describe file('/etc/httpd/conf/httpd.conf') do
  its(:content) { should match /DocumentRoot \"\/var\/lib\/redmine\/public\"/ }
end

