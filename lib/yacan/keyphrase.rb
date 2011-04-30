module YaCan::Keyphrase
  @@path = '/KeyphraseService/V1/extract'

  def analyze(text)
    xml = YaCan::YahooAPI.request(@@path, {'sentence' => text})
    return Result.new(xml)
  end

  def extract(text)
    analyze(text)
  end

  module_function :analyze, :extract

  class Result
    def initialize(xml)
      @xml = xml
      pairs = Nokogiri::XML(xml).search('Result')
      @results = pairs.map{ |p|
        [p.at('Keyphrase').text, p.at('Score').text.to_i]
      }
    end

    def phrases
      @phrases ||= @results.map{ |r| r[0]}
    end

    def scores
      @scores ||= @results.map{ |r| r[1]}
    end

    attr_reader :xml, :results
  end

end
