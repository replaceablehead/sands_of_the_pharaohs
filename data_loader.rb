require 'json'

module DataLoader
  def self.find_layer(data, layer_name)
    data['layers'].find { |l| l['name'] == layer_name }
  end

  def self.find_object(data, layer_name, object_name)
    layer = find_layer(data, layer_name)
    layer['objects'].find { |o| o['name'] == object_name }
  end

  # read all npc spawn points from the map and create the right npc object for each one
  def self.load_npcs(data)
    npc_layer = find_layer(data, 'npc_spawn')
    npcs = []
    npc_layer['objects'].each do |obj|
      if obj['name'] == 'rat'
        npc = Rat.new
      elsif obj['name'] == 'mummy'
        npc = Mummy.new
      elsif obj['name'] == 'anubis_guard_light'
        npc = AnubisGuardLight.new
      elsif obj['name'] == 'anubis_guard_dark'
        npc = AnubisGuardDark.new
      elsif obj['name'] == 'cobra_boss'
        npc = CobraBoss.new
      elsif obj['name'] == 'dummy'
        npc = Dummy.new
      end
      if npc
        npc.x = (obj['x'] / 32).floor
        npc.y = (obj['y'] / 32).floor
        npcs << npc
      end
    end
    npcs
  end
end