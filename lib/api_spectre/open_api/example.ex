defmodule ApiSpectre.OpenApi.Example do
  @moduledoc """
  Represents the Example Object from the OpenAPI 3.1.1 specification (section 4.8.19).

  An object grouping an internal or external example value with basic summary and description metadata.
  This object is typically used in fields named `examples` (plural), and is a referenceable
  alternative to older `example` (singular) fields that do not support referencing or metadata.

  Examples allow demonstration of the usage of properties, parameters, and objects within OpenAPI.

  ## Fields

  * `summary` - String. Short description for the example.

  * `description` - String. Long description for the example.
    CommonMark syntax MAY be used for rich text representation.

  * `value` - Any. Embedded literal example. The `value` field and `externalValue` field
    are mutually exclusive. To represent examples of media types that cannot be naturally
    represented in JSON or YAML, use a string value to contain the example, escaping where necessary.

  * `externalValue` - String. A URI that points to the literal example.
    This provides the capability to reference examples that cannot easily be included
    in JSON or YAML documents. The `value` field and `externalValue` field are mutually exclusive.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Examples

  ```elixir
  # Example with an inline value
  %ApiSpectre.OpenApi.Example{
    summary: "A simple string example",
    description: "This example shows a basic string value",
    value: "Hello world!"
  }

  # Example with an external value
  %ApiSpectre.OpenApi.Example{
    summary: "A large file example",
    description: "This example references a large file that would be impractical to include inline",
    externalValue: "https://example.org/examples/large-file.json"
  }

  # Example with a complex object value
  %ApiSpectre.OpenApi.Example{
    summary: "User object example",
    description: "This example shows a typical user object",
    value: %{
      "id" => 123,
      "name" => "John Doe",
      "email" => "john.doe@example.com",
      "created_at" => "2020-01-01T12:00:00Z"
    }
  }
  ```
  """

  @type t :: %__MODULE__{
          summary: String.t() | nil,
          description: String.t() | nil,
          value: any() | nil,
          externalValue: String.t() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :summary,
    :description,
    :value,
    :externalValue,
    extensions: %{}
  ]
end
