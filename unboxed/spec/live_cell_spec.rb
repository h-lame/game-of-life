require 'spec_helper'
require './live_cell'
require './dead_cell'

RSpec.describe LiveCell do
  subject { described_class.new }

  it 'renders as an X character' do
    expect { subject.draw }.to output("X").to_stdout
  end

  it 'dies when told to die' do
    expect(subject.die).to be_a DeadCell
  end

  it 'stays alive when told to live' do
    expect(subject.live).to be_a LiveCell
  end
end
