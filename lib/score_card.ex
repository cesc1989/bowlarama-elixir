defmodule ScoreCard do
  @moduledoc """
  Print the score card of the game.
  """

  @single_tab "\t"
  @double_tab "\t\t"

  def print({p1, p2} = _players_and_scores) do
    IO.puts("Frame#{@double_tab}" <> match_frames())

    Enum.each(p1, fn({player, scores}) -> results(player, scores) end)
    Enum.each(p2, fn({player, scores}) -> results(player, scores) end)
  end

  defp match_frames, do: Enum.join([1,2,3,4,5,6,7,8,9,10], @double_tab)

  defp results(player, rolls) do
    IO.puts(player)
    IO.puts("Pinfalls#{@single_tab}" <> print_rolls(rolls))
    # IO.puts("Score#{@double_tab}" <> print_scores(rolls))
  end

  defp print_rolls(rolls) do
    Enum.chunk_every(rolls, 2, 2, :discard) |>
    Enum.map(fn(frame_rolls) -> strike_or_spare(frame_rolls) end) |>
    Enum.join(@single_tab)
  end

  defp strike_or_spare([first | _last]) when first == "10", do: @single_tab <> "X"

  # No retorno @single_tab al final porque ya en print_rolls lo hago en la última línea
  defp strike_or_spare([first , last | _rest]) do
    result = String.to_integer(first) + String.to_integer(last)

    if result == 10 do
      "#{first}" <> @single_tab <> "/"
    else
      "#{first}#{@single_tab}#{last}"
    end
  end

  # Aquí es donde uso los _rolls_ puros y controlo la letra F
  defp print_scores(rolls) do
    Enum.chunk_every(rolls, 2, 2, :discard) |>
    Enum.join(@single_tab)
  end
end
