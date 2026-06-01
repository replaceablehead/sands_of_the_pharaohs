require 'minitest/autorun'
require_relative '../data_loader' # load the data loader file for testing

class DataLoaderTest < Minitest::Test
  def setup
    @data = JSON.parse(File.read('maps/level1.tmj'))
  end

  # test the the npc_spawn layer can be found
  def test_finds_npc_spawn_layer
    npc_layer = DataLoader.find_layer(@data, 'npc_spawn')
    refute_nil npc_layer
  end

  # test data loader finds the rat. convert the coordinates to a tile location.
  def test_rat_spawn_tile_coordinates
    rat = DataLoader.find_object(@data, 'npc_spawn', 'rat')
    assert_equal 4, (rat['x'] / 32).floor
    assert_equal 1, (rat['y'] / 32).floor
  end
end