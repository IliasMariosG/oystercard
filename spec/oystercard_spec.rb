require 'simplecov'
SimpleCov.start

require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end
  it 'tops up the balance' do
    expect { subject.top_up(5) }.to change(subject, :balance).by(5)
  end
  context 'when maximum limit is exceeded' do
    it 'raises error' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE

      subject.top_up(90)

      expect { subject.top_up(1) }.to raise_error "Cannot hold more than #{maximum_balance}"
    end
  end
  context 'when sufficient balance (equal to or over the minimum required (£1))' do
    before(:each) { subject.top_up(50) }
    it 'can touch in' do
      expect { subject.touch_in }.to change(subject, :in_journey).from(false).to(true)
    end
    it 'can touch out' do
      subject.touch_in
      subject.touch_out
      
      expect(subject.in_journey).to eq false
    end
    context 'when journey is complete' do
      it 'deducts the amount upon touching out' do
        subject.touch_in
        expect { subject.touch_out }.to change(subject, :balance).by(-Oystercard::MINIMUM_CHARGE)
      end
    end
  end
  it 'in_journey returns false by default' do
    expect(subject.in_journey).to eq false
  end
  
  context 'when insufficient balance (with an amount below the minimum(£1))' do
    describe '#touch in' do
      it 'raises error' do
        minimum_balance = Oystercard::MINIMUM_CHARGE
        
        expect { subject.touch_in }.to raise_error "Cannot enter if balance is below £#{minimum_balance}"
      end
    end
  end
end
