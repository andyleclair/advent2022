defmodule Advent2022.Day03 do
  @input (__DIR__ <> "/input.txt")
         |> File.read!()
         |> String.split("\n")
         |> Enum.reject(fn str -> str == "" end)

  @priorities Map.merge(
                Enum.zip(?a..?z, 1..26) |> Map.new(),
                Enum.zip(?A..?Z, 27..52) |> Map.new()
              )

  def run1() do
    @input
    |> Enum.map(&String.split_at(&1, div(String.length(&1), 2)))
    |> Enum.map(fn {ruck1, ruck2} ->
      MapSet.intersection(
        ruck1 |> String.graphemes() |> MapSet.new(),
        ruck2 |> String.graphemes() |> MapSet.new()
      )
      |> MapSet.to_list()
      |> List.first()
      |> String.to_charlist()
      |> List.first()
    end)
    |> Enum.map(fn common_item ->
      @priorities[common_item]
    end)
    |> Enum.sum()
  end

  def run2() do
    @input
    |> Enum.chunk_every(3)
    |> Enum.map(fn chunk ->
      chunk
      |> Enum.map(fn sack -> sack |> String.graphemes() |> MapSet.new() end)
      |> Enum.reduce(MapSet.new(), fn sack, acc ->
        if acc == MapSet.new() do
          sack
        else
          MapSet.intersection(sack, acc)
        end
      end)
      |> MapSet.to_list()
      |> List.first()
      |> String.to_charlist()
      |> List.first()
    end)
    |> Enum.map(fn i -> @priorities[i] end)
    |> Enum.sum()
  end
end
