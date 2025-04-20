defmodule ApiSpectre.OpenApi.Response do
  @moduledoc """
  Represents the Response Object from the OpenAPI 3.1.1 specification (section 4.8.17).

  The Response Object describes a single response from an API operation.

  ## Fields

  * `description` - **REQUIRED**. String. A description of the response.
    CommonMark syntax MAY be used for rich text representation.

  * `headers` - Map[string, Header Object | Reference Object]. Maps a header name to its definition.
    RFC7230 states header names are case insensitive. If a response header is defined with the name
    "Content-Type", it SHALL be ignored.

  * `content` - Map[string, Media Type Object]. A map containing descriptions of potential response
    payloads. The key is a media type or media type range and the value describes it. For responses
    that match multiple keys, only the most specific key is applicable, e.g. text/plain overrides text/*.

  * `links` - Map[string, Link Object | Reference Object]. A map of operations links that can be
    followed from the response. The key is a short name for the link, following the naming constraints
    of the names for Component Objects.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.Response{
    description: "A complex object array response",
    content: %{
      "application/json" => %ApiSpectre.OpenApi.MediaType{
        schema: %{
          type: "array",
          items: %{
            "$ref" => "#/components/schemas/VeryComplexObject"
          }
        }
      }
    },
    headers: %{
      "X-Rate-Limit-Limit" => %{
        description: "The number of allowed requests in the current period",
        schema: %{
          type: "integer"
        }
      },
      "X-Rate-Limit-Remaining" => %{
        description: "The number of remaining requests in the current period",
        schema: %{
          type: "integer"
        }
      }
    },
    links: %{
      "address" => %{
        operationId: "getUserAddress",
        parameters: %{
          "userId" => "$response.body#/id"
        }
      }
    }
  }
  ```
  """
  alias ApiSpectre.OpenApi.{Header, Link, MediaType, Reference}

  @type t :: %__MODULE__{
          description: String.t(),
          headers: %{optional(String.t()) => Header.t() | Reference.t()} | nil,
          content: %{optional(String.t()) => MediaType.t()} | nil,
          links: %{optional(String.t()) => Link.t()} | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :description,
    :headers,
    :content,
    :links,
    extensions: %{}
  ]
end
