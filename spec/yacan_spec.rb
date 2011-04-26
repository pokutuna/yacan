require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Yacan" do
  it 'should raise Exception when appid is not configured' do
    expect{ YaCan.appid }.to raise_error(YaCan::AppIDUnconfiguredError)
  end

  it 'should set&get appid' do
    YaCan.appid = 'hoge'
    YaCan.appid.should == 'hoge'
  end
end
