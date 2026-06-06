require 'minitest/autorun'
require_relative '../combat'
require_relative '../character'
require_relative '../npc'

class CombatTest < Minitest::Test

  # set up a player and a rat to use in the tests
  def setup
    @player = Character.new(0, 0)
    @rat = Rat.new
  end

  # check the attack roll lands somewhere between str plus 1 and str plus 6
  def test_attack_roll_within_range
    result = Combat.attack_roll(@player)
    assert result >= @player.str + 1
    assert result <= @player.str + 6
  end

  # check the defence roll lands somewhere between dex plus 1 and dex plus 6
  def test_defence_roll_within_range
    result = Combat.defence_roll(@player)
    assert result >= @player.dex + 1
    assert result <= @player.dex + 6
  end

  # hit the rat with 999 damage and check hp doesnt go below zero
  def test_hp_never_below_zero
    @rat.hp = 1
    Combat.apply_damage(@rat, 999)
    assert_equal 0, @rat.hp
  end

  # do 5 damage and check the rats hp went down by 5
  def test_apply_damage_reduces_hp
    starting_hp = @rat.hp
    Combat.apply_damage(@rat, 5)
    assert_equal starting_hp - 5, @rat.hp
  end

  # set hp to zero and check the rat is dead
  def test_dead_when_hp_zero
    @rat.hp = 0
    assert Combat.dead?(@rat)
  end

  # set hp above zero and check the rat is still alive
  def test_not_dead_when_hp_above_zero
    @rat.hp = 10
    refute Combat.dead?(@rat)
  end

  # perform an attack and check we get back hit partial or miss
  def test_perform_attack_returns_valid_outcome
    result = Combat.perform_attack(@player, @rat)
    assert result == 'hit' or result == 'partial' or result == 'miss'
  end

  # check the damage dealt never goes over the maximum possible
  def test_damage_never_exceeds_maximum
    starting_hp = @rat.hp
    Combat.perform_attack(@player, @rat)
    max_possible_damage = @player.str + 6
    assert @rat.hp >= starting_hp - max_possible_damage
  end

  # put a rat at position 5 5 and check we can find it there
  def test_finds_enemy_on_target_tile
    npcs = Array.new
    npcs << Rat.new
    npcs[0].x = 5
    npcs[0].y = 5
    result = Combat.check_for_enemy_on_target_tile(npcs, 5, 5)
    assert_instance_of Rat, result
  end

  # put a rat at 5, 5 and check there is nothing at 6 5
  def test_no_enemy_on_target_tile
    npcs = Array.new
    npcs << Rat.new
    npcs[0].x = 5
    npcs[0].y = 5
    result = Combat.check_for_enemy_on_target_tile(npcs, 6, 5)
    assert_nil result
  end

end