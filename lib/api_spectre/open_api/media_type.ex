defmodule ApiSpectre.OpenApi.MediaType do
  @moduledoc """
  Represents the Media Type Object from the OpenAPI 3.1.1 specification (section 4.8.14).

  Each Media Type Object provides schema and examples for the media type identified by its key.

  ## Fields

  * `schema` - Schema Object | Reference Object. The schema defining the content of the request, response, or parameter.

  * `example` - Any. Example of the media type. The example object SHOULD be in the correct format
    as specified by the media type. The `example` field is mutually exclusive of the `examples` field.

  * `examples` - Map[string, Example Object | Reference Object]. Examples of the media type. Each example
    object SHOULD match the media type and specified schema if present. The `examples` field is mutually
    exclusive of the `example` field.

  * `encoding` - Map[string, Encoding Object]. A map between a property name and its encoding information.
    The key, being the property name, MUST exist in the schema as a property. The encoding object SHALL
    only apply to `requestBody` objects when the media type is `multipart` or `application/x-www-form-urlencoded`.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  # JSON content with schema reference
  %ApiSpectre.OpenApi.MediaType{
    schema: %{
      "$ref": "#/components/schemas/Pet"
    }
  }

  # Plain text content with inline schema
  %ApiSpectre.OpenApi.MediaType{
    schema: %{
      type: "string"
    },
    example: "Hello world!"
  }

  # Form content with encoding options
  %ApiSpectre.OpenApi.MediaType{
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
        contentType: "image/png, image/jpeg",
        headers: %{
          "X-Upload-Token": %{
            description: "Token for upload validation",
            schema: %{
              type: "string"
            }
          }
        }
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.{Encoding, Reference}

  @type t :: %__MODULE__{
          schema: JSV.raw_schema() | Reference.t() | nil,
          example: any() | nil,
          examples: %{optional(String.t()) => map()} | nil,
          encoding: %{optional(String.t()) => Encoding.t()} | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :schema,
    :example,
    :examples,
    :encoding,
    extensions: %{}
  ]
end
