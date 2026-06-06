# classes for items in the game

class Item
  attr_accessor :x, :y, :name, :str_bonus, :defence_bonus, :heal_amount
end

class CopperKhopesh < Item
  def initialize
    @name = 'Copper Khopesh'
    @str_bonus = 4
    @defence_bonus = 0
    @heal_amount = 0
    @x = 0
    @y = 0
  end
end

class BronzeKhopesh < Item
  def initialize
    @name = 'Bronze Khopesh'
    @str_bonus = 6
    @defence_bonus = 0
    @heal_amount = 0
    @x = 0
    @y = 0
  end
end

class MeteorSteelKhopesh < Item
  def initialize
    @name = 'Meteor Steel Khopesh'
    @str_bonus = 10
    @defence_bonus = 0
    @heal_amount = 0
    @x = 0
    @y = 0
  end
end

class CopperArmour < Item
  def initialize
    @name = 'Copper Armour'
    @str_bonus = 0
    @defence_bonus = 10
    @heal_amount = 0
    @x = 0
    @y = 0
  end
end

class BronzeArmour < Item
  def initialize
    @name = 'Bronze Armour'
    @str_bonus = 0
    @defence_bonus = 15
    @heal_amount = 0
    @x = 0
    @y = 0
  end
end

class MeteorSteelArmour < Item
  def initialize
    @name = 'Meteor Steel Armour'
    @str_bonus = 0
    @defence_bonus = 20
    @heal_amount = 0
    @x = 0
    @y = 0
  end
end

class HealthPotion < Item
  def initialize
    @name = 'Health Potion'
    @str_bonus = 0
    @defence_bonus = 0
    @heal_amount = 20
    @x = 0
    @y = 0
  end
end