json.array!(@nodes) do |node|
  json.extract! node, :id, :track_id, :time, :lat, :long, :alt
  json.url node_url(node, format: :json)
end
