class Npc
  attr_accessor :hp, :str, :dex, :int, :wis, :x, :y, :type
end

class Rat < Npc
  def initialize
    super
    @type = :rat
    @hp = 10
    @str = 3
    @dex = 8
    @int = 1
    @wis = 1
    # set some place holder coodinates
    @x = 0
    @y = 0
  end
end

class Mummy < Npc
  def initialize
    super
    @type = :mummy
    @hp = 30
    @str = 8
    @dex = 3
    @int = 2
    @wis = 2
     # set some place holder coodinates
    @x = 0
    @y = 0
  end
end

class AnubisGuardLight < Npc
  def initialize
    super
    @type = :anubis_guard_light
    @hp = 50
    @str = 12
    @dex = 10
    @int = 5
    @wis = 5
     # set some place holder coodinates
    @x = 0
    @y = 0
  end
end

class AnubisGuardDark < Npc
  def initialize
    super
    @type = :anubis_guard_dark
    @hp = 70
    @str = 15
    @dex = 12
    @int = 8
    @wis = 8
     # set some place holder coodinates
    @x = 0
    @y = 0
  end
end

class CobraBoss < Npc
  def initialize
    super
    @type = :cobra_boss
    @hp = 150
    @str = 20
    @dex = 15
    @int = 10
    @wis = 10
     # set some place holder coodinates
    @x = 0
    @y = 0
  end
end