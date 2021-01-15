require 'simplecov'
SimpleCov.start
require 'station'

describe Station do

  subject { described_class.new('Old Street', 1) }

  it 'has a name' do
    expect(subject.name).to eq 'Old Street'
  end
                                       
  it 'is in a zone' do
    expect(subject.zone).to eq 1
  end
  
end
