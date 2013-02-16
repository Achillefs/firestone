require 'spec_helper'
require 'fondue/hash_class'

describe Fondue::HashClass do
  before { @hash = {:foo => 'bar', 'bin' => :bash} }
  subject { Fondue::HashClass.new(:hash_class => @hash) }
  
  it {subject.hash_class.should eq(@hash)}
  it {subject.foo.should     eq('bar')}
  it {subject[:foo].should   eq('bar')}
  it {subject.bin.should     eq(:bash)}
  it {subject['bin'].should  eq(:bash)}
  it {subject.class.get_hash_attribute.should eq('@hash_class')}
end