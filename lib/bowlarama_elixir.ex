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
    players_map = extract_players(players_with_scores)

    Players.assign_scores_to(players_map, players_with_scores)
  end

  # Return a Map of the players: %{Jeff: [], John: []}
  defp extract_players(nested_lists) do
    Enum.reduce(nested_lists, %{}, fn(sublist, accumulator) ->
      if length(Map.keys(accumulator)) == 2 do
        accumulator
      else
        player = List.first(sublist)

        unless Map.has_key?(accumulator, String.to_atom(player)) do
          Map.put(accumulator, String.to_atom(player), [])
        end
      end
    end)
  end
end
