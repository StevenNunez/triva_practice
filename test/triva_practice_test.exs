defmodule TrivaPracticeTest do
  use ExUnit.Case
  doctest TrivaPractice

  test "greets the world" do
    assert TrivaPractice.hello() == :world
  end
end
