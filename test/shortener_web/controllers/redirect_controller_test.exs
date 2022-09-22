defmodule ShortenerWeb.RedirectControllerTest do
  use ShortenerWeb.ConnCase

  describe "GET /:alias_id" do
    test "redirects to the aliased URL", %{conn: conn} do
      {:ok, url_alias} = Shortener.insert_alias(%{"url" => "http://redirect.com"})

      conn = get(conn, Routes.redirect_path(conn, :show, url_alias.id))

      assert html_response(conn, 302)
      assert Plug.Conn.get_resp_header(conn, "location") == ["http://redirect.com"]
    end

    test "renders not found for a missing Alias", %{conn: conn} do
      conn = get(conn, Routes.redirect_path(conn, :show, "foo!"))

      assert html_response(conn, 404) =~ "Not Found"
    end
  end
end
