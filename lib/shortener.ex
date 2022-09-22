defmodule Shortener do
  alias Shortener.{
    AliasIDInventory,
    Alias
  }

  alias Shortener.Repo

  @spec change_alias() :: Ecto.Changeset.t(Alias.t())
  defdelegate change_alias(), to: Alias, as: :changeset

  @spec pick_alias_id() :: String.t()
  defdelegate pick_alias_id(), to: AliasIDInventory, as: :pick

  @spec insert_alias(
          map(),
          (() -> String.t()),
          keyword()
        ) :: {:ok, Alias.t()} | {:error, Ecto.Changeset.t()}
  def insert_alias(
        %{} = attributes,
        id_generator \\ fn -> pick_alias_id() end,
        options \\ []
      ) do
    %Alias{}
    |> Alias.changeset(attributes)
    |> Ecto.Changeset.put_change(:id, Keyword.get(options, :id) || id_generator.())
    |> Repo.insert(
      on_conflict: [set: [id: id_generator.()]],
      conflict_target: :id,
      returning: true
    )
  end

  @spec get_alias(String.t()) :: {:ok, Alias.t()} | {:error, :not_found}
  def get_alias(id) do
    case Repo.get(Alias, id) do
      nil -> {:error, :not_found}
      url_alias -> {:ok, url_alias}
    end
  end
end
