defmodule ScoreCard do
  @moduledoc """
  Print the score card of the game.
  """

  @single_tab "\t"
  @doule_tab "\t\t"

  def print({p1, p2} = _players_and_scores) do
    IO.puts("Frame#{@doule_tab}" <> frames())

    Enum.each(p1, fn({p, v}) -> results(p, v) end)

    Enum.each(p2, fn({p, v}) -> results(p, v) end)
  end

  defp frames, do: Enum.join([1,2,3,4,5,6,7,8,9,10], @doule_tab)

  defp results(player, rolls) do
    IO.puts(player)
    IO.puts("Pinfalls#{@doule_tab}" <> handle_scores(rolls))
    IO.puts("Score#{@doule_tab}")
  end

  defp handle_scores(rolls) do
    Enum.map(rolls, fn(roll) -> is_a_strike(String.to_integer(roll)) end) |>
    Enum.join(@single_tab)
  end

  defp is_a_strike(roll) do
    if roll == 10 do
      "X"
    else
      roll
    end
  end
end
