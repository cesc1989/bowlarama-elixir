defmodule Frame do
  @moduledoc """
  Create frames and assign pairs of pinfalls.

  This is a way to facilatate next steps when printing and calculating scores.
  """

  @doc """
  Convert a list of individual scores into a pair of well organized pinfalls per
  frame.

  Considers pairing for strikes by placing a number 0 besides the 10
  to simplify score calculation in Score module.
  Example made that way will work as doctest.
    ## Examples

      iex> frames(["10","7","3","9","0","10","0","8","8","2","0","6","10","10","10","8"])
      [["10","0"], ["7","3"], ["9","0"], ["10","0"], ["0","8"], ["8","2"], ["0","6"], ["10","0"], ["10","0"], ["0","10","8"]]
  """
  def frames(pinfalls), do: pair_up(pinfalls, [])

  defp pair_up(["10" | rest], new_list), do: pair_up(rest, ["10", "0" | new_list])
  defp pair_up([first | rest], new_list), do: pair_up(rest, [first | new_list])
  defp pair_up([], new_list), do: new_list |> Enum.reverse()
end
