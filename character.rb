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
    # load all four direction sprites
    @images = {
      north: Gosu::Image.new('assets/character/rotations/north.png'),
      south: Gosu::Image.new('assets/character/rotations/south.png'),
      east:  Gosu::Image.new('assets/character/rotations/east.png'),
      west:  Gosu::Image.new('assets/character/rotations/west.png')
    }
    @image = @images[:south]
  end

  # move the player one tile in the direction pressed
  def move_right
    @x += 1
    @image = @images[:east]
  end

  def move_left
    @x -= 1
    @image = @images[:west]
  end

  def move_up
    @y -= 1
    @image = @images[:north]
  end

  def move_down
    @y += 1
    @image = @images[:south]
  end

  # turn the player to face a direction without moving
  def face_right
    @image = @images[:east]
  end

  def face_left
    @image = @images[:west]
  end

  def face_up
    @image = @images[:north]
  end

  def face_down
    @image = @images[:south]
  end

  def draw
    @image.draw(@x * TILE_SIZE, @y * TILE_SIZE, 1)
  end
end