defmodule Players do
  @moduledoc """
  Map structure to hold players and their scores.
  """

  def assign_scores_to(players, raw_scores) do
    IO.inspect(players) # %{Jeff: [], John: []}
    # ["Jeff 10", "John 3", "John 7", ...]
    raw_scores
  end
end
