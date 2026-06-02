require 'gosu'
require 'json'
require_relative 'map'
require_relative 'character'
require_relative 'npc'
require_relative 'item'
require_relative 'combat'
require_relative 'data_loader'
require_relative 'input_handler'
require_relative 'hud'

class Game < Gosu::Window
  def initialize
    super 960, 600
    self.caption = "Sands of the Pharaohs"
    @map = Map.new('maps/level1.tmj')
    @hud = Hud.new
    @hud.add_message('welcome to sands of the pharaohs')
    @game_over = false
    @font = Gosu::Font.new(72)

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

  # pass keyboard input to the input handler
  def button_down(id)
    close if id == Gosu::KB_ESCAPE
    if !@game_over
      InputHandler.handle(id, @player, @npcs, @map, @hud)
      if Combat.dead?(@player)
        @game_over = true
        @hud.add_message('you have died. press escape to quit.')
      end
    end
  end

  def draw
    @map.draw
    @npcs.each { |npc| npc.draw }
    @player.draw
    @hud.draw(@player)
    if @game_over
      Gosu.draw_rect(0, 0, 960, 600, Gosu::Color.new(200, 0, 0, 0), 3)
      @font.draw_text('GAME OVER', 300, 250, 4, 1, 1, Gosu::Color::RED)
    end
  end
end

Game.new.show if __FILE__ == $0