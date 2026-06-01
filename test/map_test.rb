require 'minitest/autorun'
require 'json'

class MapTest < Minitest::Test
  def test_map_loads_correct_dimensions
    data = JSON.parse(File.read('maps/level1.tmj'))
    assert_equal 20, data['width']
    assert_equal 16, data['height']
  end
end

# test and see if the map loads the spawn point
def test_map_spawn_point
  data = JSON.parse(File.read('maps/level1.tmj'))
  spawn_layer = data['layers'].find { |l| l['name'] == 'player_spawn' }
  spawn_point = spawn_layer['objects'].find { |o| o['name'] == 'player_spawn' }
  assert_equal 318.0, spawn_point['x']
  assert_equal 467.0, spawn_point['y']
end