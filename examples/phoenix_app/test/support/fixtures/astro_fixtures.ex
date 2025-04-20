defmodule PhoenixApp.AstroFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixApp.Astro` context.
  """

  @doc """
  Generate a planet.
  """
  def planet_fixture(attrs \\ %{}) do
    {:ok, planet} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> PhoenixApp.Astro.create_planet()

    planet
  end
end
