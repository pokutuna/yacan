require 'rubygems'

module YaCan
  $LOAD_PATH.unshift File.dirname(__FILE__)

  class AppIDUnconfiguredError < StandardError; end

  def appid
    return @@appid rescue raise AppIDUnconfiguredError
  end

  def appid=(appid)
    @@appid = appid
  end

  module_function :appid, :appid=
end



