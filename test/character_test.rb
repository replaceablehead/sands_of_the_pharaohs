require 'minitest/autorun'
require_relative '../character'
require_relative '../combat'

class CharacterTest < Minitest::Test

  # make a new character and check it actually got made
  def test_character_initializes
    character = Character.new(0, 0)
    assert_instance_of Character, character
  end

  # check the character starts with the right stats
  def test_character_has_default_stats
    character = Character.new(0, 0)
    assert_equal 100, character.hp
    assert_equal 10, character.str
    assert_equal 10, character.dex
    assert_equal 10, character.int
    assert_equal 10, character.wis
  end

  # check the character starts at position 0, 0
  def test_character_has_starting_position
    character = Character.new(0, 0)
    assert_equal 0, character.x
    assert_equal 0, character.y
  end

  # move the player right and check x went up by one
  def test_player_moves_right
    character = Character.new(5, 5)
    character.move_right
    assert_equal 6, character.x
  end

  # move the player left and check x went down by one
  def test_player_moves_left
    character = Character.new(5, 5)
    character.move_left
    assert_equal 4, character.x
  end

  # move the player up and check y went down by one
  def test_player_moves_up
    character = Character.new(5, 5)
    character.move_up
    assert_equal 4, character.y
  end

  # move the player down and check y went up by one
  def test_player_moves_down
    character = Character.new(5, 5)
    character.move_down
    assert_equal 6, character.y
  end

  # set hp to zero and check the player is dead
  def test_player_is_dead_when_hp_zero
    character = Character.new(0, 0)
    character.hp = 0
    assert Combat.dead?(character)
  end

  # check the player is alive when hp is above zero
  def test_player_is_not_dead_when_hp_above_zero
    character = Character.new(0, 0)
    refute Combat.dead?(character)
  end

  # give the player some xp and check it was added
  def test_player_gains_xp
    character = Character.new(0, 0)
    character.gain_xp(10)
    assert_equal 10, character.current_xp
  end

  # give the player enough xp to level up and check the level went up
  def test_player_levels_up_when_xp_threshold_reached
    character = Character.new(0, 0)
    character.gain_xp(100)
    assert_equal 2, character.player_level
  end

  # check xp resets back to zero after levelling up
  def test_xp_resets_after_level_up
    character = Character.new(0, 0)
    character.gain_xp(100)
    assert_equal 0, character.current_xp
  end

  # check the xp needed for next level went up after levelling up
  def test_xp_to_next_level_increases
    character = Character.new(0, 0)
    character.gain_xp(100)
    assert_equal 200, character.xp_to_next_level
  end

end