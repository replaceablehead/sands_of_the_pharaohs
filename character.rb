require 'gosu'

# creates a character class
class Character
  attr_accessor :hp, :str, :dex, :int, :wis, :def, :x, :y, :image, :current_xp, :xp_to_next_level, :player_level, :just_levelled_up
  TILE_SIZE = 32

  def initialize(x = 0, y = 0)
    @hp = 999
    @str = 10
    @dex = 10
    @int = 10
    @wis = 10
    @def = 10
    @x = x
    @y = y
    @current_xp = 0
    @player_level = 1
    @xp_to_next_level = 100
    @just_levelled_up = false
    # load all four direction sprites
    @image_north = Gosu::Image.new('assets/character/rotations/north.png')
    @image_south = Gosu::Image.new('assets/character/rotations/south.png')
    @image_east  = Gosu::Image.new('assets/character/rotations/east.png')
    @image_west  = Gosu::Image.new('assets/character/rotations/west.png')
    @image = @image_south
  end

  # move the player one tile in the direction pressed
  def move_right
    @x += 1
    @image = @image_east
  end

  def move_left
    @x -= 1
    @image = @image_west
  end

  def move_up
    @y -= 1
    @image = @image_north
  end

  def move_down
    @y += 1
    @image = @image_south
  end

  # turn the player to face a direction without moving
  def face_right
    @image = @image_east
  end

  def face_left
    @image = @image_west
  end

  def face_up
    @image = @image_north
  end

  def face_down
    @image = @image_south
  end

  # add xp to the player and check if they level up
  def gain_xp(amount)
    @current_xp += amount
    if @current_xp >= @xp_to_next_level
      @current_xp = 0
      @player_level += 1
      @xp_to_next_level += 100
      @just_levelled_up = true
    end
  end

  def draw
    @image.draw(@x * TILE_SIZE, @y * TILE_SIZE, 1)
  end
end