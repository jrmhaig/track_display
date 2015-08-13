class Track < ActiveRecord::Base
  def self.track_from_kml(kml)
    data = Nokogiri::XML(kml.gsub(/gx:/, 'gxX'))

    placemarks = {}

    data.css('Placemark').each do |p|
      placemarks[p.css('name').first.content] = p
    end

    tss = placemarks['Track'].css('when').to_ary
    cds = placemarks['Track'].css('gxXcoord').to_ary

    track = {}

    tss.each_index do |i|
      track[tss[i].content] = cds[i].content.split(/\s+/).map{ |d| d.to_f }
    end

    track
  end
end
