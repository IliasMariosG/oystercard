class Oystercard
  attr_reader :balance
  
  def initialize
    @balance = 0
  end

  def top_up(amount_of_money)
    @balance += amount_of_money
  end

end
