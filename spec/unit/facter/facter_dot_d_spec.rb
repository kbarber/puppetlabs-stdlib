#!/usr/bin/env rspec

require 'spec_helper'

describe "facter_dot_d fact" do
  require 'lib/facter_dot_d.rb'

  it "should set cache_file based on vardir" do
    Puppet.stubs(:[]).with(:vardir).returns("/my/var/dir")
    dotd = Facter::Util::DotD.new
    dotd.cache_file.should = "/my/var/dir/facts_cache.yml"
  end
end
