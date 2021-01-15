require 'simplecov'
SimpleCov.start

require 'oystercard'

describe Oystercard do
  context 'when initialsed' do
    it 'has a balance of zero' do
      expect(subject.balance).to eq 0
    end
    it 'entry station is nil by default' do
      expect(subject.entry_station).to eq nil
    end
    it 'exit station is nil by default' do
      expect(subject.exit_station).to eq nil
    end
    it 'has an empty list of journeys by default' do
      expect(subject.journeys_history).to be_empty
    end
    # it 'has a has of entry_station and exit_station' do
    #   expect(subject.journey_storage).to eq({:entry_station => nil, :exit_station => nil})
    # end
  end
  context 'when maximum limit is not exceeded' do
    it 'tops up an amount of 5 to the balance' do
      expect { subject.top_up(5) }.to change(subject, :balance).by(5)
    end
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
    let(:station) { double :station}
    let(:exit_station) { double :station}
    it 'can touch in' do
      expect { subject.touch_in(station) }.to change(subject, :entry_station).from(nil).to(station)
      expect(subject.in_journey?).to eq true
    end
    it 'can touch out' do
      subject.touch_in(station)

      expect { subject.touch_out(exit_station) }.to change(subject, :entry_station).from(station).to(nil)
      expect(subject.in_journey?).to eq false
    end
    context 'when journey is complete' do
      it 'deducts the amount upon touching out' do
        subject.touch_in(station)

        expect { subject.touch_out(exit_station) }.to change(subject, :balance).by(-Oystercard::MINIMUM_CHARGE)
      end
      it 'forgets the entry station' do
        subject.touch_in(station)

        expect { subject.touch_out(exit_station) }.to change(subject, :entry_station).from(station).to(nil)
      end
      it 'saves the exit station' do
        subject.touch_in(station)
      #expect(subject).to respond_to(:touch_out).with.(1).argument
        subject.touch_out(exit_station)
        expect(subject.exit_station).to eq(exit_station)
      end
      it 'stores a journey' do
        #subject.top_up(5)
        subject.touch_in('Paddington')
        subject.touch_out('Marylebone')
        expect(subject.journeys_history).to include(:entry_station => 'Paddington', :exit_station => 'Marylebone')
      end
      it 'shows the trips made' do
        subject.touch_in(station)
        subject.touch_out(exit_station)
        subject.show_journeys

        expect(subject.journeys_history).to include(:entry_station => station, :exit_station => exit_station)
      end
    end
    context 'when journey is not complete' do
      let(:station) { double :station }
      it 'saves the entry station' do
        expect { subject.touch_in(station) }.to change(subject, :entry_station).from(nil).to(station)
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
