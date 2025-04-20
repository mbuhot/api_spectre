defmodule ApiSpectre.OpenApi.Parameter do
  @moduledoc """
  Represents the Parameter Object from the OpenAPI 3.1.1 specification (section 4.8.12).

  The Parameter Object describes a single operation parameter.

  ## Parameter Locations

  Parameters can be passed in different locations of a request:

  * path - Parameters that are part of the path, e.g. `/items/{itemId}`
  * query - Parameters appended to the URL, e.g. `/items?id=123`
  * header - Custom headers that are part of the request
  * cookie - Used to pass a specific cookie value to the API

  ## Fields

  ### Common Fields

  * `name` - **REQUIRED**. String. The name of the parameter. Parameter names are case-sensitive.
    * For `path` parameters, the name must correspond to a template expression in the path field of the Path Item.
    * For `query` parameters, the name is used as the parameter name in the query string.
    * For `header` parameters, the name is the header name.
    * For `cookie` parameters, the name is the cookie name.

  * `in` - **REQUIRED**. String. The location of the parameter: "path", "query", "header", or "cookie".

  * `description` - String. A brief description of the parameter.
    CommonMark syntax MAY be used for rich text representation.

  * `required` - Boolean. Determines whether this parameter is mandatory.
    * For `path` parameters, this is **REQUIRED** and its value MUST be `true`.
    * For other parameters, if not specified, the default value is `false`.

  * `deprecated` - Boolean. Specifies that a parameter is deprecated and SHOULD be transitioned out of usage.
    Default value is `false`.

  ### Schema-based Fields

  * `schema` - Schema Object | Reference Object. The schema defining the type used for the parameter.

  * `style` - String. Describes how the parameter value will be serialized depending on the type of the parameter value.
    Default values based on the `in` field:
    * for "query" - "form"
    * for "path" - "simple"
    * for "header" - "simple"
    * for "cookie" - "form"

  * `explode` - Boolean. When true, parameter values of type array or object generate separate parameters
    for each value of the array or key-value pair of the map. Default value is `false` for all styles
    except `form` for which the default value is `true`.

  * `allowReserved` - Boolean. Determines whether the parameter value SHOULD allow reserved characters,
    as defined by RFC3986, to be included without percent-encoding. Default value is `false`.

  * `example` - Any. Example of the parameter's value. Should match the format defined in the schema field.
    The `example` field is mutually exclusive with the `examples` field.

  * `examples` - Map[string, Example Object | Reference Object]. Examples of the parameter's possible values.
    The `examples` field is mutually exclusive with the `example` field.

  ### Content-based Fields

  * `content` - Map[string, Media Type Object]. A map containing the representations for the parameter.
    The key is the media type and the value describes it. The map MUST only contain one entry.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  # Path parameter
  %ApiSpectre.OpenApi.Parameter{
    name: "petId",
    in: "path",
    description: "ID of pet to fetch",
    required: true,
    schema: %{
      type: "integer",
      format: "int64"
    }
  }

  # Query parameter with array format
  %ApiSpectre.OpenApi.Parameter{
    name: "ids",
    in: "query",
    description: "IDs of objects to fetch",
    required: false,
    schema: %{
      type: "array",
      items: %{
        type: "string"
      }
    },
    style: "form",
    explode: true
  }

  # Header parameter
  %ApiSpectre.OpenApi.Parameter{
    name: "X-Request-ID",
    in: "header",
    description: "ID of the request",
    required: false,
    schema: %{
      type: "string",
      format: "uuid"
    }
  }
  ```
  """

  @type t :: %__MODULE__{
          name: String.t(),
          in: String.t(),
          description: String.t() | nil,
          required: boolean() | nil,
          deprecated: boolean() | nil,
          allowEmptyValue: boolean() | nil,
          style: String.t() | nil,
          explode: boolean() | nil,
          allowReserved: boolean() | nil,
          schema: JSV.raw_schema() | ApiSpectre.OpenApi.Reference.t() | nil,
          example: any() | nil,
          examples: %{optional(String.t()) => map()} | nil,
          content: %{optional(String.t()) => map()} | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :name,
    :in,
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
