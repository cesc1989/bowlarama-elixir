defmodule ScoreCard do
  @moduledoc """
  Print the score card of the game.
  """

  @single_tab "\t"
  @double_tab "\t\t"

  def print({p1, p2} = _players_and_scores) do
    IO.puts("Frame#{@double_tab}" <> Enum.join(1..10, @double_tab))

    Enum.each(p1, fn {player, scores} -> results(player, scores) end)
    Enum.each(p2, fn {player, scores} -> results(player, scores) end)
  end

  defp results(player, rolls) do
    IO.puts(player)
    IO.puts("Pinfalls#{@single_tab}" <> print_rolls(rolls))
    IO.puts("Score#{@double_tab}" <> print_scores(rolls))
  end

  defp print_rolls(rolls) do
    rolls
    |> Enum.chunk_every(2, 2, :discard)
    |> Enum.map(&strike_or_spare/1)
    |> Enum.join(@single_tab)
  end

  defp strike_or_spare(["10" | _last]), do: @single_tab <> "X"
  defp strike_or_spare(["F", last | _rest]), do: "F#{@single_tab}#{last}"
  defp strike_or_spare([first, "F" | _rest]), do: "#{first}#{@single_tab}F"

  # No retorno @single_tab al final porque ya en print_rolls lo hago en la última línea
  defp strike_or_spare([first, last | _rest]) do
    result = String.to_integer(first) + String.to_integer(last)

    last = if result == 10, do: "/", else: last
    "#{first}#{@single_tab}#{last}"
  end

  defp print_scores(rolls) do
    # Aquí uso los _rolls_ puros y controlo letra F
    rolls
    |> Score.convert_to_numbers()
    |> Enum.chunk_every(2, 2, :discard)
    |> Score.calculate()
    |> Enum.join(@double_tab)
  end
end
