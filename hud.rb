require 'gosu'

# draws the hud including stats panel and event log
class Hud
  attr_reader :event_log

  MAP_WIDTH = 640
  MAP_HEIGHT = 512
  STATS_PANEL_WIDTH = 320
  LOG_PANEL_HEIGHT = 88
  WINDOW_WIDTH = 960
  WINDOW_HEIGHT = 600

  def initialize
    @event_log = Array.new
    @font = Gosu::Font.new(16)
  end

  # add a message to the event log
  # if the event log has more than 5 messages remove the oldest message
  def add_message(message)
    @event_log << message
    if @event_log.length > 5
      @event_log.shift
    end
  end

  # does a find replace of unscore with black space to remove underscores from names
  def format_npc_name(type)
    type.to_s.gsub('_', ' ')
  end

  # draw the stats panel on the right side of the screen
  def draw_stats(player)
    Gosu.draw_rect(MAP_WIDTH, 0, STATS_PANEL_WIDTH, MAP_HEIGHT, Gosu::Color::BLACK, 3)
    @font.draw_text('HP: ' + player.hp.to_s, MAP_WIDTH + 10, 20, 3, 1, 1, Gosu::Color::WHITE)
    @font.draw_text('STR: ' + player.str.to_s, MAP_WIDTH + 10, 50, 3, 1, 1, Gosu::Color::WHITE)
    @font.draw_text('DEX: ' + player.dex.to_s, MAP_WIDTH + 10, 70, 3, 1, 1, Gosu::Color::WHITE)
    @font.draw_text('INT: ' + player.int.to_s, MAP_WIDTH + 10, 90, 3, 1, 1, Gosu::Color::WHITE)
    @font.draw_text('WIS: ' + player.wis.to_s, MAP_WIDTH + 10, 110, 3, 1, 1, Gosu::Color::WHITE)
  end

  # draw the event log at the bottom of the screen
  def draw_event_log
    Gosu.draw_rect(0, MAP_HEIGHT, WINDOW_WIDTH, LOG_PANEL_HEIGHT, Gosu::Color::BLACK, 3)
    @event_log.each_with_index do |message, index|
      @font.draw_text(message, 10, MAP_HEIGHT + 10 + (index * 16), 3, 1, 1, Gosu::Color::WHITE)
    end
  end

  # put together a combat message for when the player attacks
  def combat_message(npc, result)
    npc_name = format_npc_name(npc.type)
    if result == :hit
      'you hit the ' + npc_name + ' for full damage!'
    elsif result == :partial
      'you hit the ' + npc_name + ' for half damage!'
    else
      'you missed the ' + npc_name + '!'
    end
  end

  # put together a combat message for when the npc attacks
  def npc_attack_message(npc, result)
    npc_name = format_npc_name(npc.type)
    if result == :hit
      'the ' + npc_name + ' hit you for full damage!'
    elsif result == :partial
      'the ' + npc_name + ' hit you for half damage!'
    else
      'the ' + npc_name + ' missed you!'
    end
  end

  def draw(player)
    draw_stats(player)
    draw_event_log
  end
end