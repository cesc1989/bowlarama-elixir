defmodule ScoreTest do
  use ExUnit.Case
  doctest Score

  test "raises exception when rolls are lesser than 0" do
    assert_raise InvalidRollError, fn ->
      Score.convert_to_numbers(["-10", "2", "3", "5"])
    end
  end

  test "raises exception when rolls are greater than 10" do
    assert_raise InvalidRollError, fn ->
      Score.convert_to_numbers(["11", "2", "3", "5"])
    end
  end

  test "returns 0 instead of F" do
    [0 | _] = Score.convert_to_numbers(["F", "2", "3", "5"])
  end
end
