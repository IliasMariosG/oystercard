class Oystercard
  attr_reader :balance, :in_journey

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount_of_money)
    raise 'Cannot hold more than 90' if @balance + amount_of_money > MAXIMUM_BALANCE

    @balance += amount_of_money
  end

  def touch_in
    raise 'Cannot enter if balance is below £1' if @balance < MINIMUM_CHARGE
    
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
