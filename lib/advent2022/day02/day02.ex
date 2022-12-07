defmodule Advent2022.Day02 do
  @input (__DIR__ <> "/input.txt")
         |> File.read!()
         |> String.split("\n")
         |> Enum.map(&String.split(&1, " "))

  def run1() do
    @input
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  def run2() do
    @input
    |> Enum.map(&score2/1)
    |> Enum.sum()
  end

  @shape_mapping %{"X" => :rock, "Y" => :paper, "Z" => :scissors}
  @shape_score %{rock: 1, paper: 2, scissors: 3}
  @score_table %{win: 6, lose: 0, draw: 3}
  @outcome_mapping %{"X" => :lose, "Y" => :draw, "Z" => :win}

  def score([_opp, me] = input) do
    outcome(input) + @shape_score[@shape_mapping[me]]
  end

  def score(_), do: 0

  def score2([_opp, outcome] = input) do
    @shape_score[outcome_to_play(input)] + @score_table[@outcome_mapping[outcome]]
  end

  def score2(_), do: 0

  def outcome(["A", "X"]), do: @score_table[:draw]
  def outcome(["A", "Y"]), do: @score_table[:win]
  def outcome(["A", "Z"]), do: @score_table[:lose]

  def outcome(["B", "X"]), do: @score_table[:lose]
  def outcome(["B", "Y"]), do: @score_table[:draw]
  def outcome(["B", "Z"]), do: @score_table[:win]

  def outcome(["C", "X"]), do: @score_table[:win]
  def outcome(["C", "Y"]), do: @score_table[:lose]
  def outcome(["C", "Z"]), do: @score_table[:draw]

  def outcome_to_play(["A", "X"]), do: :scissors
  def outcome_to_play(["A", "Y"]), do: :rock
  def outcome_to_play(["A", "Z"]), do: :paper

  def outcome_to_play(["B", "X"]), do: :rock
  def outcome_to_play(["B", "Y"]), do: :paper
  def outcome_to_play(["B", "Z"]), do: :scissors

  def outcome_to_play(["C", "X"]), do: :paper
  def outcome_to_play(["C", "Y"]), do: :scissors
  def outcome_to_play(["C", "Z"]), do: :rock
end
