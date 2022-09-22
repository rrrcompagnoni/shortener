defmodule ShortenerWeb.AliasView do
  use ShortenerWeb, :view

  def shortened_url(url_alias) do
    root_url = URI.to_string(ShortenerWeb.Endpoint.struct_url())

    "#{root_url}/#{url_alias.id}"
  end

  def uri_to_string(%URI{} = uri), do: URI.to_string(uri)
end
