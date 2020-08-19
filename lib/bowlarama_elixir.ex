defmodule BowlaramaElixir do
  @moduledoc """
  Bowling scores for Awesome bowlers.

  Take a scoresheet and output a nice table with results
  for a bowling match.
  """

  @doc """
  Read scores from file.

  ## Examples

      iex(8)> BowlaramaElixir.read_score_from('./fixtures/scores.txt')
        ["Jeff 10", "John 3", "John 7", "Jeff 7", "Jeff 3", "John 6", "John 3",
         "Jeff 9", "Jeff 0", "John 10", "Jeff 10", "John 8", "John 1", "Jeff 0",
         "Jeff 8", "John 10", "Jeff 8", "Jeff 2", "John 10", "Jeff F", "Jeff 6",
         "John 9", "John 0", "Jeff 10", "John 7", "John 3", "Jeff 10", "John 4",
         "John 4", "Jeff 10", "Jeff 8", "Jeff 1", "John 10", "John 9", "John 0"]

  """
  def read_score_from(file) do
    case File.read(file) do
      {:ok, binary} -> convert_lines(binary)
      {:error, _reason} -> "File does not exist"
    end
  end

  defp convert_lines(lines) do
    lines |>
    String.split("\n", trim: true) |>
    players()
  end

  # Create a list of two tuples with the values corresponding to
  # the two players and their scores.
  #
  # Example
  #
  # [{:jeff, [10, 7, 8]}, {:john, [9, 8, 3]}]
  #
  # then create a Map with the names of the two players.
  defp players(scores) do
    Enum.map(scores, fn(score) -> String.split(score, " ") end) |>
    Players.players_from()
  end
end
