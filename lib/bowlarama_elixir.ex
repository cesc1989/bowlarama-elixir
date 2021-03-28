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
    players_with_scores = String.split(lines, "\n", trim: true)
    players_map = extract_players(players_with_scores)
  end

  # Return a Map of the players: %{Jeff: [], John: []}
  defp extract_players(scores) do
    # First (Enum.map), create a list of lists
    #
    #  [["Jeff", "10"], ["John", "3"], [], ...]
    #
    # Second (players_from()), extract the players names into a two items Map
    #
    # %{Jeff: [], John: []}
    Enum.map(scores, fn(score) -> String.split(score, " ") end) |>
    players_from()
  end

  defp players_from(nested_lists) do
    Enum.reduce(nested_lists, %{}, fn(sublist, acc) ->
      if length(Map.keys(acc)) == 2 do
        acc
      else
        player = List.first(sublist)

        unless Map.has_key?(acc, String.to_atom(player)) do
          Map.put(acc, String.to_atom(player), [])
        end
      end
    end)
  end
end
