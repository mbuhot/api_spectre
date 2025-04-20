defmodule PhoenixAppWeb.PlanetController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Astro
  alias PhoenixApp.Astro.Planet

  action_fallback(PhoenixAppWeb.FallbackController)

  def open_api_operation(:index), do: index_operation()
  def open_api_operation(:create), do: create_operation()
  def open_api_operation(:show), do: show_operation()
  def open_api_operation(:update), do: update_operation()
  def open_api_operation(:delete), do: delete_operation()

  def index_operation do
    %ApiSpectre.OpenApi.Operation{
      operationId: "planets:list",
      tags: ["Astronomy"],
      summary: "Lists Planets",
      description: """
      Returns a list of Planets.
      """,
      responses: %{
        "200" => %ApiSpectre.OpenApi.Response{
          description: "Success",
          content: %{
            "application/json" => %ApiSpectre.OpenApi.MediaType{
              schema: %{
                type: "object",
                properties: %{
                  results: %{
                    type: "array",
                    items: %{"$ref" => "#/components/schemas/planet"}
                  }
                }
              }
            }
          }
        }
      }
    }
  end

  def index(conn, _params) do
    planets = Astro.list_planets()
    render(conn, :index, planets: planets)
  end

  def create_operation() do
    %ApiSpectre.OpenApi.Operation{
      operationId: "planets:create",
      tags: ["Astronomy"],
      summary: "Create a Planet",
      description: """
      Add a planet to the planets database.
      """,
      requestBody: %ApiSpectre.OpenApi.RequestBody{
        description: "User to add to the system",
        content: %{
          "application/json" => %ApiSpectre.OpenApi.MediaType{
            schema: %{
              type: "object",
              properties: %{
                name: %{type: "string"},
                description: %{type: "string"}
              }
            }
          }
        }
      },
      responses: %{
        "201" => %ApiSpectre.OpenApi.Response{
          description: "Created",
          content: %{
            "application/json" => %ApiSpectre.OpenApi.MediaType{
              schema: %{"$ref": "#/components/schemas/planet"}
            }
          }
        }
      }
    }
  end

  def create(conn, %{"planet" => planet_params}) do
    with {:ok, %Planet{} = planet} <- Astro.create_planet(planet_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/planets/#{planet}")
      |> render(:show, planet: planet)
    end
  end

  def show_operation do
    %ApiSpectre.OpenApi.Operation{
      operationId: "planets:show",
      tags: ["Astronomy"],
      summary: "Get a Planet by ID",
      description: """
      Add a planet to the planets database.
      """,
      parameters: [
        %ApiSpectre.OpenApi.Parameter{
          name: "id",
          in: "path",
          description: "The Planet ID",
          required: true,
          schema: %{type: "string", format: "uuid"}
        }
      ],
      responses: %{
        "200" => %ApiSpectre.OpenApi.Response{
          description: "Success",
          content: %{
            "application/json" => %ApiSpectre.OpenApi.MediaType{
              schema: %{"$ref": "#/components/schemas/planet"}
            }
          }
        },
        "404" => %ApiSpectre.OpenApi.Response{
          description: "Not Found"
        }
      }
    }
  end

  def show(conn, %{"id" => id}) do
    planet = Astro.get_planet!(id)
    render(conn, :show, planet: planet)
  end

  def update_operation() do
    %ApiSpectre.OpenApi.Operation{
      operationId: "planets:update",
      tags: ["Astronomy"],
      summary: "Update a Planet",
      description: """
      Update an existing planet in the planets database.
      """,
      parameters: [
        %ApiSpectre.OpenApi.Parameter{
          name: "id",
          in: "path",
          description: "The Planet ID",
          required: true,
          schema: %{type: "string", format: "uuid"}
        }
      ],
      requestBody: %ApiSpectre.OpenApi.RequestBody{
        description: "Updated planet information",
        content: %{
          "application/json" => %ApiSpectre.OpenApi.MediaType{
            schema: %{
              type: "object",
              properties: %{
                name: %{type: "string"},
                description: %{type: "string"}
              }
            }
          }
        }
      },
      responses: %{
        "200" => %ApiSpectre.OpenApi.Response{
          description: "Success",
          content: %{
            "application/json" => %ApiSpectre.OpenApi.MediaType{
              schema: %{"$ref": "#/components/schemas/planet"}
            }
          }
        },
        "404" => %ApiSpectre.OpenApi.Response{
          description: "Not Found"
        }
      }
    }
  end

  def update(conn, %{"id" => id, "planet" => planet_params}) do
    planet = Astro.get_planet!(id)

    with {:ok, %Planet{} = planet} <- Astro.update_planet(planet, planet_params) do
      render(conn, :show, planet: planet)
    end
  end

  def delete_operation() do
    %ApiSpectre.OpenApi.Operation{
      operationId: "planets:delete",
      tags: ["Astronomy"],
      summary: "Delete a Planet",
      description: """
      Delete a planet from the planets database.
      """,
      parameters: [
        %ApiSpectre.OpenApi.Parameter{
          name: "id",
          in: "path",
          description: "The Planet ID",
          required: true,
          schema: %{type: "string", format: "uuid"}
        }
      ],
      responses: %{
        "204" => %ApiSpectre.OpenApi.Response{
          description: "No Content"
        },
        "404" => %ApiSpectre.OpenApi.Response{
          description: "Not Found"
        }
      }
    }
  end

  def delete(conn, %{"id" => id}) do
    planet = Astro.get_planet!(id)

    with {:ok, %Planet{}} <- Astro.delete_planet(planet) do
      send_resp(conn, :no_content, "")
    end
  end
end
