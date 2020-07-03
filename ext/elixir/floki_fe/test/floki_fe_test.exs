defmodule FlokiFeTest do
  use ExUnit.Case
  doctest FlokiFe

  test "greets the world" do
    assert FlokiFe.hello() == :world
  end
end
