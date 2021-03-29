defmodule BowlaramaElixir do
  @moduledoc """
  Bowling scores for Awesome bowlers.

  Take a scoresheet and output a nice table with results
  for a bowling match.
  """

  @doc """
  Output the match's scoresheet

  ## Examples

      iex(8)> BowlaramaElixir.score_sheet('./fixtures/scores.txt')
  """
  def score_sheet(file) do
    case File.read(file) do
      {:ok, binary} -> process(binary)
      {:error, _reason} -> "File does not exist"
    end
  end

  defp process(lines) do
    list_of_players = String.split(lines, "\n", trim: true)

    # Create a list of lists: [["Jeff", "10"], ["John", "3"], [], ...]
    players_with_scores = Enum.map(list_of_players, fn(score) -> String.split(score, " ") end)

    # Extract players names into a list: ["Jeff", "John"]
    players = extract_players(players_with_scores)

    Players.assign_scores_to(players, players_with_scores)
  end

  defp extract_players(nested_lists) do
    filtered = Enum.uniq(List.flatten(nested_lists))

    Enum.filter(filtered, fn(ele) -> extract(ele) end)
  end

  defp extract(item) do
    case player_from_string(item) do
      {:error, name} -> name
      {:ok, _integer} -> false
      _ -> false
    end
  end

  defp player_from_string(string) do
    try do
      {:ok, String.to_integer(string)}
    rescue
      _e in ArgumentError -> {:error, string}
    end
  end
end
