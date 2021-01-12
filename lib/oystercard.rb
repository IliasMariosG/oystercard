class Oystercard
  attr_reader :balance, :in_journey

  MAXIMUM_BALANCE = 90
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount_of_money)
    raise 'Cannot hold more than 90' if @balance + amount_of_money > MAXIMUM_BALANCE

    @balance += amount_of_money
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
