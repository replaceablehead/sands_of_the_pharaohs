require 'json'

module DataLoader

  # find a layer in the map data by name using a while loop
  def self.find_layer(data, layer_name)
    found = nil
    i = 0
    while i < data['layers'].length
      if data['layers'][i]['name'] == layer_name
        found = data['layers'][i]
      end
      i += 1
    end
    found
  end

  # find an object in a layer by name using a while loop
  def self.find_object(data, layer_name, object_name)
    layer = find_layer(data, layer_name)
    found = nil
    i = 0
    while i < layer['objects'].length
      if layer['objects'][i]['name'] == object_name
        found = layer['objects'][i]
      end
      i += 1
    end
    found
  end

  # read all npc spawn points from the map and create the right npc object for each one
  def self.load_npcs(data)
    npc_layer = find_layer(data, 'npc_spawn')
    npcs = Array.new
    i = 0
    while i < npc_layer['objects'].length
      obj = npc_layer['objects'][i]
      npc = nil
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
      i += 1
    end
    npcs
  end

  # read all item placements from the objects layer and create the right item for each one
  def self.load_items(data)
    objects_layer = find_layer(data, 'objects')
    items = Array.new
    i = 0
    while i < objects_layer['objects'].length
      obj = objects_layer['objects'][i]
      item = nil
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
      elsif obj['name'] == 'potion'
        item = HealthPotion.new
      end
      if item
        item.x = (obj['x'] / 32).floor
        item.y = (obj['y'] / 32).floor
        items << item
      end
      i += 1
     end
    items
  end

end