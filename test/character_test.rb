require 'minitest/autorun'
require_relative '../character'

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
end