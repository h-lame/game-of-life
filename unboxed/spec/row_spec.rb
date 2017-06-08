require 'spec_helper'
require './row'
require './live_cell'
require './dead_cell'

RSpec.describe Row do
  subject { described_class.new }
  it 'can render an empty row' do
    expect { subject.draw }.to output("\n").to_stdout
  end

  it 'can render a full row' do
    subject << DeadCell.new
    subject << LiveCell.new
    subject << DeadCell.new
    expect { subject.draw }.to output(".X.\n").to_stdout
  end

  it 'allows iteration over cells' do
    row = described_class.new
    row << DeadCell.new
    row << DeadCell.new
    row << DeadCell.new

    thing = double(:foo, foo: true)

    expect(thing).to receive(:foo).exactly(3).times

    row.each_cell { |x| thing.foo }
  end

  it 'allows iteration over sets of neighbours' do
    row = described_class.new
    first_cell = DeadCell.new
    second_cell = DeadCell.new
    third_cell = DeadCell.new
    row << first_cell
    row << second_cell
    row << third_cell

    expect(row).to expose_neighbour_sets([
      [first_cell, second_cell],
      [first_cell, second_cell, third_cell],
      [second_cell, third_cell]
    ])
  end

  it 'when adding a cell to a row it tells the previous cell it has a neighbour' do
    row = described_class.new
    left_cell = DeadCell.new
    middle_cell = DeadCell.new
    right_cell = DeadCell.new

    row << left_cell

    expect(left_cell).to have_neighbours(0)

    row << middle_cell

    expect(left_cell).to have_neighbours(1)
    expect(middle_cell).to have_neighbours(1)

    row << right_cell

    expect(left_cell).to have_neighbours(1)
    expect(middle_cell).to have_neighbours(2)
    expect(right_cell).to have_neighbours(1)
  end
end
