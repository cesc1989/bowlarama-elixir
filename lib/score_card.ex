defmodule ScoreCard do
  @moduledoc """
  Print the score card of the game.
  """

  @single_tab "\t"
  @doule_tab "\t\t"

  def print({p1, p2} = _players_and_scores) do
    IO.puts("Frame#{@doule_tab}" <> match_frames())

    Enum.each(p1, fn({player, scores}) -> results(player, scores) end)
    Enum.each(p2, fn({player, scores}) -> results(player, scores) end)
  end

  defp match_frames, do: Enum.join([1,2,3,4,5,6,7,8,9,10], @doule_tab)

  defp results(player, rolls) do
    IO.puts(player)
    IO.puts("Pinfalls#{@single_tab}" <> print_rolls(rolls))
    # Aquí es donde uso los _rolls_ puros y controlo la letra F
    # IO.puts("Score#{@doule_tab}" <> print_scores(rolls))
  end

  defp print_rolls(rolls) do
    rolls |>
    Enum.chunk_every(2, 2, :discard) |>
    Enum.map(fn(frame_rolls) -> mark_strikes(frame_rolls) end) |>
    Enum.join(@single_tab)
  end

  defp mark_strikes([first | _last]) when first == "10" do
    Enum.join(["X", ""], @single_tab)
  end
  defp mark_strikes(frame_rolls) do
    Enum.join(frame_rolls, @single_tab)
  end

  # defp print_scores(rolls) do
  # end
end
