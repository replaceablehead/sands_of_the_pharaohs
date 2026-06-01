class Item
  attr_accessor :x, :y, :name, :str_bonus, :dex_bonus, :heal_amount, :value
end
# set up some instances of the items class with some placeholder values
class CopperKhopesh < Item
  attr_reader :str_bonus

  def initialize
    @name = 'Copper Khopesh'
    @str_bonus = 3
    @x = 0
    @y = 0
  end
end

class BronzeKhopesh < Item
  attr_reader :str_bonus

  def initialize
    @name = 'Bronze Khopesh'
    @str_bonus = 6
    @x = 0
    @y = 0
  end
end

class MeteorSteelKhopesh < Item
  attr_reader :str_bonus

  def initialize
    @name = 'Meteor Steel Khopesh'
    @str_bonus = 12
    @x = 0
    @y = 0
  end
end

class Helmet < Item
  attr_reader :dex_bonus

  def initialize
    @name = 'Helmet'
    @dex_bonus = 2
    @x = 0
    @y = 0
  end
end

class Chestplate < Item
  attr_reader :dex_bonus

  def initialize
    @name = 'Chestplate'
    @dex_bonus = 5
    @x = 0
    @y = 0
  end
end

class Boots < Item
  attr_reader :dex_bonus

  def initialize
    @name = 'Boots'
    @dex_bonus = 2
    @x = 0
    @y = 0
  end
end

class Gauntlets < Item
  attr_reader :str_bonus

  def initialize
    @name = 'Gauntlets'
    @str_bonus = 2
    @x = 0
    @y = 0
  end
end

class HealthPotion < Item
  attr_reader :heal_amount

  def initialize
    @name = 'Health Potion'
    @heal_amount = 30
    @x = 0
    @y = 0
  end
end

class Gold < Item
  attr_accessor :value

  def initialize(value = 10)
    @name = 'Gold'
    @value = value
    @x = 0
    @y = 0
  end
end