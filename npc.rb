require 'gosu'
require_relative 'pathfinding'

class Npc
  attr_accessor :hp, :str, :dex, :int, :wis, :x, :y, :type, :image
  TILE_SIZE = 32

  def draw
    @image.draw(@x * TILE_SIZE, @y * TILE_SIZE, 1)
  end

  # move the npc one tile toward the player using bfs pathfinding
  # only move if the player is within 6 tiles
  # stop one tile away from the player and don't move onto other npcs
  def move_toward(player_x, player_y, map, npcs)
    dx = player_x - @x
    dy = player_y - @y

    # check if player is within detection range
    if dx.abs + dy.abs > 6
      return
    end

    # if already adjacent to player stop and attack instead of moving
    if dx.abs + dy.abs == 1
      return
    end

    next_step = Pathfinding.find_path(@x, @y, player_x, player_y, map)
    if next_step
      # check no other npc is already on the target tile
      tile_occupied = false
      npcs.each do |other|
        if other != self && other.x == next_step[0] && other.y == next_step[1]
          tile_occupied = true
        end
      end
      if !tile_occupied
        @x = next_step[0]
        @y = next_step[1]
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