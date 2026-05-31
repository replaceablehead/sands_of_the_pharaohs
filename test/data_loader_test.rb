require 'minitest/autorun'
require_relative '../data_loader' # load the data loader file for testing

# test tries to create a new data loader and checks if it was created
class DataLoaderTest < Minitest::Test
  def test_data_loader_initializes
    data_loader = DataLoader.new
    assert_instance_of DataLoader, data_loader
  end
end