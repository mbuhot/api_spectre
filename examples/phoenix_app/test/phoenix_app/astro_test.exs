defmodule PhoenixApp.AstroTest do
  use PhoenixApp.DataCase

  alias PhoenixApp.Astro

  describe "planets" do
    alias PhoenixApp.Astro.Planet

    import PhoenixApp.AstroFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_planets/0 returns all planets" do
      planet = planet_fixture()
      assert Astro.list_planets() == [planet]
    end

    test "get_planet!/1 returns the planet with given id" do
      planet = planet_fixture()
      assert Astro.get_planet!(planet.id) == planet
    end

    test "create_planet/1 with valid data creates a planet" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %Planet{} = planet} = Astro.create_planet(valid_attrs)
      assert planet.name == "some name"
      assert planet.description == "some description"
    end

    test "create_planet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Astro.create_planet(@invalid_attrs)
    end

    test "update_planet/2 with valid data updates the planet" do
      planet = planet_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Planet{} = planet} = Astro.update_planet(planet, update_attrs)
      assert planet.name == "some updated name"
      assert planet.description == "some updated description"
    end

    test "update_planet/2 with invalid data returns error changeset" do
      planet = planet_fixture()
      assert {:error, %Ecto.Changeset{}} = Astro.update_planet(planet, @invalid_attrs)
      assert planet == Astro.get_planet!(planet.id)
    end

    test "delete_planet/1 deletes the planet" do
      planet = planet_fixture()
      assert {:ok, %Planet{}} = Astro.delete_planet(planet)
      assert_raise Ecto.NoResultsError, fn -> Astro.get_planet!(planet.id) end
    end

    test "change_planet/1 returns a planet changeset" do
      planet = planet_fixture()
      assert %Ecto.Changeset{} = Astro.change_planet(planet)
    end
  end
end
