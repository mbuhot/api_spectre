defmodule ApiSpectre.OpenApi.Paths do
  @moduledoc """
  Represents the Paths Object from the OpenAPI 3.1.1 specification (section 4.8.8).

  The Paths Object holds the relative paths to the individual endpoints and their operations.
  The path is appended to the URL from the Server Object in order to construct the full URL.
  The Paths Object MAY be empty, due to Access Control List (ACL) constraints.

  ## Fields

  * `/{path}` - Path Item Object. A relative path to an individual endpoint. The field name MUST begin
    with a forward slash (/). The path is appended (no relative URL resolution) to the expanded URL
    from the Server Object's url field in order to construct the full URL. Path templating is allowed.
    When matching URLs, concrete (non-templated) paths would be matched before their templated counterparts.

  ## Path Templating

  Path templating refers to the usage of template expressions, delimited by curly braces ({}),
  to mark a section of a URL path as replaceable using path parameters.

  Each template expression in the path MUST correspond to a path parameter that is included in the
  Path Item itself and/or in each of the Path Item's Operations.

  ## Example

  ```elixir
  %{
    "/pets" => %ApiSpectre.OpenApi.PathItem{
      get: %{
        summary: "List all pets",
        operationId: "listPets",
        parameters: [
          %ApiSpectre.OpenApi.Parameter{
            name: "limit",
            in: "query",
            description: "How many items to return at one time (max 100)",
            required: false,
            schema: %{
              type: "integer",
              format: "int32"
            }
          }
        ],
        responses: %{
          "200" => %{
            description: "A paged array of pets",
            content: %{
              "application/json" => %{
                schema: %{
                  "$ref" => "#/components/schemas/Pets"
                }
              }
            }
          }
        }
      },
      post: %{
        summary: "Create a pet",
        operationId: "createPets",
        responses: %{
          "201" => %{
            description: "Null response"
          }
        }
      }
    },
    "/pets/{petId}" => %ApiSpectre.OpenApi.PathItem{
      get: %{
        summary: "Info for a specific pet",
        operationId: "showPetById",
        parameters: [
          %{
            name: "petId",
            in: "path",
            required: true,
            description: "The id of the pet to retrieve",
            schema: %{
              type: "string"
            }
          }
        ],
        responses: %{
          "200" => %{
            description: "Expected response to a valid request",
            content: %{
              "application/json" => %{
                schema: %{
                  "$ref" => "#/components/schemas/Pet"
                }
              }
            }
          }
        }
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.PathItem

  @type t :: %{optional(String.t()) => PathItem.t()}
end
