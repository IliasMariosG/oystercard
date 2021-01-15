require 'simplecov'
SimpleCov.start

require 'oystercard'

describe Oystercard do
  context 'when initialsed' do
    it 'has a balance of zero' do
      expect(subject.balance).to eq 0
    end
    it 'has an empty list of journeys by default' do
      expect(subject.journeys_history).to be_empty
    end
  end
  describe '#top up' do
    context 'when maximum limit (£90) is not exceeded' do
      it 'adds 5 to the balance' do
        expect { subject.top_up(5) }.to change(subject, :balance).by(5)
      end
    end
    context 'when maximum limit (£90) is exceeded' do
      it 'raises error' do
        maximum_balance = Oystercard::MAXIMUM_BALANCE

        subject.top_up(90)

        expect { subject.top_up(1) }.to raise_error "Cannot hold more than £#{maximum_balance}"
      end
    end
  end
  context 'when sufficient balance (equal to or over the minimum required (£1))' do
    before(:each) { subject.top_up(50) }
    let(:entrance_station) { double :station}
    let(:exit_station) { double :station}
    describe '#touch in' do
      it 'can touch in' do
        expect(subject.touch_in(entrance_station)).to eq entrance_station
        expect(subject.in_journey?).to eq true
      end
      context 'when journey is not complete' do
        it 'saves the entry station' do
          subject.touch_in(entrance_station)
          expect(subject.entry_station).to eq entrance_station
        end
      end
    end
    describe '#touch out' do
      before do
        subject.touch_in(entrance_station)
      end
      it 'can touch out' do
        expect { subject.touch_out(exit_station) }.to change(subject, :entry_station).from(entrance_station).to(nil)
        expect(subject.in_journey?).to eq false
      end
      context 'when journey is complete' do
        it 'deducts the amount upon touching out' do
          expect { subject.touch_out(exit_station) }.to change(subject, :balance).by(-Oystercard::MINIMUM_CHARGE)
        end
        it 'forgets the entry station' do
          expect { subject.touch_out(exit_station) }.to change(subject, :entry_station).from(entrance_station).to(nil)
        end
        it 'saves the exit station' do
          subject.touch_out(exit_station)
          expect(subject.exit_station).to eq(exit_station)
        end
        it 'stores a journey' do
          subject.touch_out(exit_station)
          expect(subject.journeys_history).to include(:entry_station => entrance_station, :exit_station => exit_station)
        end
        describe '#show_journeys' do
          it 'shows the trips made' do
            subject.touch_out(exit_station)
            subject.show_journeys

            expect(subject.journeys_history).to include(:entry_station => entrance_station, :exit_station => exit_station)
          end
        end
      end
    end
    
  end
  context 'when insufficient balance (with an amount below the minimum(£1))' do
    let(:station) { double :station }
    describe '#touch in' do
      it 'raises error' do
        minimum_balance = Oystercard::MINIMUM_CHARGE

        expect { subject.touch_in(station) }.to raise_error "Cannot enter if balance is below £#{minimum_balance}"
      end
    end
  end
end
