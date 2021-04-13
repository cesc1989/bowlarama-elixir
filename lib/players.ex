defmodule Players do
  @moduledoc """
  Structure to hold players and their scores.
  """

  # players: ["Jeff", "John"]
  # scores: [["Jeff", "10"], ["John", "3"], [], ...]
  def assign_scores_to(players, scores) do
    player_1 = List.first(players)
    player_2 = List.last(players)

    {
      %{ player_1 => assign(player_1, scores) },
      %{ player_2 => assign(player_2, scores) }
    }
  end

  defp assign(player, scores) do
    Enum.reduce(scores, [], fn(pair, acc) ->
      [filter_scores(player, pair) | acc]
    end) |>
    Frame.frames() |>
    organize_scores()
  end

  defp filter_scores(player, [name | _rest]) when name != player, do: nil

  # Enum.reduce() los devuelve en orden invertido
  defp filter_scores(player, [name, score | _]) when name == player, do: score

  defp organize_scores(scores) do
    Enum.reverse(scores) |>
    Enum.reject(fn(ele) -> is_nil(ele) end)
  end
end
