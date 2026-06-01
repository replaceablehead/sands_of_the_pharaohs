# basic placeholder character with default stats
class Character
  attr_accessor :hp, :str, :dex, :int, :wis, :x, :y

  def initialize
    @hp = 100
    @str = 10
    @dex = 10
    @int = 10
    @wis = 10
    @x = 0
    @y = 0
  end
end