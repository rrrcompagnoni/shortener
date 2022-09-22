defmodule Shortener.Alias do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  @primary_key {:id, :string, autogenerate: false}
  schema "aliases" do
    field :url, Shortener.EctoURIType
  end

  def changeset(%__MODULE__{} = struct \\ %__MODULE__{}, attributes \\ %{}) do
    struct
    |> cast(attributes, [:url])
    |> validate_required(:url)
    |> validate_url_schema()
  end

  defp validate_url_schema(changeset) do
    changeset
    |> validate_change(:url, fn :url, url ->
      missing_attributes =
        Enum.filter([:scheme, :host], fn required_key ->
          is_nil(Map.get(url, required_key))
        end)

      if Enum.any?(missing_attributes) do
        [
          url: "The URL given is not valid."
        ]
      else
        []
      end
    end)
  end
end
