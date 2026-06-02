require 'minitest/autorun'
require_relative '../character'
require_relative '../combat'

class CharacterTest < Minitest::Test
  # test tries to create a new character and checks if a charater is created
  def test_character_initializes
    character = Character.new
    assert_instance_of Character, character
  end

  # test checks character has the expected default stats
  def test_character_has_default_stats
    character = Character.new
    assert_equal 100, character.hp
    assert_equal 10, character.str
    assert_equal 10, character.dex
    assert_equal 10, character.int
    assert_equal 10, character.wis
  end

  # test checks character has a spawn point
  def test_character_has_starting_position
    character = Character.new
    assert_equal 0, character.x
    assert_equal 0, character.y
  end
  
  # test player movement
  def test_player_moves_right
  character = Character.new(5, 5)
  character.move_right
  assert_equal 6, character.x
  end

  def test_player_moves_left
  character = Character.new(5, 5)
  character.move_left
  assert_equal 4, character.x
  end

  def test_player_moves_up
    character = Character.new(5, 5)
    character.move_up
    assert_equal 4, character.y
  end

  def test_player_moves_down
    character = Character.new(5, 5)
    character.move_down
    assert_equal 6, character.y
  end
end

  # test checks player dies when hp reaches zero
  def test_player_is_dead_when_hp_zero
    character = Character.new
    character.hp = 0
    assert Combat.dead?(character)
  end

  # test checks player is still alive when hp is above zero
  def test_player_is_not_dead_when_hp_above_zero
    character = Character.new
    refute Combat.dead?(character)
  end
  # test checks player gains xp when killing a rat
def test_player_gains_xp_on_kill
  character = Character.new
  character.gain_xp(10)
  assert_equal 10, character.current_xp
end

# test checks player levels up when xp reaches threshold
def test_player_levels_up_when_xp_threshold_reached
  character = Character.new
  character.gain_xp(100)
  assert_equal 2, character.player_level
end

# test checks xp resets after levelling up
def test_xp_resets_after_level_up
  character = Character.new
  character.gain_xp(100)
  assert_equal 0, character.current_xp
end

# test checks xp to next level increases after levelling up
def test_xp_to_next_level_increases
  character = Character.new
  character.gain_xp(100)
  assert_equal 200, character.xp_to_next_level
end