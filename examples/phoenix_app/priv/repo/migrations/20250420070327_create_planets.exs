defmodule PhoenixApp.Repo.Migrations.CreatePlanets do
  use Ecto.Migration

  def change do
    create table(:planets) do
      add :name, :string
      add :description, :string

      timestamps(type: :utc_datetime)
    end
  end
end
