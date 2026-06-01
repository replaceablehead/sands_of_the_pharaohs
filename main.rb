require 'Gosu'
class Game < Gosu::Window
  def initialize
    super 960, 600
  end
end

Game.new.show