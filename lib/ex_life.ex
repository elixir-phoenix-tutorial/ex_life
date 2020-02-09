defmodule ExLife do
  @moduledoc """
  Documentation for ExLife.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ExLife.next([[0, 0, 0], [1, 1, 1], [0, 0, 0]])
      [[0, 1, 0], [0, 1, 0], [0, 1, 0]]

  """
  def next(world) do
    world
    |> Enum.with_index()
    |> Enum.map(fn {row, i} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {cell, j} ->
        alive?(world, i, j, cell)
      end)
    end)
  end

  defp alive?(world, i, j, cell) do
    case alive_neigbours_count(world, i, j) do
      2 when cell == 1 ->
        1

      3 ->
        1

      _ ->
        0
    end
  end

  defp alive_neigbours_count(world, i, j) do
    world
    |> neigbours(i, j)
    |> Enum.count(&(&1 == 1))
  end

  defp neigbours(world, i, j) do
    for k <- [i - 1, i, i + 1],
        l <- [j - 1, j, j + 1],
        row = Enum.at(world, k),
        k < length(world),
        l < length(row),
        k >= 0,
        l >= 0,
        k != i || l != j,
        do: Enum.at(row, l)
  end
end
