require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'YahooAPI' do
  it 'should set&get appid' do
    YaCan::YahooAPI.appid = 'yahoo_api_spec'
    YaCan::YahooAPI.appid.should == 'yahoo_api_spec'
  end

  it 'should raise exception when appid is nil' do
    YaCan::YahooAPI.appid = nil
    expect{ YaCan::YahooAPI.appid }.to raise_error(YaCan::YahooAPI::AppIDUnconfiguredError)
  end
end
