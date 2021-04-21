defmodule Score do
  @moduledoc """
  Handle scores calculations, including strikes and spares.
  """

  @doc """
  Convert and validate conversion of string rolls into number rolls to do proper aritmethic.

  ## Examples

      iex> Score.convert_to_numbers(["10", "2", "3", "5"])
      [10, 2, 3, 5]
  """
  def convert_to_numbers(rolls) do
    Enum.map(rolls, fn(roll) -> validate(roll) end)
  end

  @doc """
  Calcualtes scores for a player's pinfalls.

  It considers strikes and spares rules.

  ## Examples

  For a list of scores:

      iex> Score.calculate([[10,0], [7,3], [9,0], [10,0], [0,8], [8,2], [0,6], [10,0], [10,0], [0,10,8]])
      [20, 39, 48, 66, 74, 84, 90, 110, 130, 140]
  """
  def calculate(rolls) do
    calculate(rolls, [])
  end

  defp validate("F"), do: 0

  defp validate(roll) do
    r = String.to_integer(roll)

    case r in 0..10 do
      true -> r
      false -> raise(InvalidRollError, message: "Invalid roll #{r}")
    end
  end

  # For Strikes and empty result list
  defp calculate([[fst, sec | _], [n1, n2 | _] | rest], []) when fst == 10 do
    calculate([[n1, n2] | rest], [fst + sec + n1 + n2])
  end

  # For Spares and empty result list
  defp calculate([[fst, sec | _], [n1 | frame] | rest], []) when fst + sec == 10 do
    calculate([[n1 | frame] | rest], [fst + sec + n1])
  end

  defp calculate([[fst, sec | _] | rest], []) do
    calculate(rest, [fst + sec])
  end

  # For Strikes
  defp calculate([[fst, sec | _], [n1, n2 | _] | rest], [ff | tail]) when fst == 10 do
    next_score = ff + fst + sec + n1 + n2

    calculate([[n1, n2] | rest], [next_score, ff | tail])
  end

  # For Spares
  defp calculate([[fst, sec | _], [n1 | frame] | rest], [ff | tail]) when fst + sec == 10 do
    next_score = ff + fst + sec + n1

    calculate([[n1 | frame] | rest], [next_score, ff | tail])
  end

  defp calculate([[fst, sec | _] | rest], [ff | r]) do
    next_score = ff + fst + sec

    calculate(rest, [next_score, ff | r])
  end

  defp calculate([], result) do
    Enum.reverse(result)
  end
end
