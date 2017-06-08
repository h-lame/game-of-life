class World
  def initialize(state)
    @cells = state
    @grid_y  = state.length
    @grid_x = @cells[0].length
  end

  def count_neighbours(x,y)
    [ self[x-1,y-1], self[x-1,y], self[x-1,y+1],
      self[x,  y-1],              self[x,  y+1],
      self[x+1,y-1], self[x+1,y], self[x+1,y+1] ].select {|c| c == 'x'}.count
  end

  def new_value_for(x,y)
    (([2,3].include? count_neighbours(x,y)) && self[x,y] == 'x') && (return 'x')
    ((count_neighbours(x,y) ==3) && self[x,y] == '.') && return
    '.'
  end

  def evolve
    @cells = (0...@grid_y).map {|y| (0...@grid_x).map {|x| new_value_for(x,y) || 'x' } }
  end

  def [](x,y)
    (x < 0 || y < 0) && return
    (x >= @grid_x || y >= @grid_y) && return
    @cells[y][x]
  end
end
