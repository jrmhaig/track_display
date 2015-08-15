Fabricator(:node) do
  time { '1970-01-01T00:00:00.000Z' }
  lat { 0.0 }
  long { 0.0 }
  alt { 0.0 }
  track { Fabricate(:track) }
end
