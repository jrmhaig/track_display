require 'rails_helper'

RSpec.describe Track, type: :model do
  describe '#create_from_kml' do
    it 'creates a new track from kml' do
      expect{ Track.create_from_file('spec/files/simple.kml') }.to change{ Track.count }.by(1)
    end

    it 'returns a track' do
      expect(Track.create_from_file('spec/files/simple.kml')).to be_a(Track)
    end

    it 'creates 2 nodes' do
      expect{ Track.create_from_file('spec/files/simple.kml') }.to change{ Node.count }.by(2)
    end

    it 'creates a track with 2 nodes' do
      expect(Track.create_from_file('spec/files/simple.kml').nodes.count).to eq(2)
    end
  end

  describe '#node_delta' do
    # Using the example from http://rosettacode.org/wiki/Haversine_formula
    let(:track) { Track.create_from_file('spec/files/rosetta_code_zero_altitude.kml') }
    let(:node) { Fabricate(:node) }

    it 'calculates the distance between a node and the previous' do
      expect(track.node_delta(track.nodes[1])).to be_between(2886444.4, 2886444.5)
    end

    it 'returns zero delta for the starting point' do
      expect(track.node_delta(track.nodes[0])).to eq 0
    end

    it 'calculates the distance between a node by number and the previous' do
      expect(track.node_delta(1)).to be_between(2886444.4, 2886444.5)
    end

    it 'returns zero delta for the starting point by number' do
      expect(track.node_delta(0)).to eq 0
    end

    it 'returns zero delta for a node not in the track' do
      expect(track.node_delta(node)).to eq 0
    end
  end

end
