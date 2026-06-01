require 'gosu'
require 'json'

# creates a map class
class Map
  attr_reader :width, :height, :layers, :tile_images

  TILE_SIZE = 32


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

  # look up the target x and y position in the walls layer data array.
  # multiply y by the map width and add x to convert tile coordinates to an array index.
  # return true if the value at that index is zero which means no wall is present
  def detect_collision(x, y)
    walls_layer = @layers.find { |l| l['name'] == 'walls' }
    tile_index = y * @width + x
    walls_layer['data'][tile_index] == 0
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