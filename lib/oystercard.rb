class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journeys_history

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @journeys_history = []
  end

  def top_up(amount_of_money)
    raise 'Cannot hold more than £90' if @balance + amount_of_money > MAXIMUM_BALANCE

    @balance += amount_of_money
  end

  def touch_in(station)
    raise 'Cannot enter if balance is below £1' if insufficient_balance?
    
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @exit_station = station
    add_journey
  end

  def in_journey?
    !!@entry_station
  end
  
  def show_journeys
    @journeys_history
  end
  
  private

  def deduct(amount)
    @balance -= amount
  end

  def insufficient_balance?
    @balance < MINIMUM_CHARGE
  end

  def add_journey
    @journeys_history << { entry_station: @entry_station , exit_station: @exit_station }
    @entry_station = nil
  end
end
