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