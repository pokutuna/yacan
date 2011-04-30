require 'net/http'
require 'rubygems'
require 'nokogiri'

module YaCan
  $LOAD_PATH.unshift File.dirname(__FILE__)

  require 'yacan/yahoo_api'
  require 'yacan/dependency'
  require 'yacan/keyphrase'
  require 'yacan/morphem'

  @@proxy_host, @@proxy_port = (ENV["http_proxy"] || '').sub(/http:\/\//, '').split(':')

  def proxy_host
    @@proxy_host
  end

  def proxy_host=(host)
    @@proxy_host = host
  end

  def proxy_port
    @@proxy_port
  end

  def proxy_port=(port)
    @@proxy_port = port
  end

  include YaCan::YahooAPI
  module_function :appid, :appid=, :proxy_host, :proxy_host=, :proxy_port, :proxy_port=
end
