defmodule Frame do
  @moduledoc """
  Create frames and assign pairs of pinfalls.
  """

  # ["10","7","3","9","0","10","0","8","8","2","0","6","10","10","10","8"]
  # resultado final
  # [[0,10], [7,3], [9,0], [0,10], [0,8], [8,2], [0,6], [0,10], [0,10], [0,10,8]]
  def frames(pinfalls) do
    pair_up(pinfalls)
  end

  defp pair_up(scores) do
    pair_up(scores, [])
  end

  defp pair_up([first | rest], new_list) when first == "10" do
    pair_up(rest, [first, "0" | new_list])
  end

  defp pair_up([first | rest], new_list) do
    pair_up(rest, [first | new_list])
  end

  defp pair_up([], new_list) do
    Enum.reverse(new_list)
  end
end
