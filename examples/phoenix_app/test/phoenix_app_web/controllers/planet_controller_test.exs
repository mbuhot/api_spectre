defmodule PhoenixAppWeb.PlanetControllerTest do
  use PhoenixAppWeb.ConnCase

  import PhoenixApp.AstroFixtures
  alias PhoenixApp.Astro.Planet

  @create_attrs %{
    name: "some name",
    description: "some description"
  }
  @update_attrs %{
    name: "some updated name",
    description: "some updated description"
  }
  @invalid_attrs %{name: nil, description: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all planets", %{conn: conn} do
      conn = get(conn, ~p"/api/planets")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create planet" do
    test "renders planet when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/planets", planet: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/planets/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/planets", planet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update planet" do
    setup [:create_planet]

    test "renders planet when data is valid", %{conn: conn, planet: %Planet{id: id} = planet} do
      conn = put(conn, ~p"/api/planets/#{planet}", planet: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/planets/#{id}")

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, planet: planet} do
      conn = put(conn, ~p"/api/planets/#{planet}", planet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete planet" do
    setup [:create_planet]

    test "deletes chosen planet", %{conn: conn, planet: planet} do
      conn = delete(conn, ~p"/api/planets/#{planet}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/planets/#{planet}")
      end
    end
  end

  defp create_planet(_) do
    planet = planet_fixture()

    %{planet: planet}
  end
end
