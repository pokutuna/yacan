# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "YaCan" do

  it 'should set&get appid' do
    YaCan.appid = 'hoge'
    YaCan.appid.should == 'hoge'
  end
end
