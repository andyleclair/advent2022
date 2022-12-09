defmodule Advent2022.Day04 do
  @input (__DIR__ <> "/input.txt")
         |> File.read!()
         |> String.split("\n")
         |> Enum.reject(fn str -> str == "" end)
         |> Enum.map(&String.split(&1, ","))

  def run1() do
    @input
    |> Enum.map(fn [range1, range2] ->
      {str_to_range(range1), str_to_range(range2)}
    end)
    |> Enum.map(fn {range1, range2} ->
      {MapSet.new(range1), MapSet.new(range2)}
    end)
    |> Enum.map(fn {set1, set2} ->
      MapSet.subset?(set1, set2) or MapSet.subset?(set2, set1)
    end)
    |> Enum.filter(fn subset? -> subset? end)
    |> length()
  end

  def run2() do
    @input
    |> Enum.map(fn [range1, range2] ->
      {str_to_range(range1), str_to_range(range2)}
    end)
    |> Enum.map(fn {range1, range2} ->
      {MapSet.new(range1), MapSet.new(range2)}
    end)
    |> Enum.map(fn {set1, set2} ->
      !MapSet.disjoint?(set1, set2)
    end)
    |> Enum.filter(fn subset? -> subset? end)
    |> length()
  end

  def str_to_range(str) do
    [start, ending] = str |> String.split("-", parts: 2) |> Enum.map(&String.to_integer/1)
    Range.new(start, ending)
  end
end
