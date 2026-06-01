require 'gosu'
require 'gosu_tiled'

# creates a map class
class Map
  attr_reader :width, :height, :tiled_map

  def initialize(window, map_file)
    # ask gosu-tiled to load the map from a json file and store the result.
    @tiled_map = Gosu::Tiled.load_json(window, map_file)
    @width = @tiled_map.width
    @height = @tiled_map.height
  end
end