defmodule PhoenixAppWeb.Api do
  def open_api_description() do
    %ApiSpectre.OpenApi{
      openapi: "3.1.1",
      info: %ApiSpectre.OpenApi.Info{
        title: "Planets API",
        summary: "CRUD operations for planets",
        description: """
        A more detailed description telling the user
        about the CRUD operations on planets API.
        """,
        contact: %ApiSpectre.OpenApi.Contact{
          name: "Joe",
          email: "Joe@example.com"
        },
        version: "1.0.0"
      }
    }
    |> ApiSpectre.add_router(PhoenixAppWeb.Router)
    |> ApiSpectre.add_schemas(%{"planet" => PhoenixAppWeb.PlanetJSON.schema()})
  end
end
