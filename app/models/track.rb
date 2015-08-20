require 'kml'

class Track < ActiveRecord::Base
  has_many :nodes, dependent: :destroy

  Radius = 6371000

  def self.create_from_file(file)
    kml = KML.new(file)

    t = Track.create
    kml.nodes.each do |node|
      Node.create(node.merge(track: t))
    end
    t
  end

  def node_delta(n)
    i = ( n.class == Node ? self.nodes.index(n) : n )
    i.nil? || i == 0 ? 0.0 : arc_distance(nodes[i-1].lat, nodes[i-1].long, nodes[i].lat, nodes[i].long)
  end

  private

  def arc_distance(lat1, long1, lat2, long2)
    phi1 = to_radians(lat1)
    phi2 = to_radians(lat2)
    lambda1 = to_radians(long1)
    lambda2 = to_radians(long2)
    delta_phi = phi2 - phi1
    delta_lambda = lambda2 - lambda1

    a = (Math.sin(delta_phi/2) ** 2) + Math.cos(phi1) * Math.cos(phi2) * (Math.sin(delta_lambda/2) ** 2)
    b = Math.sqrt(a)
    2 * Radius * Math.asin(b)
  end

  def to_radians(degrees)
    degrees * Math::PI / 180
  end
end
