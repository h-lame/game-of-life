require './grid'
require './row'

class Conway
  def initialize(starting_grid)
    @grid = starting_grid
  end

  def step
    new_grid = Grid.new
    @grid.each_row do |row|
      new_row = Row.new
      row.each_cell do |cell|
        new_row << apply_rules(cell)
      end
      new_grid << new_row
    end
    @grid = new_grid
    @grid.draw
  end

  def apply_rules(cell)
    cell.step
  end

  private
  attr_accessor :grid
end
