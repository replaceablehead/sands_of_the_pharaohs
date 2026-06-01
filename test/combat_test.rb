require 'minitest/autorun'
require_relative '../combat'
require_relative '../character'
require_relative '../npc'

class CombatTest < Minitest::Test
  def setup
   
    @player = Character.new
    @rat = Rat.new
  end

  # test attack roll is inside the expected valuies
  def test_attack_roll_within_range
    result = Combat.attack_roll(@player)
    assert result >= @player.str + 1
    assert result <= @player.str + 6
  end

  # test defence roll is inside expected values
  def test_defence_roll_within_range
    result = Combat.defence_roll(@player)
    assert result >= @player.dex + 1
    assert result <= @player.dex + 6
  end

  # check the damage doesn't go below zero
  def test_hp_never_below_zero
    @rat.hp = 1
    Combat.apply_damage(@rat, 999)
    assert_equal 0, @rat.hp
  
  end

  # test damage reduces hp
  def test_apply_damage_reduces_hp
    starting_hp = @rat.hp
    Combat.apply_damage(@rat, 5)
    assert_equal starting_hp - 5, @rat.hp
  end

  # test dead check returns true when hp goes to zero
  def test_dead_when_hp_zero
    @rat.hp = 0
    assert Combat.dead?(@rat)
  end

  # test dead check returns false when hp is above zero
  def test_not_dead_when_hp_above_zero
    @rat.hp = 10
    refute Combat.dead?(@rat)
  end

  # test resolve attack returns a symbol
  def test_resolve_attack_returns_valid_outcome
    result = Combat.resolve_attack(@player, @rat)
    assert [:hit, :partial, :miss].include?(result)
  end


  # test damage never exceeds maximum ammount
  def test_damage_never_exceeds_maximum
    starting_hp = @rat.hp
    Combat.resolve_attack(@player, @rat)
    max_possible_damage = @player.str + 6
    assert @rat.hp >= starting_hp - max_possible_damage
  end

  # test checks if an enemy is found on the target tile
def test_finds_enemy_on_target_tile
  npcs = [Rat.new]
  npcs[0].x = 5
  npcs[0].y = 5
  result = Combat.check_for_enemy_on_target_tile(npcs, 5, 5)
  assert_instance_of Rat, result
end

# test checks that when no enemy is on the target tile that nil is returned
def test_no_enemy_on_target_tile
  npcs = [Rat.new]
  npcs[0].x = 5
  npcs[0].y = 5
  result = Combat.check_for_enemy_on_target_tile(npcs, 6, 5)
  assert_nil result
end

end