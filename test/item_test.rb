require 'minitest/autorun'
require_relative '../item'

class ItemTest < Minitest::Test
  # test each item initializes correctly
  def test_copper_khopesh_initializes
    item = CopperKhopesh.new
    assert_instance_of CopperKhopesh, item
  end
  def test_bronze_khopesh_initializes
    item = BronzeKhopesh.new
    assert_instance_of BronzeKhopesh, item
  end

  def test_meteor_steel_khopesh_initializes
    item = MeteorSteelKhopesh.new
    assert_instance_of MeteorSteelKhopesh, item
  end

  def test_helmet_initializes
    item = Helmet.new
    assert_instance_of Helmet, item
  end

  def test_chestplate_initializes
    item = Chestplate.new
    assert_instance_of Chestplate, item
  end

  def test_boots_initializes
    item = Boots.new
    assert_instance_of Boots, item
  end

  def test_gauntlets_initializes
    item = Gauntlets.new
    assert_instance_of Gauntlets, item
  end

  def test_health_potion_initializes
    item = HealthPotion.new
    assert_instance_of HealthPotion, item
  end

  def test_gold_initializes
    item = Gold.new
    assert_instance_of Gold, item
  end

  # test item stat bonuses
  def test_copper_khopesh_str_bonus
    item = CopperKhopesh.new
    assert_equal 3, item.str_bonus
  end

  def test_bronze_khopesh_str_bonus
    item = BronzeKhopesh.new
    assert_equal 6, item.str_bonus
  end

  def test_meteor_steel_khopesh_str_bonus
    item = MeteorSteelKhopesh.new
    assert_equal 12, item.str_bonus
  end

  def test_helmet_dex_bonus
    item = Helmet.new
    assert_equal 2, item.dex_bonus
  end

  def test_chestplate_dex_bonus
    item = Chestplate.new
    assert_equal 5, item.dex_bonus
  end

  def test_boots_dex_bonus
    item = Boots.new
    assert_equal 2, item.dex_bonus
  end

  def test_gauntlets_str_bonus
    item = Gauntlets.new
    assert_equal 2, item.str_bonus
  end

  def test_health_potion_heal_amount
    item = HealthPotion.new
    assert_equal 30, item.heal_amount
  end

  def test_gold_default_value
    item = Gold.new
    assert_equal 10, item.value
  end

  # test all items have a spawn point
  def test_item_has_starting_position
    item = CopperKhopesh.new
    assert_equal 0, item.x
    assert_equal 0, item.y
  end
end