defmodule PhoenixApp.Astro.Planet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "planets" do
    field :name, :string
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(planet, attrs) do
    planet
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
