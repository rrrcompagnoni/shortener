defmodule ShortenerWeb.AliasControllerTest do
  use ShortenerWeb.ConnCase

  alias Shortener

  describe "the root path" do
    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "form action=\"/aliases\" method=\"post\""
    end
  end

  describe "POST /aliases" do
    test "redirects to the created Alias", %{conn: conn} do
      alias_attributes = %{"url" => "https://foo.com"}

      conn = post(conn, Routes.alias_path(conn, :create), alias: alias_attributes)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.alias_path(conn, :show, id)
    end

    test "re-render the form and set the status to 422 when something went wrong with the Alias creation",
         %{conn: conn} do
      conn = post(conn, Routes.alias_path(conn, :create), alias: %{})

      assert html_response(conn, 422) =~ "form action=\"/aliases\" method=\"post\""
    end
  end

  describe "GET /aliases/:id" do
    test "renders a found Alias", %{conn: conn} do
      {:ok, url_alias} = Shortener.insert_alias(%{"url" => "http://foo.com"})

      conn = get(conn, Routes.alias_path(conn, :show, url_alias.id))

      assert html_response(conn, 200) =~ ShortenerWeb.AliasView.shortened_url(url_alias)
    end

    test "renders not found for a missing Alias", %{conn: conn} do
      conn = get(conn, Routes.alias_path(conn, :show, "foo!"))

      assert html_response(conn, 404) =~ "Not Found"
    end
  end
end
