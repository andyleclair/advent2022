defmodule Advent2022.Day01 do
  @input_path __DIR__ <> "/input.txt"

  def run1() do
    @input_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.chunk_while(
      [],
      fn element, acc ->
        case element do
          "" ->
            {:cont, Enum.reverse(acc), []}

          str_num ->
            num = String.to_integer(str_num)
            {:cont, [num | acc]}
        end
      end,
      fn acc ->
        {:cont, Enum.reverse(acc), []}
      end
    )
    |> Enum.map(fn chunk ->
      Enum.sum(chunk)
    end)
    |> Enum.sort()
    |> List.last()
  end

  def run2() do
    @input_path
    |> File.read!()
    |> String.split("\n")
    |> Enum.chunk_while(
      [],
      fn element, acc ->
        case element do
          "" ->
            {:cont, Enum.reverse(acc), []}

          str_num ->
            num = String.to_integer(str_num)
            {:cont, [num | acc]}
        end
      end,
      fn acc ->
        {:cont, Enum.reverse(acc), []}
      end
    )
    |> Enum.map(fn chunk ->
      Enum.sum(chunk)
    end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end
end
