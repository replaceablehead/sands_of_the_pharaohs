require 'minitest/autorun'
require 'json'
require_relative '../map'

class MapTest < Minitest::Test
  def test_map_loads_correct_dimensions
    data = JSON.parse(File.read('maps/level1.tmj'))
    assert_equal 20, data['width']
    assert_equal 16, data['height']
  end

  def test_map_spawn_point
    data = JSON.parse(File.read('maps/level1.tmj'))
    spawn_layer = data['layers'].find { |l| l['name'] == 'player_spawn' }
    spawn_point = spawn_layer['objects'].find { |o| o['name'] == 'player_spawn' }
    assert_equal 318.0, spawn_point['x']
    assert_equal 467.0, spawn_point['y']
  end

  def test_floor_tile_is_walkable
    map = Map.new('maps/level1.tmj')
    assert_equal true, map.detect_collision(3, 7)
  end

  def test_wall_tile_is_not_walkable
    map = Map.new('maps/level1.tmj')
    assert_equal false, map.detect_collision(0, 0)
  end

  #def test_debug_walkable
    #map = Map.new('maps/level1.tmj')
    #puts map.detect_collision(0, 0)
    #puts map.detect_collision(3, 7)
  #end
  
  # test checks player is on stairs when standing on a stairs tile
  def test_player_is_on_stairs
    map = Map.new('maps/level1.tmj')
    assert_equal true, map.on_stairs?(18, 14)
  end

# test checks player is not on stairs when not standing on a stairs tile
  def test_player_is_not_on_stairs
    map = Map.new('maps/level1.tmj')
    assert_equal false, map.on_stairs?(8, 7)
  end
end