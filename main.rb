require 'gosu'
require_relative 'map'
require_relative 'character'
require_relative 'npc'
require_relative 'item'
require_relative 'combat'
require_relative 'data_loader'

class Game < Gosu::Window
  def initialize
  super 960, 600
  self.caption = "Sands of the Pharaohs"
  @map = Map.new('maps/level1.tmj')
  
  # read spawn point from map and convert to tile coordinates
  map_data = JSON.parse(File.read('maps/level1.tmj'))
  spawn = DataLoader.find_object(map_data, 'player_spawn', 'player_spawn')
  spawn_x = (spawn['x'] / 32).floor
  spawn_y = (spawn['y'] / 32).floor
  
  @player = Character.new(spawn_x, spawn_y)
end

def draw
  @map.draw
  @player.draw
end
end
Game.new.show if __FILE__ == $0