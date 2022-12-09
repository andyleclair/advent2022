defmodule Advent2022.Day05 do
  @input (__DIR__ <> "/input.txt")
         |> File.read!()

  def run1() do
    {crates, moves} = initial_state()

    final_crates =
      Enum.reduce(moves, crates, fn %{move: move, from: from, to: to}, crates ->
        Enum.reduce(1..move, crates, fn _i, crates ->
          from_queue = :array.get(from, crates)
          to_queue = :array.get(to, crates)
          {{:value, val}, from_queue} = :queue.out(from_queue)
          to_queue = :queue.in_r(val, to_queue)

          crates = :array.set(from, from_queue, crates)
          :array.set(to, to_queue, crates)
        end)
      end)

    Enum.map(1..9, fn col ->
      queue = :array.get(col, final_crates)
      {{:value, val}, _} = :queue.out(queue)
      val
    end)
  end

  def run2() do
    {crates, moves} = initial_state()

    final_crates =
      Enum.reduce(moves, crates, fn %{move: move, from: from, to: to}, crates ->
        from_queue = :array.get(from, crates)
        to_queue = :array.get(to, crates)

        {items, from_queue} =
          Enum.reduce(1..move, {[], from_queue}, fn _i, {items, queue} ->
            {{:value, val}, queue} = :queue.out(queue)
            {[val | items], queue}
          end)

        to_queue =
          Enum.reduce(items, to_queue, fn item, queue ->
            :queue.in_r(item, queue)
          end)

        crates = :array.set(from, from_queue, crates)
        :array.set(to, to_queue, crates)
      end)

    Enum.map(1..9, fn col ->
      queue = :array.get(col, final_crates)
      {{:value, val}, _} = :queue.out(queue)
      val
    end)
  end

  def initial_state() do
    [initial_crates, movelist] = @input |> String.split("\n\n", parts: 2)

    crates = parse_crates(initial_crates)
    moves = parse_moves(movelist)

    {crates, moves}
  end

  def parse_crates(crates) do
    crate_matrix =
      crates
      |> String.split("\n")
      |> Enum.map(fn line -> line |> String.graphemes() |> Enum.chunk_every(4) end)
      |> Enum.map(fn chunk -> chunk |> Enum.map(fn sublist -> Enum.at(sublist, 1) end) end)
      |> Enum.reverse()
      |> List.delete_at(0)

    Enum.reduce(0..8, :array.new(), fn i, array ->
      col =
        Enum.reduce(crate_matrix, :queue.new(), fn row, acc ->
          item = Enum.at(row, i)

          if item != " " do
            :queue.in_r(item, acc)
          else
            acc
          end
        end)

      :array.set(i + 1, col, array)
    end)
  end

  def parse_moves(movelist) do
    movelist
    |> String.split("\n")
    |> Enum.reject(fn str -> str == "" end)
    |> Enum.map(fn line ->
      Regex.named_captures(~r/move (?<move>\d+) from (?<from>\d) to (?<to>\d)/, line)
      |> Enum.map(fn {k, v} -> {String.to_atom(k), String.to_integer(v)} end)
      |> Map.new()
    end)
  end
end
