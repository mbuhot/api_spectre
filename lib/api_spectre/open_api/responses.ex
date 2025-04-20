defmodule ApiSpectre.OpenApi.Responses do
  @moduledoc """
  Represents the Responses Object from the OpenAPI 3.1.1 specification (section 4.8.16).

  The Responses Object is a container for the expected responses of an operation.

  ## Fields

  * `default` - Response Object | Reference Object. The documentation of responses other than
    the ones declared for specific HTTP response codes. Use this field to cover undeclared responses.
    A Reference Object can link to a response that is defined in the OpenAPI Object's components/responses section.

  * `{HTTP Status Code}` - Response Object | Reference Object. Any HTTP status code can be used as the property name,
    but only one property per code, to describe the expected response for that HTTP status code.
    A Reference Object can link to a response that is defined in the OpenAPI Object's components/responses section.
    This field MUST be enclosed in quotation marks (for example, "200") for compatibility between JSON and YAML.
    To define a range of response codes, this field MAY contain the uppercase wildcard character X.
    For example, 2XX represents all response codes between 200-299.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.Responses{
    "200" => %ApiSpectre.OpenApi.Response{
      description: "a pet to be returned",
      content: %{
        "application/json" => %ApiSpectre.OpenApi.MediaType{
          schema: %{
            "$ref" => "#/components/schemas/Pet"
          }
        }
      }
    },
    "default" => %ApiSpectre.OpenApi.Response{
      description: "Unexpected error",
      content: %{
        "application/json" => %ApiSpectre.OpenApi.MediaType{
          schema: %{
            "$ref" => "#/components/schemas/ErrorModel"
          }
        }
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.Reference
  alias ApiSpectre.OpenApi.Response

  @type t :: %{optional(String.t()) => Response.t() | Reference.t()}
end
