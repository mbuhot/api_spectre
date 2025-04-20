defmodule ApiSpectre.OpenApi.RequestBody do
  @moduledoc """
  Represents the Request Body Object from the OpenAPI 3.1.1 specification (section 4.8.13).

  The Request Body Object describes a request body applicable to an operation.

  ## Fields

  * `description` - String. A brief description of the request body.
    CommonMark syntax MAY be used for rich text representation.

  * `content` - **REQUIRED**. Map[string, Media Type Object]. The content of the request body.
    The key is the media type or media type range and the value describes it. For
    requests that match multiple keys, only the most specific key is applicable, e.g.
    `text/plain` overrides `text/*`.

  * `required` - Boolean. Determines if the request body is required in the request.
    Default value is `false`.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.RequestBody{
    description: "User to add to the system",
    content: %{
      "application/json" => %ApiSpectre.OpenApi.MediaType{
        schema: %{
          "$ref" => "#/components/schemas/User"
        }
      },
      "application/xml" => %ApiSpectre.OpenApi.MediaType{
        schema: %{
          "$ref" => "#/components/schemas/User"
        }
      },
      "text/plain" => %ApiSpectre.OpenApi.MediaType{
        schema: %{
          "type" => "string"
        }
      }
    },
    required: true
  }
  ```

  ## Example with multipart/form-data

  ```elixir
  %ApiSpectre.OpenApi.RequestBody{
    content: %{
      "multipart/form-data" => %ApiSpectre.OpenApi.MediaType{
        schema: %{
          type: "object",
          properties: %{
            id: %{
              type: "string",
              format: "uuid"
            },
            profileImage: %{
              type: "string",
              format: "binary"
            }
          }
        },
        encoding: %{
          profileImage: %{
            contentType: "image/png, image/jpeg"
          }
        }
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.MediaType

  @type t :: %__MODULE__{
          description: String.t() | nil,
          content: %{optional(String.t()) => MediaType.t()},
          required: boolean() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :description,
    :content,
    :required,
    extensions: %{}
  ]
end
