class Row
  def initialize
    @children = []
  end

  def <<(cell)
    if children.last
      cell.add_neighbour children.last
      children.last.add_neighbour cell
    end
    children << cell
  end

  def draw
    children.each(&:draw)
    puts
  end

  def each_cell(&block)
    children.each(&block)
  end

  def each_set_of_neighbours(&block)
    [nil, *children, nil].each_cons(3).map(&:compact).map do |neighbours|
      NeighbourSet.new.tap do |ns|
        neighbours.each { |n| ns << n }
      end
    end.each(&block)
  end

  class NeighbourSet
    def initialize
      @neighbours = []
    end

    def <<(neighbour)
      neighbours << neighbour
    end

    def each_neighbour(&block)
      neighbours.each(&block)
    end

    private

    attr_accessor :neighbours
  end

  def add_neighbours(other_row)
    neighbour_sets = []
    other_row.each_set_of_neighbours { |neighbour_set| neighbour_sets << neighbour_set }
    each_cell do |cell|
      neighbour_sets.shift.each_neighbour { |n| cell.add_neighbour(n) }
    end
  end

  private

  attr_accessor :children
end
