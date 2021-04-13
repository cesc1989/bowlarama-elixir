defmodule ScoreCard do
  @moduledoc """
  Print the score card of the game.
  """

  @single_tab "\t"
  @doule_tab "\t\t"

  def print({p1, p2} = _players_and_scores) do
    IO.puts("Frame#{@doule_tab}" <> match_frames())

    Enum.each(p1, fn({p, v}) -> results(p, v) end)
    Enum.each(p2, fn({p, v}) -> results(p, v) end)
  end

  defp match_frames, do: Enum.join([1,2,3,4,5,6,7,8,9,10], @doule_tab)

  defp results(player, rolls) do
    IO.puts(player)
    IO.puts("Pinfalls#{@single_tab}" <> print_rolls(rolls))
    # Aquí es donde uso los _rolls_ puros y controlo la letra F
    # IO.puts("Score#{@doule_tab}" <> print_scores(rolls))
  end

  defp print_rolls(rolls) do
    #Enum.map(rolls, fn(roll) -> is_a_strike(String.to_integer(roll)) end) |>
    rolls |>
    Enum.join(@single_tab)
  end

  defp is_a_strike(roll) when roll == 10, do: "X"
  defp is_a_strike(roll), do: roll

  # defp print_scores(_rolls) do
  # end
end
