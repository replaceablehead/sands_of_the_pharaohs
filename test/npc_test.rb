require 'minitest/autorun'
require_relative '../npc'

class NpcTest < Minitest::Test
  # test tries to create each npc type and checks it was created
  def test_rat_initializes
    npc = Rat.new
    assert_instance_of Rat, npc
  end

  def test_mummy_initializes
    npc = Mummy.new
    assert_instance_of Mummy, npc
  end

  def test_anubis_guard_light_initializes
    npc = AnubisGuardLight.new
    assert_instance_of AnubisGuardLight, npc
  end

  def test_anubis_guard_dark_initializes
    npc = AnubisGuardDark.new
    assert_instance_of AnubisGuardDark, npc
  end

  def test_cobra_boss_initializes
    npc = CobraBoss.new
    assert_instance_of CobraBoss, npc
  end

  # test checks each npc type has correct default stats
  def test_rat_has_correct_stats
    npc = Rat.new
    assert_equal 10, npc.hp
    assert_equal 3, npc.str
    assert_equal 8, npc.dex
    assert_equal 1, npc.int
    assert_equal 1, npc.wis
  end

  def test_mummy_has_correct_stats
    npc = Mummy.new
    assert_equal 30, npc.hp
    assert_equal 8, npc.str
    assert_equal 3, npc.dex
    assert_equal 2, npc.int
    assert_equal 2, npc.wis
  end

  def test_anubis_guard_light_has_correct_stats
    npc = AnubisGuardLight.new
    assert_equal 50, npc.hp
    assert_equal 12, npc.str
    assert_equal 10, npc.dex
    assert_equal 5, npc.int
    assert_equal 5, npc.wis
  end

  def test_anubis_guard_dark_has_correct_stats
    npc = AnubisGuardDark.new
    assert_equal 70, npc.hp
    assert_equal 15, npc.str
    assert_equal 12, npc.dex
    assert_equal 8, npc.int
    assert_equal 8, npc.wis
  end

  def test_cobra_boss_has_correct_stats
    npc = CobraBoss.new
    assert_equal 150, npc.hp
    assert_equal 20, npc.str
    assert_equal 15, npc.dex
    assert_equal 10, npc.int
    assert_equal 10, npc.wis
  end

  # test checks all npcs have a spawn points
  def test_npc_has_starting_position
    npc = Rat.new
    assert_equal 0, npc.x
    assert_equal 0, npc.y
  end
end