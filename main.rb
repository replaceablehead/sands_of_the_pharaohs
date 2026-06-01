require 'gosu'
require_relative 'map'
require_relative 'character'
require_relative 'npc'
require_relative 'item'
require_relative 'combat'
require_relative 'data_loader'

class Game < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "Sands of the Pharaohs"
    @map = Map.new('maps/level1.tmj')
  end

  def update
  end

  def draw
    @map.draw
  end
end

Game.new.show if __FILE__ == $0