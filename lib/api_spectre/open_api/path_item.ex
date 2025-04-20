defmodule ApiSpectre.OpenApi.PathItem do
  @moduledoc """
  Represents the Path Item Object from the OpenAPI 3.1.1 specification (section 4.8.9).

  The Path Item Object describes the operations available on a single path.

  ## Fields

  * `$ref` - String. Allows for a referenced definition of this path item. The referenced structure
    MUST be in the form of a Path Item Object. If a Path Item Object field appears both in the defined
    object and the referenced object, the behavior is undefined.

  * `summary` - String. An optional string summary, intended to apply to all operations in this path.

  * `description` - String. An optional string description, intended to apply to all operations in this path.
    CommonMark syntax MAY be used for rich text representation.

  * `get` - Operation Object. A definition of a GET operation on this path.

  * `put` - Operation Object. A definition of a PUT operation on this path.

  * `post` - Operation Object. A definition of a POST operation on this path.

  * `delete` - Operation Object. A definition of a DELETE operation on this path.

  * `options` - Operation Object. A definition of a OPTIONS operation on this path.

  * `head` - Operation Object. A definition of a HEAD operation on this path.

  * `patch` - Operation Object. A definition of a PATCH operation on this path.

  * `trace` - Operation Object. A definition of a TRACE operation on this path.

  * `servers` - List of Server Objects. An alternative servers array to service all operations in this path.
    If a servers array is specified at the OpenAPI Object level, it will be overridden by this value.

  * `parameters` - List of Parameter Objects or Reference Objects. A list of parameters that are applicable
    for all the operations described under this path. These parameters can be overridden at the
    operation level, but cannot be removed there.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.PathItem{
    summary: "Pet operations",
    description: "Operations for working with pets",
    get: %ApiSpectre.OpenApi.Operation{
      summary: "Returns pets based on ID",
      description: "Returns a pet when ID is provided",
      operationId: "getPetsById",
      parameters: [
        %ApiSpectre.OpenApi.Parameter{
          name: "id",
          in: "path",
          description: "ID of pet to use",
          required: true,

          %{
            type: "array",
            items: %{
              type: "string"
            }
          },
          style: "simple"
        }
      ],
      responses: %{
        "200" => %{
          description: "pet response",
          content: %{
            "application/json" => %{
              schema: %{
                type: "array",
                items: %{
                  "$ref" => "#/components/schemas/Pet"
                }
              }
            }
          }
        },
        "default" => %{
          description: "error payload",
          content: %{
            "text/html" => %{
              schema: %{
                "$ref" => "#/components/schemas/ErrorModel"
              }
            }
          }
        }
      }
    },
    post: %ApiSpectre.OpenApi.Operation{
      summary: "Creates a new pet",
      requestBody: %{
        content: %{
          "application/json" => %{
            schema: %{
              "$ref" => "#/components/schemas/Pet"
            }
          }
        },
        required: true
      },
      responses: %{
        "201" => %{
          description: "Pet created"
        }
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.{Operation, Parameter, Reference, Server}

  @type t :: %__MODULE__{
          "$ref": String.t() | nil,
          summary: String.t() | nil,
          description: String.t() | nil,
          get: Operation.t() | nil,
          put: Operation.t() | nil,
          post: Operation.t() | nil,
          delete: Operation.t() | nil,
          options: Operation.t() | nil,
          head: Operation.t() | nil,
          patch: Operation.t() | nil,
          trace: Operation.t() | nil,
          servers: [Server.t()] | nil,
          parameters: [Parameter.t() | Reference.t()] | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :"$ref",
    :summary,
    :description,
    :get,
    :put,
    :post,
    :delete,
    :options,
    :head,
    :patch,
    :trace,
    :servers,
    :parameters,
    extensions: %{}
  ]
end
