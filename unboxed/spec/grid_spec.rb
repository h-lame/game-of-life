require 'spec_helper'
require './grid'
require './row'
require './live_cell'
require './dead_cell'

RSpec.describe Grid do
  it 'can be drawn on the screen at the supplied width and height' do
    grid = described_class.new
    top_row = Row.new
    top_row << DeadCell.new
    top_row << DeadCell.new
    top_row << DeadCell.new
    grid << top_row

    middle_row = Row.new
    middle_row << DeadCell.new
    middle_row << DeadCell.new
    middle_row << DeadCell.new
    grid << middle_row

    bottom_row = Row.new
    bottom_row << DeadCell.new
    bottom_row << DeadCell.new
    bottom_row << DeadCell.new
    grid << bottom_row
    expect {
      grid.draw
    }.to output(<<~board).to_stdout
      ...
      ...
      ...
board
  end

  it 'allows iteration over rows' do
    grid = described_class.new
    top_row = Row.new
    top_row << DeadCell.new
    top_row << DeadCell.new
    top_row << DeadCell.new
    grid << top_row

    middle_row = Row.new
    middle_row << DeadCell.new
    middle_row << DeadCell.new
    middle_row << DeadCell.new
    grid << middle_row

    bottom_row = Row.new
    bottom_row << DeadCell.new
    bottom_row << DeadCell.new
    bottom_row << DeadCell.new
    grid << bottom_row

    thing = double(:foo, foo: true)

    expect(thing).to receive(:foo).exactly(3).times

    grid.each_row { |x| thing.foo }
  end

  it 'when adding a row to a grid it tells the previous row about the new neighbours' do
    grid = described_class.new
    top_row = Row.new
    top_left_cell = DeadCell.new
    top_middle_cell = DeadCell.new
    top_right_cell = DeadCell.new

    top_row << top_left_cell
    top_row << top_middle_cell
    top_row << top_right_cell

    grid << top_row

    middle_row = Row.new
    middle_left_cell = DeadCell.new
    middle_middle_cell = DeadCell.new
    middle_right_cell = DeadCell.new

    middle_row << middle_left_cell
    middle_row << middle_middle_cell
    middle_row << middle_right_cell

    grid << middle_row

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(3).times
    top_left_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(5).times
    top_middle_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(3).times
    top_right_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(3).times
    middle_left_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(5).times
    middle_middle_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(3).times
    middle_right_cell.each_neighbour { |x| counter.foo }

    bottom_row = Row.new
    bottom_left_cell = DeadCell.new
    bottom_middle_cell = DeadCell.new
    bottom_right_cell = DeadCell.new

    bottom_row << bottom_left_cell
    bottom_row << bottom_middle_cell
    bottom_row << bottom_right_cell

    grid << bottom_row

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(3).times
    top_left_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(5).times
    top_middle_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(3).times
    top_right_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(5).times
    middle_left_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(8).times
    middle_middle_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(5).times
    middle_right_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(3).times
    bottom_left_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(5).times
    bottom_middle_cell.each_neighbour { |x| counter.foo }

    counter = double(:foo, foo: true)
    expect(counter).to receive(:foo).exactly(3).times
    bottom_right_cell.each_neighbour { |x| counter.foo }
  end
end
