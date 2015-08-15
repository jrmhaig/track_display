require 'rails_helper'
require 'kml'


RSpec.describe 'kml' do
  describe '.new' do
    it 'creates a kml instance' do
      expect(KML.new("spec/files/simple.kml")).to be_a(KML)
    end

    it 'has the track name' do
      expect(KML.new("spec/files/simple.kml").name).to eq "Test track"
    end

    it 'has the file name' do
      expect(KML.new("spec/files/simple.kml").filename).to eq "spec/files/simple.kml"
    end

    it 'gets the right number of nodes' do
      expect(KML.new("spec/files/simple.kml").nodes.length).to eq 2
      expect(KML.new("spec/files/5nodes.kml").nodes.length).to eq 5
    end

    it 'extracts the node data' do
      expect(KML.new("spec/files/simple.kml").nodes).to match([
        {
          time: '2015-08-06T11:08:48.623Z',
          lat: -3.2799208,
          long: 54.540783,
          alt: 97.0
        },
        {
          time: '2015-08-06T11:08:50.623Z',
          lat: -3.2798505,
          long: 54.540813,
          alt: 114.0
        }
      ])
    end
  end
end
