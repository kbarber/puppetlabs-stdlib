#!/usr/bin/env rspec
require 'spec_helper'

describe "the str2pbkdf2_hash function" do
  before :all do
    Puppet::Parser::Functions.autoloader.loadall
  end

  subject do
    Puppet::Parser::Scope.new
  end

  it "should exist" do
    Puppet::Parser::Functions.function("str2pbkdf2_hash").should == "function_str2pbkdf2_hash"
  end

  it "should raise a ParseError if there is less than 3 arguments" do
    expect { subject.function_str2pbkdf2_hash([]) }.should( raise_error(Puppet::ParseError) )
  end

  it "should raise a ParseError if there is more than 3 arguments" do
    expect { subject.function_str2pbkdf2_hash(['foo', 'bar', 'baz', 'buz']) }.should( raise_error(Puppet::ParseError) )
  end

  it "should return a salted-sha512-pbkdf2 password hash 256 characters in length" do
    result = subject.function_str2pbkdf2_hash(["password", 'salt', 10000])
    result.length.should(eq(256))
  end

  it "should raise an error if you pass a non-string password" do
    expect { subject.function_str2pbkdf2_hash([1234]) }.should( raise_error(Puppet::ParseError) )
  end

  it "should raise an error if you pass a non-string salt" do
    expect { subject.function_str2pbkdf2_hash(['password', 1234]) }.should( raise_error(Puppet::ParseError) )
  end

  it "should raise an error if you pass a non-integer iterations value" do
    expect { subject.function_str2pbkdf2_hash(['password', 'salt', 'buckeyebill']) }.should( raise_error(Puppet::ParseError, /invalid value for Integer: "buckeyebill"/) )
  end

  it "should generate a valid password" do
    pw_hash = '72629a41b076e588fba8c71ca37fadc9acdc8e7321b9cb4ea55fd0bf9fe8ed72def92b4c7dff5242a0254945b945394ce4d6008e947bdc7593085cd1e2f6a375e3efe32510e0f982abcc57991cb705243a3a42086e6a9e56c7b063c72636793b7622587882a872b19bb15e8fc8a865a8e83264bf802d0e52f825f18cc46a2147'

    subject.function_str2pbkdf2_hash(["password", 'salt', 10000] \
                                    ).should(eq(pw_hash))
  end
end
