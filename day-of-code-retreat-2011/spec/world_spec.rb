require 'test/unit'
require './lib/world'

class WorldTest < Test::Unit::TestCase
  def test_should_evolve_correctly
    @world = World.new([%w(. x .),
                        %w(x . x),
                        %w(. . .)])

    @world.evolve
  end

  def test_should_create_life
    @world = World.new([%w(. x .),
                        %w(x . x),
                        %w(. . .)])
    @world.evolve
    assert_equal 'x', @world[1,1]
  end

  def test_should_destroy_life
    @world = World.new([%w(. x .),
                        %w(x x x),
                        %w(x x .)])
    @world.evolve
    assert_equal '.', @world[1,1]
  end

  def test_should_maintain_life
    @world = World.new([%w(. x .),
                        %w(. x .),
                        %w(. x .)])
    @world.evolve
    assert_equal 'x', @world[1,1]
  end

  def test_should_count_neighbours
    @world = World.new([%w(. x .),
                        %w(. x .),
                        %w(. x .)])
    expected_result = [[2,1,2],
                       [3,2,3],
                       [2,1,2]]
    assert_equal expected_result, (0..2).map {|y| (0..2).map {|x| @world.count_neighbours(x,y) } }
  end

  def test_should_cope_with_grid_boundaries_outside_world
    @world = World.new([%w(. x .),
                        %w(. x .),
                        %w(. x .)])

    assert_nil @world[-1,-1]
    assert_nil @world[3,3]
    assert_equal 'x', @world[1,1]
  end
end

