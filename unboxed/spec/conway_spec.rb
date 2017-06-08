require 'spec_helper'
require './conway'
require './grid'
require './dead_cell'
require './live_cell'
require './row'

RSpec.describe Conway do
  it 'iterates a grid according to the GoL rules' do
    starting_grid = blinker_start
    game = described_class.new(starting_grid)
    expect {
      game.step
    }.to output(<<~board).to_stdout
      .X.
      .X.
      .X.
    board
    expect {
      game.step
    }.to output(<<~board).to_stdout
      ...
      XXX
      ...
    board
  end

  def blinker_start
    grid = Grid.new
    top_row = Row.new
    top_row << DeadCell.new
    top_row << DeadCell.new
    top_row << DeadCell.new
    grid << top_row

    middle_row = Row.new
    middle_row << LiveCell.new
    middle_row << LiveCell.new
    middle_row << LiveCell.new
    grid << middle_row

    bottom_row = Row.new
    bottom_row << DeadCell.new
    bottom_row << DeadCell.new
    bottom_row << DeadCell.new
    grid << bottom_row

    grid
  end
end
