defmodule BowlaramaTest do
  use ExUnit.Case
  doctest Bowlarama

  @tag :pending
  test "greets the world" do
    assert Bowlarama.hello() == :world
  end
end
