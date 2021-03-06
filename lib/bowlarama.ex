defmodule Bowlarama do
  @moduledoc """
  Bowling scores for Awesome bowlers.

  Take a scoresheet file and output a results table for a bowling match.
  """

  @doc """
  Output the match's scoresheet

  ## Examples

      iex(8)> Bowlarama.score_sheet('./fixtures/scores.txt')
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

    Players.assign_scores_to(players, players_with_scores) |>
    ScoreCard.print()
  end

  defp extract_players(nested_lists) do
    nested_lists
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.filter(fn(ele) -> extract(ele) end)
  end

  defp extract(item) do
    case player_from_string(item) do
      {:error, name} -> name
      {:ok, _integer} -> false
      _ -> false
    end
  end

  # Receives a list like this:
  # ["Jeff", "10", "John", "8", "F"]
  #
  # If the string can be converted to integer, it isn't a name.
  # Too hacky for me. Works good enough, though.
  defp player_from_string("F"), do: {:ok, 0}

  defp player_from_string(string) do
    try do
      {:ok, String.to_integer(string)}
    rescue
      _e in ArgumentError -> {:error, string}
    end
  end
end
