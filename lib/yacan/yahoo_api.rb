module YaCan::YahooAPI

  @@host = 'jlp.yahooapis.jp'
  @@appid = nil

  def appid
    return @@appid || (raise AppIDUnconfiguredError)
  end

  def appid=(appid)
    @@appid = appid
  end

  def request(path, params={})
    params['appid'] = appid
    Net::HTTP::Proxy(YaCan.proxy_host, YaCan.proxy_port).start(@@host){ |http|
      res = http.post(path, params.map{ |k,v| "#{URI.encode(k)}=#{URI.encode(v)}"}.join('&'))
      res.body
    }
  end

  def analyze(*args)
    raise NotImplementedError
  end

  module_function :appid, :appid=, :request

  class AppIDUnconfiguredError < StandardError; end
end
