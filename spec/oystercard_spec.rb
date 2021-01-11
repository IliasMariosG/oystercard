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
end
