defmodule Shortener.AliasInventoryTest do
  use ExUnit.Case, async: true

  alias Shortener.AliasIDInventory

  describe "pick/0" do
    test "always pick 10 digits long IDs" do
      Enum.each(1..20, fn _ ->
        assert String.length(AliasIDInventory.pick()) == 10
      end)
    end

    test "pick IDs composed by letters and numbers" do
      Enum.each(1..20, fn _ ->
        refute String.match?(AliasIDInventory.pick(), ~r/\W/)
      end)
    end
  end
end
