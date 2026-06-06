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
require_relative 'level_up'

class Game < Gosu::Window
  MAX_LEVELS = 5

  
  def initialize
    super 800, 600
    self.caption = "Sands of the Pharaohs"
    @hud = Hud.new
    @game_over = false
    @game_won = false
    @level_up_pending = false
    @font = Gosu::Font.new(72)
    @current_level = 1
    load_level(@current_level)
    @hud.add_message('welcome to sands of the pharaohs')
    @player_attack_sound = Gosu::Sample.new('sounds/player_attack_sound.wav')
    @enemy_attack_sound = Gosu::Sample.new('sounds/enemy_attack_sound.wav')
  end

  # load a level by number and set up the map, npcs, items and player spawn
  def load_level(level_number)
    map_file = 'maps/level' + level_number.to_s + '.tmj'
    @map = Map.new(map_file)
    map_data = JSON.parse(File.read(map_file))
    @npcs = DataLoader.load_npcs(map_data)
    @items = DataLoader.load_items(map_data)
    spawn = DataLoader.find_object(map_data, 'player_spawn', 'player_spawn')
    spawn_x = (spawn['x'] / 32).floor
    spawn_y = (spawn['y'] / 32).floor
    if @player
      @player.x = spawn_x
      @player.y = spawn_y
    else
      @player = Character.new(spawn_x, spawn_y)
    end
  end

  # check if the player is standing on an item and pick it up
  def check_item_pickup
    i = 0
    while i < @items.length
      item = @items[i]
      if item.x == @player.x && item.y == @player.y
        @player.str += item.str_bonus
        @player.defence += item.defence_bonus
        if item.heal_amount > 0
          @player.hp += item.heal_amount
          if @player.hp > @player.max_hp
            @player.hp = @player.max_hp
          end
        end
        @hud.add_message('you picked up ' + item.name + '!')
        @items.delete_at(i)
        break
      end
      i += 1
    end
  end

  # update player animation and decrement hit timers for player and all npcs
  def update
    @player.update
    if @player.hit_timer > 0
      @player.hit_timer -= 1
    end
    i = 0
    while i < @npcs.length
      if @npcs[i].hit_timer > 0
        @npcs[i].hit_timer -= 1
      end
      i += 1
    end
  end


  # pass keyboard input to the input handler
  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    end
    if !@game_over && !@game_won
      @level_up_pending = InputHandler.handle(id, @player, @npcs, @map, @hud, @level_up_pending, @player_attack_sound, @enemy_attack_sound)
      check_item_pickup
      if Combat.dead?(@player)
        @game_over = true
        @hud.add_message('you have died. press escape to quit.')
      end
      # check if cobra boss was killed on level 5
      if @current_level == MAX_LEVELS
        cobra_still_alive = false
        i = 0
        while i < @npcs.length
          if @npcs[i].type == 'cobra_boss'
            cobra_still_alive = true
          end
          i += 1
        end
        if !cobra_still_alive
          @game_won = true
          @hud.add_message('you have slain the cobra boss! you win!')
        end
      end
      if @map.on_down_stairs?(@player.x, @player.y)
        if @current_level < MAX_LEVELS
          @current_level += 1
          @hud.add_message('you descend deeper into the pyramid...')
          load_level(@current_level)
        end
      elsif @map.on_up_stairs?(@player.x, @player.y)
        if @current_level > 1
          @current_level -= 1
          @hud.add_message('you ascend back toward the entrance...')
          load_level(@current_level)
        else
          @hud.add_message('you are already at the top.')
        end
      end
    end
  end

  def draw
    @map.draw
    i = 0
    while i < @npcs.length
      @npcs[i].draw
      i += 1
    end
    @player.draw
    @hud.draw(@player)
    if @level_up_pending
      Gosu.draw_rect(0, 0, 960, 600, Gosu::Color.new(150, 0, 0, 0), 3)
      @font.draw_text('LEVEL UP', 175, 200, 4, 1, 1, Gosu::Color::YELLOW)
      @font.draw_text('S - strength', 240, 280, 4, 0.5, 0.5, Gosu::Color::WHITE)
      @font.draw_text('D - dexterity', 240, 320, 4, 0.5, 0.5, Gosu::Color::WHITE)
    end
    if @game_over
      Gosu.draw_rect(0, 0, 960, 600, Gosu::Color.new(200, 0, 0, 0), 3)
      @font.draw_text('GAME OVER', 130, 250, 4, 1, 1, Gosu::Color::RED)
    end
     if @game_won
      Gosu.draw_rect(0, 0, 960, 600, Gosu::Color.new(200, 0, 0, 0), 3)
      @font.draw_text('YOU WIN!', 175, 250, 4, 1, 1, Gosu::Color::YELLOW)
    end
  end
end

Game.new.show if __FILE__ == $0