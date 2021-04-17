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
    with {:ok, binary} <- File.read(file) do
      players_with_scores =
        binary
        |> String.split("\n", trim: true)
        # Create a list of lists: [["Jeff", "10"], ["John", "3"], [], ...]
        |> Enum.map(&String.split(&1, " "))

      players_with_scores
      # Extract players names into a list: ["Jeff", "John"]
      |> extract_players()
      |> IO.inspect()
      |> Players.assign_scores_to(players_with_scores)
      |> ScoreCard.print()
    else
      {:error, _reason} -> "File does not exist"
    end
  end

  defp extract_players(nested_lists) do
    nested_lists
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.filter(&player_from_string/1)
  end

  # Receives a list like this:
  # ["Jeff", "10", "John", "8", "F"]
  #
  # If the string can be converted to integer, it isn't a name.
  # Too hacky for me. Works good enough, though.
  defp player_from_string("F"), do: false

  defp player_from_string(string) do
    case Integer.parse(string) do
      :error -> true
      _ -> false
    end
  end
end
