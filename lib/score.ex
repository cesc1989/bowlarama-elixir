defmodule Score do
  @moduledoc """
  Handle scores calculations, including strikes and spares.
  """

  def convert_to_numbers(rolls) do
    Enum.map(rolls, fn(roll) -> String.to_integer(roll) end)
  end

  # Recibe:
  #    [[10,0], [7,3], [9,0], [10,0], [0,8], [8,2], [0,6], [10,0], [10,0], [0,10,8]]
  #
  # Y Retorna:
  #    [20, 30, 39, 57, 65, 75, 81, 101, 121, 139]
  def calculate(rolls) do
    calculate(rolls, [])
  end

  defp calculate([[fst, sec | _], [n1, n2 | _] | rest], []) when fst == 10 do
    calculate([[n1, n2] | rest], [fst + sec + n1 + n2])
  end

  defp calculate([[fst, sec | _] | rest], []) do
    calculate(rest, [fst + sec])
  end

  defp calculate([[fst, sec | _], [n1, n2 | _] | rest], [ff | tail]) when fst == 10 do
    next_score = ff + fst + sec + n1 + n2

    calculate([[n1, n2] | rest], [next_score, ff | tail])
  end

  defp calculate([[fst, sec | _] | rest], [ff | r]) do
    next_score = ff + fst + sec

    calculate(rest, [next_score, ff | r])
  end

  defp calculate([], result) do
    Enum.reverse(result)
  end
end
