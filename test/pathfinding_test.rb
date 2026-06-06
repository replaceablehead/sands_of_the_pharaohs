require 'minitest/autorun'
require_relative '../pathfinding'
require_relative '../map'

class PathfindingTest < Minitest::Test

  def setup
    @map = Map.new('maps/level1.tmj')
  end

  # test tries to find a path between two open tiles
  def test_finds_path_between_two_open_tiles
    result = Pathfinding.calculate_path_to_target(8, 7, 10, 7, @map)
    refute_nil result
  end

  # test returns nil when no path exists
  def test_returns_nil_when_no_path
    result = Pathfinding.calculate_path_to_target(0, 0, 1, 0, @map)
    assert_nil result
  end

  # test that the first step is towards the target
  def test_first_step_moves_toward_target
    result = Pathfinding.calculate_path_to_target(8, 7, 10, 7, @map)
    assert_equal [9, 7], result
  end

end