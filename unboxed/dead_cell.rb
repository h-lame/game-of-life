require './cell_behaviour'

class DeadCell
  include CellBehaviour

  def draw
    print '.'
  end

  def step
    case neighbours.count { |x| x.is_a? LiveCell }
    when 3
      live
    else
      die
    end
  end
end
