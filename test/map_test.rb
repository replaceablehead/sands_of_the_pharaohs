require 'minitest/autorun'
require_relative '../map'

class FakeWindow
  # fake window as stand in for gosu-tiled to run without opening a real window
end

class MapTest < Minitest::Test
  def test_map_loads_correct_dimensions
    map = Map.new(FakeWindow.new, 'maps/level1.tmj')
    assert_equal 20, map.width
    assert_equal 16, map.height
  end
end