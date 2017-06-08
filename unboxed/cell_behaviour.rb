module CellBehaviour
  def initialize
    @neighbours = []
  end

  def live
    LiveCell.new
  end

  def die
    DeadCell.new
  end

  def add_neighbour(neighbour)
    neighbours << neighbour unless neighbour.nil?
  end

  def each_neighbour(&block)
    neighbours.each(&block)
  end

  private

  attr_accessor :neighbours
end
