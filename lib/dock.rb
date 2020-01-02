class Dock
  attr_reader :name, :max_rental_time, :rental_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    rental_time = if boat.hours_rented >= @max_rental_time
      then @max_rental_time * boat.price_per_hour
    else
      boat.hours_rented * boat.price_per_hour
    end
    {:card_number => @rental_log[boat].credit_card_number,
      :amount => rental_time
      }
  end

  def log_hour
    @rental_log.map {|boat, person| boat.add_hour}

  end

  def return(boat)
    boat.returned
    @rental_log.delete[boat]
  end

  # def revenue
  #
  # end
end
