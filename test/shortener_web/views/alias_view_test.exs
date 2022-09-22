defmodule ShortenerWeb.AliasViewTest do
  use ShortenerWeb.ConnCase, async: true

  alias Shortener.Alias
  alias ShortenerWeb.AliasView

  describe "shortened_url/1" do
    test "builds the Alias URL" do
      url_alias = %Alias{id: "120398"}

      assert AliasView.shortened_url(url_alias) == "http://localhost:4002/120398"
    end
  end

  describe "uri_to_string/1" do
    test "converts the complex URL Alias attribute into a String" do
      url_alias = %Alias{url: URI.new!("http://foo.com")}

      assert AliasView.uri_to_string(url_alias.url) == "http://foo.com"
    end
  end
end
