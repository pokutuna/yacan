module YaCan::Dependency
  YaCan::DA = YaCan::Dependency
  @@path = '/DAService/V1/parse'

  def analyze(text)
    xml = YaCan::YahooAPI.request(@@path, { 'sentence' => text })
    return Result.new(xml)
  end

  def parse(text)
    analyze(text)
  end

  module_function :analyze, :parse

  class Result
    def initialize(xml)
      @xml = xml
      xml_chunks = Nokogiri::XML(xml).search('Chunk')
      @chunks = xml_chunks.map{ |c| Chunk.new(c, lambda{ @chunks }) }
      @morphems = chunks.map{|c| c.morphems}.flatten
    end

    attr_reader :xml, :chunks, :morphems
  end


  class Chunk
    def initialize(xml, chunks)
      @id = xml.at('Id').text.to_i
      @dependency = xml.at('Dependency').text.to_i
      @morphems = xml.search('Morphem').map{ |m| Morphem.new(m) }
      @chunks = chunks
    end

    def to_s
      "#{@id} #{dependency} #{@morphems.map{ |m| m.surface}.join('')}"
    end

    def depends_on
      @depends_o ||= @chunks.call.find{ |c| c.id == @dependency }
    end

    def depends_from
      @depends_f ||= @chunks.call.find_all{ |c| c.dependency == @id }
    end

    attr_reader :id, :dependency, :morphems
  end


  class Morphem
    def initialize(xml)
      @surface = xml.at('Surface').text
      @reading = xml.at('Reading').text
      @baseform = xml.at('Baseform').text
      @pos = xml.at('POS').text
      @feature = xml.at('Feature').text.split(',')
    end

    def to_s
      "#{@surface}: #{@feature.join(',')}"
    end

    attr_reader :surface, :reading, :baseform, :pos, :feature
  end

end
