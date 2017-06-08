require 'spec_helper'
require './dead_cell'
require './live_cell'

RSpec.describe DeadCell do
  subject { described_class.new }

  it 'renders as a . character' do
    expect { subject.draw }.to output(".").to_stdout
  end

  it 'remains dead when told to die' do
    expect(subject.die).to be_a DeadCell
  end

  it 'comes alive when told to live' do
    expect(subject.live).to be_a LiveCell
  end
end
