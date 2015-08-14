require 'rails_helper'
require 'kmllib'

RSpec.describe 'kmllib' do
  describe '#extract_track' do
    it 'extracts a track from kml' do
      kml = <<END
<kml>
  <Document>
    <Folder>
      <name>Test track</name>
      <Placemark>
        <name>Track</name>
        <gx:Track>
          <altitudeMode>absolute</altitudeMode>
          <when>2015-08-06T11:08:48.623Z</when>
          <when>2015-08-06T11:08:50.623Z</when>
          <gx:coord>-3.2799208 54.540783 97.0</gx:coord>
          <gx:coord>-3.2798505 54.540813 114.0</gx:coord>
        </gx:Track>
      </Placemark>
    </Folder>
  </Document>
</kml>
END
      expect(KML.extract_track(kml)).to match({
        '2015-08-06T11:08:48.623Z' => [-3.2799208, 54.540783, 97.0],
        '2015-08-06T11:08:50.623Z' => [-3.2798505, 54.540813, 114.0]
      })
    end
  end
end
