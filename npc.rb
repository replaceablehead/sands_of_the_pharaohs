require 'gosu'

class Npc
  attr_accessor :hp, :str, :dex, :int, :wis, :x, :y, :type, :image
  TILE_SIZE = 32

  def draw
    @image.draw(@x * TILE_SIZE, @y * TILE_SIZE, 1)
  end

  # move the npc one tile toward the player position
  def move_toward(player_x, player_y)
    dx = player_x - @x
    dy = player_y - @y
    if dx.abs > dy.abs
      if dx > 0
        @x += 1
      else
        @x -= 1
      end
    else
      if dy > 0
        @y += 1
      else
        @y -= 1
      end
    end
  end
end

class Rat < Npc
  def initialize
    @type = :rat
    @hp = 10
    @str = 3
    @dex = 8
    @int = 1
    @wis = 1
    @x = 0
    @y = 0
    @image = Gosu::Image.new('assets/npcs/rat/rotations/south.png')
  end
end

class Mummy < Npc
  def initialize
    @type = :mummy
    @hp = 30
    @str = 8
    @dex = 3
    @int = 2
    @wis = 2
    @x = 0
    @y = 0
    @image = Gosu::Image.new('assets/npcs/mummy/rotations/south.png')
  end
end

class AnubisGuardLight < Npc
  def initialize
    @type = :anubis_guard_light
    @hp = 50
    @str = 12
    @dex = 10
    @int = 5
    @wis = 5
    @x = 0
    @y = 0
    @image = Gosu::Image.new('assets/npcs/anubis_guard_light/rotations/south.png')
  end
end

class AnubisGuardDark < Npc
  def initialize
    @type = :anubis_guard_dark
    @hp = 70
    @str = 15
    @dex = 12
    @int = 8
    @wis = 8
    @x = 0
    @y = 0
    @image = Gosu::Image.new('assets/npcs/anubis_guard_dark/rotations/south.png')
  end
end

class CobraBoss < Npc
  def initialize
    @type = :cobra_boss
    @hp = 150
    @str = 20
    @dex = 15
    @int = 10
    @wis = 10
    @x = 0
    @y = 0
    @image = Gosu::Image.new('assets/npcs/cobra_boss/rotations/south.png')
  end
end