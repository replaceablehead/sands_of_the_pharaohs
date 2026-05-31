require 'minitest/autorun'
require_relative '../map' # load the map file for testing

# test tries to create a new map and checks if a new map was created
class MapTest < Minitest::Test
  def test_map_initializes
    map = Map.new
    assert_instance_of Map, map
  end
end