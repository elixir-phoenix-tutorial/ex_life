defmodule ExLifeTest do
  use ExUnit.Case
  use ExUnitProperties
  doctest ExLife

  property "next is not crashed" do
    check all(
            len <- integer(1..100),
            gen <- list_of(list_of(integer(0..1), length: len))
          ) do
      next_gen = ExLife.next(gen)
      assert length(next_gen) == length(gen)

      assert Enum.all?(next_gen, fn row ->
               Enum.all?(row, fn cell ->
                 cell in [0, 1]
               end)
             end)
    end
  end
end
