module YaCan::Morphem
  YaCan::MA = YaCan::Morphem
  @@path = '/MAService/V1/parse'

  @@default_params = {
    'results' => 'ma,uniq',
    'filter' => (1..13).to_a.join('|'),
    'ma_response' => 'surface,reading,pos,baseform,feature',
    'uniq_response' => 'surface,reading,pos,baseform,feature',
  }

  def analyze(text, params={})
    params['sentence'] = text
    params = @@default_params.merge(params)
    xml = YaCan::YahooAPI.request(@@path, params)
    return Result.new(xml)
  end

  def parse(text, params={})
    analyze(text, params)
  end

  module_function :analyze, :parse

  class Result
    def initialize(xml)
      @xml = xml
      wrapped = Nokogiri::XML(xml)
      @ma_result = MaOrUniq.new(wrapped.at('ma_result'))
      @uniq_result = MaOrUniq.new(wrapped.at('uniq_result'))
    end
    attr_reader :xml, :ma_result, :uniq_result
  end

  class MaOrUniq
    def initialize(xml)
      @total_count = xml.at('total_count').text.to_i rescue nil
      @filtered_count = xml.at('filtered_count').text.to_i rescue nil
      @morphems = xml.search('word').map{ |w| Morphem.new(w) } rescue nil
    end
    attr_reader :total_count, :filtered_count, :morphems
  end

  class Morphem
    def initialize(xml)
      @count = xml.at('count').text.to_i rescue nil
      @surface = xml.at('surface').text
      @reading = xml.at('reading').text rescue nil
      @pos = xml.at('pos').text
      @baseform = xml.at('baseform').text rescue nil
      @feature = xml.at('feature').text.split(',') rescue nil
    end
    attr_reader :count, :surface, :reading, :pos, :baseform, :feature
  end
end








