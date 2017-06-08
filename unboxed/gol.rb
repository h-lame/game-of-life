require './conway'
require './live_cell'
require './dead_cell'

WIDTH = 100
HEIGHT = 20

starting_state = Grid.new
HEIGHT.times do
  row = Row.new
  WIDTH.times do
    row << ((rand(100) >= 50) ? LiveCell.new : DeadCell.new)
  end
  starting_state << row
end

c = Conway.new(starting_state)
loop do
  system('clear')
  c.step
  sleep(0.5)
end
