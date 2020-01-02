require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/renter'
require './lib/dock'

class DockTest < Minitest::Test

  def setup
    @dock = Dock.new("The Rowing Dock", 3)
    @kayak_1 = Boat.new(:kayak, 20)
    @kayak_2 = Boat.new(:kayak, 20)
    @canoe = Boat.new(:canoe, 25)
    @sup_1 = Boat.new(:standup_paddle_board, 15)
    @sup_2 = Boat.new(:standup_paddle_board, 15)
    @patrick = Renter.new("Patrick Star", "4242424242424242")
    @eugene = Renter.new("Eugene Crabs", "1313131313131313")
    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)

  end

  def test_it_exists
    assert_instance_of Dock, @dock
  end

  def test_it_has_attributes
    assert_equal "The Rowing Dock", @dock.name
    assert_equal 3, @dock.max_rental_time
  end

  def test_it_can_rent_out_boat_to_renter
    @dock.rent(@sup_1, @eugene)
    assert_equal ({@kayak_1 => @patrick, @kayak_2 => @patrick, @sup_1 => @eugene}), @dock.rental_log
  end

  def test_it_can_charge
    @kayak_1.add_hour
    @kayak_1.add_hour
    assert_equal ({:card_number => "4242424242424242", :amount => 40}), @dock.charge(@kayak_1)
  end

  def test_it_will_not_charge_past_max_hour
    @dock.rent(@sup_1, @eugene)
    @sup_1.add_hour
    @sup_1.add_hour
    @sup_1.add_hour
    assert_equal ({:card_number => "1313131313131313", :amount => 45}), @dock.charge(@sup_1)
    @sup_1.add_hour
    @sup_1.add_hour
    assert_equal ({:card_number => "1313131313131313", :amount => 45}), @dock.charge(@sup_1)
  end

  def test_it_can_log_hour
    @dock.rent(@sup_1, @eugene)
    @dock.log_hour
    assert_equal 1, @kayak_1.hours_rented
    assert_equal 1, @kayak_2.hours_rented
    assert_equal 1, @sup_1.hours_rented
  end

  def test_it_will_not_charge_revenue_until_returned
    skip
    @dock.log_hour
    @dock.rent(@canoe, @patrick)
    @dock.log_hour
    assert_equal 0, @dock.revenue
    @dock.return(@kayak_1)
    @dock.return(@kayak_2)
    @dock.return(@canoe)
  end
end



#
# # kayak_1 and kayak_2 are rented an additional hour
# pry(main)> dock.log_hour
# pry(main)> dock.rent(canoe, patrick)
# # kayak_1, kayak_2, and canoe are rented an additional hour
# pry(main)> dock.log_hour
# # Revenue should not be generated until boats are returned
# pry(main)> dock.revenue
# # => 0
# pry(main)> dock.return(kayak_1)
# pry(main)> dock.return(kayak_2)
# pry(main)> dock.return(canoe)
# # Revenue thus far
# pry(main)> dock.revenue
# # => 105
# # Rent Boats out to a second Renter
# pry(main)> dock.rent(sup_1, eugene)
# pry(main)> dock.rent(sup_2, eugene)
# pry(main)> dock.log_hour
# pry(main)> dock.log_hour
# pry(main)> dock.log_hour
# # Any hours rented past the max rental time don't factor into revenue
# pry(main)> dock.log_hour
# pry(main)> dock.log_hour
# pry(main)> dock.return(sup_1)
# pry(main)> dock.return(sup_2)
# # Total revenue
# pry(main)> dock.revenue
# # => 19
