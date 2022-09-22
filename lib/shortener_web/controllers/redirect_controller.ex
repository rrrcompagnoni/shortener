defmodule ShortenerWeb.RedirectController do
  use ShortenerWeb, :controller

  def show(conn, %{"alias_id" => alias_id}) do
    case Shortener.get_alias(alias_id) do
      {:ok, url_alias} ->
        redirect(conn, external: URI.to_string(url_alias.url))

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> put_view(ShortenerWeb.ErrorView)
        |> render(:"404")
    end
  end
end
