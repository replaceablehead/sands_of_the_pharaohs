require 'json'

module DataLoader
  def self.find_layer(data, layer_name)
    data['layers'].find { |l| l['name'] == layer_name }
  end

  def self.find_object(data, layer_name, object_name)
    layer = find_layer(data, layer_name)
    layer['objects'].find { |o| o['name'] == object_name }
  end
end