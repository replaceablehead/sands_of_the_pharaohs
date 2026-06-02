# item classes for weapons and armour

class Item
  attr_accessor :x, :y, :name, :str_bonus, :def_bonus
end

class CopperKhopesh < Item
  def initialize
    @name = 'Copper Khopesh'
    @str_bonus = 2
    @def_bonus = 0
    @x = 0
    @y = 0
  end
end

class BronzeKhopesh < Item
  def initialize
    @name = 'Bronze Khopesh'
    @str_bonus = 4
    @def_bonus = 0
    @x = 0
    @y = 0
  end
end

class MeteorSteelKhopesh < Item
  def initialize
    @name = 'Meteor Steel Khopesh'
    @str_bonus = 6
    @def_bonus = 0
    @x = 0
    @y = 0
  end
end

class CopperArmour < Item
  def initialize
    @name = 'Copper Armour'
    @str_bonus = 0
    @def_bonus = 2
    @x = 0
    @y = 0
  end
end

class BronzeArmour < Item
  def initialize
    @name = 'Bronze Armour'
    @str_bonus = 0
    @def_bonus = 4
    @x = 0
    @y = 0
  end
end

class MeteorSteelArmour < Item
  def initialize
    @name = 'Meteor Steel Armour'
    @str_bonus = 0
    @def_bonus = 6
    @x = 0
    @y = 0
  end
end