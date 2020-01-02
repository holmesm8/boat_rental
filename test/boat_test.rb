require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'

class BoatTest < Minitest::Test

  def test_it_exists
    kayak = Boat.new(:kayak, 20)
    assert_instance_of Boat, kayak
  end

  def test_it_has_attributes
    kayak = Boat.new(:kayak, 20)
    assert_equal :kayak, kayak.type
    assert_equal 20, kayak.price_per_hour
    assert_equal 0, kayak.hours_rented
  end

  def test_it_can_add_hours
    kayak = Boat.new(:kayak, 20)
    assert_equal 0, kayak.hours_rented
    kayak.add_hour
    kayak.add_hour
    kayak.add_hour
    assert_equal 3, kayak.hours_rented
  end
end
