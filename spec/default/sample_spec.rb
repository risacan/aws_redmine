require "serverspec"

set :backend, :ssh

describe user("vagrant") do
  it { should exist }
end
