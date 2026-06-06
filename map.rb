require 'gosu'
require 'json'

# creates a map class
class Map
  attr_reader :width, :height, :layers, :tile_images

  TILE_SIZE = 32
  DOWN_STAIRS_ID = 28
  UP_STAIRS_ID = 27

  def initialize(map_file)
    # read in the tmjson file
    data = JSON.parse(File.read(map_file))
    @width = data['width']
    @height = data['height']
    @layers = data['layers']

    # build an array and map tiles to their image files by id
    @tile_images = Array.new(100)
    tileset = data['tilesets'][0]
    i = 0
    while i < tileset['tiles'].length
      tile = tileset['tiles'][i]
      id = tile['id'] + 1
      @tile_images[id] = Gosu::Image.new(tile['image'].gsub('../', ''))
      i += 1
    end
    
  end

  # find a layer by name using a while loop
  def find_layer(layer_name)
    found = nil
    i = 0
    while i < @layers.length
      if @layers[i]['name'] == layer_name
        found = @layers[i]
      end
      i += 1
    end
    found
  end

  # look up the target x and y position in the walls and solid decorations layers.
  # multiply y by the map width and add x to convert tile coordinates to an array index.
  # return true if both values at that index are zero meaning the tile is passable
  # also return false if the target position is outside the map boundaries
  def detect_collision(x, y)
    if x < 0 || x >= @width || y < 0 || y >= @height
      return false
    end
    tile_index = y * @width + x
    walls_layer = find_layer('walls')
    solid_decorations_layer = find_layer('solid_decorations')
    if walls_layer['data'][tile_index] == 0 && solid_decorations_layer['data'][tile_index] == 0
      return true
    end
    return false
  end

  # check if the player is standing on any stairs tile
  def on_stairs?(x, y)
    on_down_stairs?(x, y) or on_up_stairs?(x, y)
  end


  # check if the player is standing on the down stairs tile
  def on_down_stairs?(x, y)
    tile_index = y * @width + x
    stairs_layer = find_layer('stairs')
    stairs_layer['data'][tile_index] == DOWN_STAIRS_ID
  end

  # check if the player is standing on the up stairs tile
  def on_up_stairs?(x, y)
    tile_index = y * @width + x
    stairs_layer = find_layer('stairs')
    stairs_layer['data'][tile_index] == UP_STAIRS_ID
  end

  def draw
    # loop through the tile layers and draw each tile
    i = 0
    while i < @layers.length
      layer = @layers[i]
      if layer['type'] == 'tilelayer'
        j = 0
        while j < layer['data'].length
          tile_id = layer['data'][j]
          if tile_id != 0
            x = (j % @width) * TILE_SIZE
            y = (j / @width) * TILE_SIZE
            if @tile_images[tile_id]
              @tile_images[tile_id].draw(x, y, 0)
            end
          end
          j += 1
        end
      end
      i += 1
    end
  end
end