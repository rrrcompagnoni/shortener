defmodule Shortener.AliasIDInventory do
  @spec pick() :: String.t()
  def pick() do
    :crypto.strong_rand_bytes(30)
    |> Base.url_encode64()
    |> String.replace(~r/\W/, "")
    |> String.slice(0..9)
  end
end
