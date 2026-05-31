require 'minitest/autorun'
require_relative '../npc' # load the npc file for testing

# test tries to create a new npc and checks if a new npc was created
class NpcTest < Minitest::Test
  def test_npc_initializes
    npc = Npc.new
    assert_instance_of Npc, npc
  end
end