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
    @tile_images = Array.new(30)
    tileset = data['tilesets'].first
    tileset['tiles'].each do |tile|
      id = tile['id'] + 1
      @tile_images[id] = Gosu::Image.new(tile['image'].gsub('../', ''))
    end
  end

  # look up the target x and y position in the walls and solid decorations layers.
  # multiply y by the map width and add x to convert tile coordinates to an array index.
  # return true if both values at that index are zero meaning the tile is passable
  # also return false if the target position is outside the map boundaries
  def detect_collision(x, y)
    return false if x < 0 || x >= @width || y < 0 || y >= @height
    tile_index = y * @width + x
    walls_layer = @layers.find { |l| l['name'] == 'walls' }
    solid_decorations_layer = @layers.find { |l| l['name'] == 'solid_decorations' }
    walls_layer['data'][tile_index] == 0 && solid_decorations_layer['data'][tile_index] == 0
  end

  # check if the player is standing on any stairs tile
  def on_stairs?(x, y)
    on_down_stairs?(x, y) or on_up_stairs?(x, y)
  end

  # check if the player is standing on the down stairs tile
  def on_down_stairs?(x, y)
    tile_index = y * @width + x
    stairs_layer = @layers.find { |l| l['name'] == 'stairs' }
    stairs_layer['data'][tile_index] == DOWN_STAIRS_ID
  end

  # check if the player is standing on the up stairs tile
  def on_up_stairs?(x, y)
    tile_index = y * @width + x
    stairs_layer = @layers.find { |l| l['name'] == 'stairs' }
    stairs_layer['data'][tile_index] == UP_STAIRS_ID
  end

  def draw
    # loop through the tile layers and draw each tile
    @layers.each do |layer|
      next unless layer['type'] == 'tilelayer'
      layer['data'].each_with_index do |tile_id, index|
        next if tile_id == 0
        x = (index % @width) * TILE_SIZE
        y = (index / @width) * TILE_SIZE
        @tile_images[tile_id].draw(x, y, 0) if @tile_images[tile_id]
      end
    end
  end
end