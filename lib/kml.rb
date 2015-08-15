class KML
  attr_accessor :name
  attr_accessor :filename
  attr_accessor :nodes

  def initialize(file)
    data = Nokogiri::XML(File.read(file).gsub(/gx:/, 'gxX'))

    folder = data.css('Folder').first
    @filename = file
    @name = folder.css('name').first.content
    @nodes = []
#    data = Nokogiri::XML(kml.gsub(/gx:/, 'gxX'))
#
    placemarks = {}

    data.css('Placemark').each do |p|
      placemarks[p.css('name').first.content] = p
    end

    tss = placemarks['Track'].css('when').to_ary
    cds = placemarks['Track'].css('gxXcoord').to_ary
    tss.each_index do |i|
      @nodes << {
        time: tss[i].content,
        coord: cds[i].content
      }
    end
#
#    track = {}
#
#    tss.each_index do |i|
#      track[tss[i].content] = cds[i].content.split(/\s+/).map{ |d| d.to_f }
#    end
#
#    track
  end
end
