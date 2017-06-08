require './cell_behaviour'

class LiveCell
  include CellBehaviour

  def draw
    print 'X'
  end

  def step
    case neighbours.count { |x| x.is_a? LiveCell }
    when 2,3
      live
    else
      die
    end
  end
end
