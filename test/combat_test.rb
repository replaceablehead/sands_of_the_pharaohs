require 'minitest/autorun'
require_relative '../combat' # load the combat file for testing

# test tries to create a new combat instance and checks if it was created
class CombatTest < Minitest::Test
  def test_combat_initializes
    combat = Combat.new
    assert_instance_of Combat, combat
  end
end