# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Dependency" do
  before(:all) do
    YaCan.appid = ENV['YAHOO_API_APPID']
    @phrase = 'うちの庭には二羽鶏が居ます。'
    @xml = File.open(File.expand_path(File.dirname(__FILE__) + '/test_source/dependency.xml')).read
  end

  it 'should analyze sentence' do
    YaCan::YahooAPI.stub!(:request).and_return @xml
    res = YaCan::Dependency.analyze(@phrase)
  end

  it 'should have alias method :parse' do
    YaCan::Dependency.parse(@phrase).chunks.to_s.should == YaCan::Dependency.analyze(@phrase).chunks.to_s
  end

  it 'should have module name shortened' do
    YaCan::Dependency.should == YaCan::DA
  end

  describe "Result" do
    before(:all) do
      @result = YaCan::Dependency::Result.new(@xml)
    end

    it 'should have chunks' do
      @result.chunks.should have(4).items
    end

    it 'should be gettable a chunk from dependency' do
      @result.chunks.first.depends_on.id.should == 1
      @result.chunks.last.depends_on.should == nil
    end

    it 'should be gettable chunks from a chunk depends from' do
      @result.chunks.last.depends_from.map{ |c| c.id }.should == [1,2]
      @result.chunks.first.depends_from.should be_empty
    end
  end
end








