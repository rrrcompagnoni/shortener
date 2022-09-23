defmodule ShortenerTest do
  use Shortener.DataCase

  alias Shortener
  alias Shortener.Alias

  describe "change_alias" do
    test "returns an Alias changeset" do
      assert %Ecto.Changeset{data: %Alias{}} = Shortener.change_alias()
    end
  end

  describe "insert_alias/2" do
    test "creates an Alias" do
      alias_id = Shortener.pick_alias_id()

      {:ok, url_alias} = Shortener.insert_alias(%{"url" => "https://foo.com"}, fn -> alias_id end)

      assert URI.to_string(url_alias.url) == "https://foo.com"
      assert url_alias.id == alias_id
    end

    test "when the ID option is given it overrides the ID auto generation" do
      {:ok, url_alias} =
        Shortener.insert_alias(%{"url" => "https://foo.com"}, fn -> "picked-id" end,
          id: "overrided-id"
        )

      assert url_alias.id == "overrided-id"
    end

    test "URL attribute must be present" do
      assert {:error, %Ecto.Changeset{errors: errors}} = Shortener.insert_alias(%{})
      assert errors == [url: {"can't be blank", [{:validation, :required}]}]

      assert {:error, %Ecto.Changeset{errors: errors}} = Shortener.insert_alias(%{"url" => nil})
      assert errors == [url: {"can't be blank", [{:validation, :required}]}]
    end

    test "invalid URLs are not accepted" do
      invalid_url = "foo.com"

      assert {:error, %Ecto.Changeset{errors: errors}} =
               Shortener.insert_alias(%{"url" => invalid_url})

      assert errors == [url: {"The URL given is not valid.", []}]

      valid_url = "http://foo.com"

      {:ok, _} = Shortener.insert_alias(%{"url" => valid_url})

      valid_url = "https://foo.com"

      {:ok, _} = Shortener.insert_alias(%{"url" => valid_url})
    end
  end

  describe "get_alias/1" do
    test "returns an Alias when it exists" do
      {:ok, url_alias} = Shortener.insert_alias(%{"url" => "https://foo.com"})

      {:ok, found_alias} = Shortener.get_alias(url_alias.id)

      assert found_alias == url_alias
    end

    test "returns not found" do
      {:error, :not_found} = Shortener.get_alias("foo!")
    end
  end
end
