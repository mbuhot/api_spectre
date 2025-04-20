defmodule ApiSpectre.OpenApi.Encoding do
  @moduledoc """
  Represents the Encoding Object from the OpenAPI 3.1.1 specification (section 4.8.15).

  A single encoding definition applied to a single schema property.
  The Encoding Object is only applicable to `requestBody` objects when the media type is
  `multipart` or `application/x-www-form-urlencoded`.

  ## Fields

  * `contentType` - String. The Content-Type for encoding a specific property.
    For non-binary data, the default value is `application/json`. For binary data,
    the default value is `application/octet-stream`.
    See the table in the specification section 4.8.15 for defaults based on data type.

  * `headers` - Map[string, Header Object | Reference Object]. A map allowing additional information
    to be provided as headers, for example `Content-Disposition`. The keys are header names and values
    are Header Objects or Reference Objects.

  * `style` - String. Describes how the parameter value will be serialized depending on the type of the
    parameter value. Default value is `form`. See Parameter Object for supported styles.

  * `explode` - Boolean. When set to `true`, parameter values of type `array` or `object` generate
    separate parameters for each value of the array or key-value pair of the map. For other types of
    parameters, this property has no effect. Default value is `false` except for `form` style where it
    is `true`.

  * `allowReserved` - Boolean. Determines whether the parameter value should allow reserved characters,
    as defined by RFC3986 `:/?#[]@!$&'()*+,;=` to be included without percent-encoding.
    Default value is `false`.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %{
    requestBody:  %ApiSpectre.OpenApi.RequestBody{
      content: %{
        "multipart/form-data" => %ApiSpectre.OpenApi.MediaType{
          schema: %{
            "type" => "object",
            "properties" => %{
              "id" => %{
                # default is `text/plain`
                "type" => "string",
                "format" => "uuid"
              },
              "addresses" => %{
                # default based on the `items` subschema would be
                # `application/json`, but we want these address objects
                # serialized as `application/xml` instead
                "description" => "addresses in XML format",
                "type" => "array",
                "items" => %{
                  "$ref" => "#/components/schemas/Address"
                }
              },
              "profileImage" => %{
                # default is application/octet-stream, but we can declare
                # a more specific image type or types
                "type" => "string",
                "format" => "binary"
              }
            }
          },
          encoding: %{
            "addresses" => %ApiSpectre.OpenApi.Encoding{
              # require XML Content-Type in utf-8 encoding
              # This is applied to each address part corresponding
              # to each address in the array
              contentType: "application/xml; charset=utf-8"
            },
            "profileImage" => %ApiSpectre.OpenApi.Encoding{
              # only accept png or jpeg
              contentType: "image/png, image/jpeg",
              headers: %{
                "X-Rate-Limit-Limit" => %ApiSpectre.OpenApi.Header{
                  description: "The number of allowed requests in the current period",
                  schema: %{
                    "type" => "integer"
                  }
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

  alias ApiSpectre.OpenApi.{Header, Reference}

  @type t :: %__MODULE__{
          contentType: String.t() | nil,
          headers: %{optional(String.t()) => Header.t() | Reference.t()} | nil,
          style: String.t() | nil,
          explode: boolean() | nil,
          allowReserved: boolean() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :contentType,
    :headers,
    :style,
    :explode,
    :allowReserved,
    extensions: %{}
  ]
end
