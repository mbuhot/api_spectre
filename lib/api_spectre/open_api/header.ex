defmodule ApiSpectre.OpenApi.Header do
  @moduledoc """
  Represents the Header Object from the OpenAPI 3.1.1 specification (section 4.8.21).

  The Header Object follows the structure of the Parameter Object with the following changes:

  1. `name` MUST NOT be specified, it is given in the corresponding headers map.
  2. `in` MUST NOT be specified, it is implicitly in `header`.
  3. All traits that are affected by the location MUST be applicable to a location of `header`
     (for example, `style`).

  ## Fields

  * `description` - String. A brief description of the header. This could contain examples
    of use. CommonMark syntax MAY be used for rich text representation.

  * `required` - Boolean. Determines whether this header is mandatory. The default value is `false`.

  * `deprecated` - Boolean. Specifies that a header is deprecated and SHOULD be transitioned
    out of usage. Default value is `false`.

  * `allowEmptyValue` - Boolean. Sets the ability to pass empty-valued headers. This is valid
    only for query parameters and allows sending a parameter with an empty value. Default
    value is `false`.

  ### Schema-related Fields

  * `style` - String. Describes how the parameter value will be serialized depending on the type of the
    parameter value. Default values is "simple".

  * `explode` - Boolean. When this is true, parameter values of type array or object generate
    separate parameters for each value of the array or key-value pair of the map. For other
    types of parameters this property has no effect. Default value is false.

  * `allowReserved` - Boolean. Determines whether the parameter value SHOULD allow reserved characters,
    as defined by RFC3986 `:/?#[]@!$&'()*+,;=` to be included without percent-encoding.
    This property only applies to parameters with an `in` value of `query`. Default value is `false`.

  * `schema` - Schema Object | Reference Object. The schema defining the type used for the parameter.

  * `example` - Any. Example of the parameter's potential value. The example SHOULD match the
    specified schema and encoding properties if present. The `example` field is mutually exclusive
    of the `examples` field. Furthermore, if referencing a `schema` that contains an example,
    the `example` value SHALL override the example provided by the schema. To represent examples
    of media types that cannot naturally be represented in JSON or YAML, a string value can contain
    the example with escaping where necessary.

  * `examples` - Map[String, Example Object | Reference Object]. Examples of the parameter's
    potential value. Each example SHOULD contain a value in the correct format as specified
    in the parameter encoding. The `examples` field is mutually exclusive of the `example` field.
    Furthermore, if referencing a `schema` that contains an example, the `examples` value SHALL
    override the example provided by the schema.

  ### Content-related Fields

  * `content` - Map[String, Media Type Object]. A map containing the representations for the parameter.
    The key is the media type and the value describes it. The map MUST only contain one entry.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Examples

  ```elixir
  # A header with schema
  %ApiSpectre.OpenApi.Header{
    description: "The number of allowed requests in the current period",
    schema: %{
      type: "integer"
    }
  }

  # A header with examples
  %ApiSpectre.OpenApi.Header{
    description: "Request ID header",
    schema: %{
      type: "string",
      format: "uuid"
    },
    examples: %{
      "default" => %ApiSpectre.OpenApi.Example{
        value: "123e4567-e89b-12d3-a456-426614174000"
      },
      "error" => %ApiSpectre.OpenApi.Example{
        value: "987e6543-a21c-34d5-b678-954321098765",
        summary: "Example for error response"
      }
    }
  }

  # A header with content
  %ApiSpectre.OpenApi.Header{
    description: "Complex header with JSON content",
    content: %{
      "application/json" => %ApiSpectre.OpenApi.MediaType{
        schema: %{
          type: "object",
          properties: %{
            version: %{
              type: "string"
            },
            timestamp: %{
              type: "string",
              format: "date-time"
            }
          }
        }
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.{Example, MediaType}

  @type t :: %__MODULE__{
          description: String.t() | nil,
          required: boolean() | nil,
          deprecated: boolean() | nil,
          allowEmptyValue: boolean() | nil,
          style: String.t() | nil,
          explode: boolean() | nil,
          allowReserved: boolean() | nil,
          schema: JSV.raw_schema() | %{:"$ref" => String.t()} | nil,
          example: any() | nil,
          examples: %{optional(String.t()) => Example.t() | %{:"$ref" => String.t()}} | nil,
          content: %{optional(String.t()) => MediaType.t()} | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :description,
    :required,
    :deprecated,
    :allowEmptyValue,
    :style,
    :explode,
    :allowReserved,
    :schema,
    :example,
    :examples,
    :content,
    extensions: %{}
  ]
end
