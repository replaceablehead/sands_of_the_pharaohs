require 'gosu'

# creates a character class
class Character
  attr_accessor :hp, :str, :dex, :int, :wis, :x, :y, :image
  TILE_SIZE = 32

  def initialize(x = 0, y = 0)
    @hp = 100
    @str = 10
    @dex = 10
    @int = 10
    @wis = 10
    @x = x
    @y = y
    @image = Gosu::Image.new('assets/character/rotations/south.png')
  end

  def draw
    @image.draw(@x * TILE_SIZE, @y * TILE_SIZE, 1)
  end
end