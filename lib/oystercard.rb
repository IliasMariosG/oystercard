class Oystercard
  attr_reader :balance, :in_journey, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount_of_money)
    raise 'Cannot hold more than 90' if @balance + amount_of_money > MAXIMUM_BALANCE

    @balance += amount_of_money
  end

  def touch_in(station)
    raise 'Cannot enter if balance is below £1' if @balance < MINIMUM_CHARGE
    
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end
  #NOT TESTED YET!
  def in_journey?
    !!@entry_station
  end
  private

  def deduct(amount)
    @balance -= amount
  end
end
