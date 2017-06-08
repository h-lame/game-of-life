class Grid
  def initialize
    @rows = []
  end

  def <<(row)
    if rows.last
      row.add_neighbours(rows.last)
      rows.last.add_neighbours(row)
    end
    rows << row
  end

  def each_row(&blck)
    rows.each(&blck)
  end

  def draw
    rows.each(&:draw)
  end
  private
  attr_accessor :rows
end
