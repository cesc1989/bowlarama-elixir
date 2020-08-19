defmodule Players do
  @moduledoc """
  Map structure to hold players and their scores.
  """

  @doc """
  Return a Map of the match players.

  ## Example

      iex(8)> BowlaramaElixir.read_score_from('./fixtures/scores.txt')
        %{Jeff: [], John: []}
  """
  def players_from(list_of_lists) do
    Enum.reduce(list_of_lists, %{}, fn(sublist, acc) ->
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
