require 'minitest/autorun'
require_relative '../hud'

class HudTest < Minitest::Test

  # test hud initializes
  def test_hud_initializes
    hud = Hud.new
    assert_instance_of Hud, hud
  end

  # test hud has event log array
  def test_hud_has_event_log
    hud = Hud.new
    assert_instance_of Array, hud.event_log
  end

  # test event log is empty at start
  def test_event_log_starts_empty
    hud = Hud.new
    assert_equal 0, hud.event_log.length
  end

  # test if we can add a message to the event log
  def test_add_message_to_event_log
    hud = Hud.new
    hud.add_message('player hit mummy for 5 damage')
    assert_equal 1, hud.event_log.length
  end

end
