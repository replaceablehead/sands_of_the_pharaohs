require 'gosu'
require 'json'
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

  def update
  end

  # handle keyboard input for player movement
  def button_down(id)
    if id == Gosu::KB_RIGHT
      @player.move_right if @map.detect_collision(@player.x + 1, @player.y)
    elsif id == Gosu::KB_LEFT
      @player.move_left if @map.detect_collision(@player.x - 1, @player.y)
    elsif id == Gosu::KB_UP
      @player.move_up if @map.detect_collision(@player.x, @player.y - 1)
    elsif id == Gosu::KB_DOWN
      @player.move_down if @map.detect_collision(@player.x, @player.y + 1)
    elsif id == Gosu::KB_ESCAPE
      close
    end
  end

  def draw
    @map.draw
    @player.draw
  end
end

Game.new.show if __FILE__ == $0