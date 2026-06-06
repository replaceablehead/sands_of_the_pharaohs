require 'gosu'

# creates a character class
class Character
  attr_accessor :hp, :max_hp, :str, :dex, :int, :wis, :defence, :x, :y, :image, :current_xp, :xp_to_next_level, :player_level, :just_levelled_up, :hit_timer
  TILE_SIZE = 32

  # initialise the class with some default starting values
  def initialize(x, y)
    @hp = 100
    @max_hp = 100
    @str = 10
    @dex = 10
    @int = 10
    @wis = 10
    @defence = 0
    @x = x
    @y = y
    @current_xp = 0
    @player_level = 1
    @xp_to_next_level = 100
    @just_levelled_up = false
    @hit_timer = 0

    # load in the sprites for each direction the character can face
    @image_north = Gosu::Image.new('assets/character/rotations/north.png')
    @image_south = Gosu::Image.new('assets/character/rotations/south.png')
    @image_east  = Gosu::Image.new('assets/character/rotations/east.png')
    @image_west  = Gosu::Image.new('assets/character/rotations/west.png')

    # set the default starting sprite image to the south facing image
    @image = @image_south
  end

  # move the player by one tile in the direction indicated
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

  # turn the player to face a different direction without moving
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

  # add xp to the player character and check if player has leveled up
  # if a new level is reached, increase the max hp by 10 and make health full
  # set just leveled up to true so the level up module knows to show the level up screen
  def gain_xp(amount)
    @current_xp += amount
    if @current_xp >= @xp_to_next_level
      @current_xp = 0
      @player_level += 1
      @xp_to_next_level += 100
      @max_hp += 10
      @hp = @max_hp
      @just_levelled_up = true
    end
  end

  def update
  end

  # draw the player with a red tint if they have just been hit
  def draw
    if @hit_timer > 0
      @image.draw(@x * TILE_SIZE, @y * TILE_SIZE, 1, 1, 1, Gosu::Color::RED)
    else
      @image.draw(@x * TILE_SIZE, @y * TILE_SIZE, 1)
    end
  end

end