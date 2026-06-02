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

  # read all item placements from the objects layer and create the right item for each one
  def self.load_items(data)
    objects_layer = find_layer(data, 'objects')
    items = []
    objects_layer['objects'].each do |obj|
      if obj['name'] == 'copper_khopesh'
        item = CopperKhopesh.new
      elsif obj['name'] == 'bronze_khopesh'
        item = BronzeKhopesh.new
      elsif obj['name'] == 'meteor_steel_khopesh'
        item = MeteorSteelKhopesh.new
      elsif obj['name'] == 'copper_armour'
        item = CopperArmour.new
      elsif obj['name'] == 'bronze_armour'
        item = BronzeArmour.new
      elsif obj['name'] == 'meteor_steel_armour'
        item = MeteorSteelArmour.new
      end
      if item
        item.x = (obj['x'] / 32).floor
        item.y = (obj['y'] / 32).floor
        items << item
      end
    end
    items
  end

end