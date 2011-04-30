# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Morphem" do
  before(:all) do
    YaCan.appid = ENV['YAHOO_API_APPID']
    @phrase = '庭には二羽鶏がいる。'
  end

  it 'should analyze sentence' do
    res = YaCan::Morphem.analyze(@phrase)
  end

  it 'should take params' do
    res = YaCan::Morphem.analyze(@phrase, {'results' => 'ma', 'filter' => '9'})
    res.ma_result.total_count.should == 9
    res.ma_result.filtered_count.should == 3
    res.uniq_result.total_count.should == nil
  end
end
