defmodule PhoenixAppWeb.PlanetJSON do
  require JSV
  alias PhoenixApp.Astro.Planet

  @doc """
  Renders a list of planets.
  """
  def index(%{planets: planets}) do
    %{data: for(planet <- planets, do: data(planet))}
  end

  @doc """
  Renders a single planet.
  """
  def show(%{planet: planet}) do
    %{data: data(planet)}
  end

  defp data(%Planet{} = planet) do
    %{
      id: planet.id,
      name: planet.name,
      description: planet.description
    }
  end

  @doc """
  JSON Schema for a Planet response
  """
  def schema do
    %{
      type: "object",
      properties: %{
        id: %{type: "string", format: "uuid"},
        name: %{type: "string"},
        description: %{type: "string"}
      }
    }
  end
end
