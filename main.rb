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
    @npcs = DataLoader.load_npcs(map_data)
    spawn = DataLoader.find_object(map_data, 'player_spawn', 'player_spawn')
    spawn_x = (spawn['x'] / 32).floor
    spawn_y = (spawn['y'] / 32).floor
    
    @player = Character.new(spawn_x, spawn_y)
  end

  def update
  end

  # handle keyboard input for player movement and combat
  def button_down(id)
    if id == Gosu::KB_RIGHT
      npc = Combat.check_for_enemy_on_target_tile(@npcs, @player.x + 1, @player.y)
      if npc
        Combat.resolve_attack(@player, npc)
        @npcs.reject! { |n| Combat.dead?(n) }
      elsif @map.detect_collision(@player.x + 1, @player.y)
        @player.move_right
      end
      @npcs.each { |npc| npc.move_toward(@player.x, @player.y) }
    elsif id == Gosu::KB_LEFT
      npc = Combat.check_for_enemy_on_target_tile(@npcs, @player.x - 1, @player.y)
      if npc
        Combat.resolve_attack(@player, npc)
        @npcs.reject! { |n| Combat.dead?(n) }
      elsif @map.detect_collision(@player.x - 1, @player.y)
        @player.move_left
      end
      @npcs.each { |npc| npc.move_toward(@player.x, @player.y) }
    elsif id == Gosu::KB_UP
      npc = Combat.check_for_enemy_on_target_tile(@npcs, @player.x, @player.y - 1)
      if npc
        Combat.resolve_attack(@player, npc)
        @npcs.reject! { |n| Combat.dead?(n) }
      elsif @map.detect_collision(@player.x, @player.y - 1)
        @player.move_up
      end
      @npcs.each { |npc| npc.move_toward(@player.x, @player.y) }
    elsif id == Gosu::KB_DOWN
      npc = Combat.check_for_enemy_on_target_tile(@npcs, @player.x, @player.y + 1)
      if npc
        Combat.resolve_attack(@player, npc)
        @npcs.reject! { |n| Combat.dead?(n) }
      elsif @map.detect_collision(@player.x, @player.y + 1)
        @player.move_down
      end
      @npcs.each { |npc| npc.move_toward(@player.x, @player.y) }
    elsif id == Gosu::KB_ESCAPE
      close
    end
  end

  def draw
    @map.draw
    @npcs.each { |npc| npc.draw }
    @player.draw
  end
end

Game.new.show if __FILE__ == $0