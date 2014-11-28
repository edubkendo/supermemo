defmodule SupermemoTest do
  use ExUnit.Case
  use ExCheck

  test "first iteration" do
    assert Supermemo.set_interval(1, 0, 1, 2.5) == 1 
  end

  test "second iteration" do
    assert Supermemo.set_interval(1, 1, 1, 2.5) == 6
  end

  property :interval do
    for_all x in int do
      implies x > 2 do
        prior = Supermemo.set_interval(1, x - 1, x - 1, 2.5)
        interval = Supermemo.set_interval(1, x, prior, 2.5)
        result = round(prior * 2.5)
        interval == result
      end
    end
  end
end
