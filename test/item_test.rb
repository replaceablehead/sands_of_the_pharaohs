require 'minitest/autorun'
require_relative '../item' # load the items file for testing

# test tries to create a new item and checks if a new item was created
class ItemsTest < Minitest::Test
  def test_item_initializes
    item = Item.new
    assert_instance_of Item, item
  end
end