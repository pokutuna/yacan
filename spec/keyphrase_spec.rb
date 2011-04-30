# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Keyphrase' do

  before(:all) do
    YaCan.appid = ENV['YAHOO_API_APPID']
    @phrase = '東京ミッドタウンから国立新美術館まで歩いて5分で着きます。'
    @xml = File.open(File.expand_path(File.dirname(__FILE__) + '/test_source/keyphrase.xml')).read
  end

  it 'should have alias method :extract' do
    YaCan::YahooAPI.stub!(:request).and_return @xml
    YaCan::Keyphrase.extract(@phrase).results.should == YaCan::Keyphrase.analyze(@phrase).results
  end

  describe "Result" do
    before(:all) do
      @res = YaCan::Keyphrase::Result.new(@xml)
    end

    it 'should analyze sentence' do
      @res.results.should have(3).items
    end

    it 'should take phrases' do
      @res.phrases.sort.should == ["国立新美術館", "東京ミッドタウン", "5分"].sort
    end

  end

end








