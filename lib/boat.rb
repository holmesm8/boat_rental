class Boat
  attr_reader :type, :price_per_hour, :hours_rented, :returned

  def initialize(type, price_per_hour)
    @type = type
    @price_per_hour = price_per_hour
    @hours_rented = 0
    @returned = false
  end

  def add_hour
    @hours_rented += 1
  end

  def returned
    @returned = true
  end
end
