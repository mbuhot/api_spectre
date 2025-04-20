defmodule ApiSpectre.OpenApi.Components do
  @moduledoc """
  Represents the Components Object from the OpenAPI 3.1.1 specification (section 4.8.7).

  The Components Object holds a set of reusable objects for different aspects of the OpenAPI specification.
  All objects defined within the Components Object will have no effect on the API unless they are
  explicitly referenced from outside the Components Object.

  ## Fields

  * `schemas` - Map[string, Schema Object | Reference Object]. An object to hold reusable Schema Objects.

  * `responses` - Map[string, Response Object | Reference Object]. An object to hold reusable Response Objects.

  * `parameters` - Map[string, Parameter Object | Reference Object]. An object to hold reusable Parameter Objects.

  * `examples` - Map[string, Example Object | Reference Object]. An object to hold reusable Example Objects.

  * `requestBodies` - Map[string, Request Body Object | Reference Object]. An object to hold reusable Request Body Objects.

  * `headers` - Map[string, Header Object | Reference Object]. An object to hold reusable Header Objects.

  * `securitySchemes` - Map[string, Security Scheme Object | Reference Object]. An object to hold reusable Security Scheme Objects.

  * `links` - Map[string, Link Object | Reference Object]. An object to hold reusable Link Objects.

  * `callbacks` - Map[string, Callback Object | Reference Object]. An object to hold reusable Callback Objects.

  * `pathItems` - Map[string, Path Item Object | Reference Object]. An object to hold reusable Path Item Objects.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.Components{
    schemas: %{
      "Pet" => %{
        "type" => "object",
        "required" => ["name"],
        "properties" => %{
          "name" => %{
            "type" => "string"
          },
          "age" => %{
            "type" => "integer",
            "format" => "int32",
            "minimum" => 0
          }
        }
      },
      "Error" => %{
        "type" => "object",
        "properties" => %{
          "code" => %{
            "type" => "integer",
            "format" => "int32"
          },
          "message" => %{
            "type" => "string"
          }
        }
      }
    },
    responses: %{
      "NotFound" => %{
        "description" => "The specified resource was not found",
        "content" => %{
          "application/json" => %{
            "schema" => %{
              "$ref" => "#/components/schemas/Error"
            }
          }
        }
      }
    },
    parameters: %{
      "skipParam" => %{
        "name" => "skip",
        "in" => "query",
        "description" => "Number of items to skip",
        "required" => false,
        "schema" => %{
          "type" => "integer",
          "format" => "int32"
        }
      }
    },
    securitySchemes: %{
      "api_key" => %{
        "type" => "apiKey",
        "name" => "api_key",
        "in" => "header"
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.{
    Callback,
    Example,
    Header,
    Link,
    PathItem,
    Reference,
    Response,
    RequestBody,
    SecurityScheme,
    Parameter
  }

  @type t :: %__MODULE__{
          schemas: %{optional(String.t()) => JSV.raw_schema() | Reference.t()} | nil,
          responses: %{optional(String.t()) => Response.t() | Reference.t()} | nil,
          parameters: %{optional(String.t()) => Parameter.t() | Reference.t()} | nil,
          examples: %{optional(String.t()) => Example.t() | Reference.t()} | nil,
          requestBodies: %{optional(String.t()) => RequestBody.t() | Reference.t()} | nil,
          headers: %{optional(String.t()) => Header.t() | Reference.t()} | nil,
          securitySchemes: %{optional(String.t()) => SecurityScheme.t() | Reference.t()} | nil,
          links: %{optional(String.t()) => Link.t() | Reference.t()} | nil,
          callbacks: %{optional(String.t()) => Callback.t() | Reference.t()} | nil,
          pathItems: %{optional(String.t()) => PathItem.t() | Reference.t()} | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :schemas,
    :responses,
    :parameters,
    :examples,
    :requestBodies,
    :headers,
    :securitySchemes,
    :links,
    :callbacks,
    :pathItems,
    extensions: %{}
  ]
end
