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

    placemarks = {}

    data.css('Placemark').each do |p|
      placemarks[p.css('name').first.content] = p
    end

    tss = placemarks['Track'].css('when').to_ary
    cds = placemarks['Track'].css('gxXcoord').to_ary
    tss.each_index do |i|
      node = Hash[[:lat, :long, :alt].zip(cds[i].content.split(/\s+/).map{ |d| d.to_f })]
      node[:time] = tss[i].content
      @nodes << node
    end
  end
end
