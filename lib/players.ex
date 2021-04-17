defmodule Players do
  @moduledoc """
  Extract players and their scores from unorganized data.
  """

  @doc """
  Merge a list of players and scores into a two maps tuple
  where the player's name is the key and their scores the value.

  Players list looks like:

      ["Jeff", "John"]

  Scores list looks like:
      [["Jeff", "10"], ["John", "3"], [], ...]
  """
  def assign_scores_to(players, scores) do
    player_1 = List.first(players)
    player_2 = List.last(players)

    {
      %{player_1 => assign(player_1, scores)},
      %{player_2 => assign(player_2, scores)}
    }
  end

  defp assign(player, scores) do
    scores
    |> Enum.reduce([], fn pair, acc -> [filter_scores(player, pair) | acc] end)
    |> Frame.frames()
    |> organize_scores()
  end

  defp filter_scores(player, [name | _rest]) when name != player, do: nil

  # Enum.reduce() va a devolverlos en orden invertido
  defp filter_scores(_, [_, score | _]), do: score

  defp organize_scores(scores) do
    scores
    |> Enum.reverse()
    |> Enum.reject(&is_nil/1)
  end
end
