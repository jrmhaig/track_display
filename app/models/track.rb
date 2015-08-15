require 'kmllib'

class Track < ActiveRecord::Base
  has_many :nodes

  def self.create_from_kml(kml)
    track_data = OldKML.extract_track(kml)
    t = Track.create
    track_data.each do |time, p|
      Node.create(time: time, lat: p[0], long: p[1], alt: p[2], track: t)
    end
    t
  end

end
