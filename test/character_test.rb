require 'minitest/autorun'
require_relative '../character' # load the character file for testing

# test tries to create a new character and checks if a new character was created
class CharacterTest < Minitest::Test
  def test_character_initializes
    character = Character.new
    assert_instance_of Character, character
  end
end