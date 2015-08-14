require 'rails_helper'

RSpec.describe Track, type: :model do
  describe '#create_from_kml' do
    it 'creates a new track from kml' do
      kml = <<END
<kml>
  <Document>
    <Folder>
      <name>Test track</name>
      <Placemark>
        <name>Track</name>
        <gx:Track>
          <altitudeMode>absolute</altitudeMode>
        </gx:Track>
      </Placemark>
    </Folder>
  </Document>
</kml>
END
      expect{ Track.create_from_kml(kml) }.to change{ Track.count }.by(1)
    end

    it 'returns a track' do
      kml = <<END
<kml>
  <Document>
    <Folder>
      <name>Test track</name>
      <Placemark>
        <name>Track</name>
        <gx:Track>
          <altitudeMode>absolute</altitudeMode>
        </gx:Track>
      </Placemark>
    </Folder>
  </Document>
</kml>
END
      expect(Track.create_from_kml(kml)).to be_a(Track)
    end

    it 'creates 2 nodes' do
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
      expect{ Track.create_from_kml(kml) }.to change{ Node.count }.by(2)
    end

    it 'creates a track with 2 nodes' do
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
      expect(Track.create_from_kml(kml).nodes.count).to eq(2)
    end
  end

end
