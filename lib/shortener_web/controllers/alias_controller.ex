defmodule ShortenerWeb.AliasController do
  use ShortenerWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html", changeset: Shortener.change_alias())
  end

  def create(conn, %{"alias" => attributes}) do
    case Shortener.insert_alias(attributes) do
      {:ok, url_alias} ->
        redirect(conn, to: Routes.alias_path(conn, :show, url_alias))

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => alias_id}) do
    case Shortener.get_alias(alias_id) do
      {:ok, url_alias} ->
        render(conn, "show.html", alias: url_alias)

      {:error, :not_found} ->
        conn
        |> put_status(:not_found)
        |> put_view(ShortenerWeb.ErrorView)
        |> render(:"404")
    end
  end
end
