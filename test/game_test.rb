require 'minitest/autorun'
require_relative '../main' # load up the main game file for testing

# test tries to create a new game and checks if a new game was created
class GameTest < Minitest::Test
  def test_game_initializes
    game = Game.new
    assert_instance_of Game, game
  end
end