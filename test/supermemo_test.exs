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
    for_all x in int() do
      implies x > 2 do
        prior = Supermemo.set_interval(1, x - 1, x - 1, 2.5)
        interval = Supermemo.set_interval(1, x, prior, 2.5)
        expected = round(prior * 2.5)
        interval == expected
      end
    end
  end

  property :efactor_with_score do
    for_all x in such_that(xx in int(1, 100) when xx < 100) do
      q = x / 100
      base_ef = 2.5
      expected = base_ef + (0.1 - (5 - (q * 5)) * (0.08 + (5 - (q * 5)) * 0.02))
      adjusted = Supermemo.adjust_efactor(base_ef, q)
      adjusted == expected
    end
  end

  property :efactor_with_efactor do
    for_all x in such_that(xx in int(130, 250) when xx < 250) do
      ef = x / 100
      q = 1.0
      expected = ef + (0.1 - (5 - (q * 5)) * (0.08 + (5 - (q * 5)) * 0.02))
      adjusted = Supermemo.adjust_efactor(ef, q)
      adjusted == expected
    end
  end

  property :efactor_with_efactor_and_zero_dot_eight do
    for_all x in such_that(xx in int(130, 250) when xx < 250) do
      ef = x / 100
      q = 0.8
      expected = ef + (0.1 - (5 - (q * 5)) * (0.08 + (5 - (q * 5)) * 0.02))
      adjusted = Supermemo.adjust_efactor(ef, q)
      adjusted == expected
    end
  end

  property :efactor_with_efactor_and_zero_dot_four do
    for_all x in such_that(xx in int(130, 250) when xx < 250) do
      ef = x / 100
      q = 0.4
      expected = ef + (0.1 - (5 - (q * 5)) * (0.08 + (5 - (q * 5)) * 0.02))
      adjusted = Supermemo.adjust_efactor(ef, q)
      adjusted == expected
    end
  end
end
