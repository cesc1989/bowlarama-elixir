defmodule BowlaramaTest do
  use ExUnit.Case
  doctest Bowlarama

  test "results score card with existing file" do
    assert Bowlarama.score_sheet("fixtures/scores.txt") == :ok
  end

  test "returns error when missing scores file" do
    assert Bowlarama.score_sheet("noexisto.txt") == "File does not exist"
  end
end
