defmodule Advent2022.Day06 do
  @input (__DIR__ <> "/input.txt")
         |> File.read!()
         |> String.trim()
         |> String.graphemes()

  def run1() do
    @input
    |> Enum.with_index()
    |> Enum.reduce_while(:queue.new(), fn {char, i}, acc ->
      if :queue.len(acc) < 4 do
        {:cont, :queue.in(char, acc)}
      else
        as_list = :queue.to_list(acc)

        if Enum.uniq(as_list) == as_list do
          {:halt, i}
        else
          {_, q} = :queue.out(acc)
          {:cont, :queue.in(char, q)}
        end
      end
    end)
  end

  def run2() do
    @input
    |> Enum.with_index()
    |> Enum.reduce_while(:queue.new(), fn {char, i}, acc ->
      if :queue.len(acc) < 14 do
        {:cont, :queue.in(char, acc)}
      else
        as_list = :queue.to_list(acc)

        if Enum.uniq(as_list) == as_list do
          {:halt, i}
        else
          {_, q} = :queue.out(acc)
          {:cont, :queue.in(char, q)}
        end
      end
    end)
  end
end
