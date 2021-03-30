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
    Enum.reduce(scores, [], fn(pair, acc) -> [filter_scores(player, pair) | acc] end) |>
    organize_scores()
  end

  defp filter_scores(player, score_pair) do
    # Estan al reves y retornando nulos
    if List.first(score_pair) == player do
      List.last(score_pair)
    end
  end

  defp organize_scores(scores) do
    Enum.reverse(scores) |>
    Enum.reject(fn(ele) -> is_nil(ele) end)
  end
end
