defmodule ApiSpectre.OpenApi.ServerVariable do
  @moduledoc """
  Represents the Server Variable Object from the OpenAPI 3.1.1 specification (section 4.8.6).

  This object represents a Server Variable for server URL template substitution.

  ## Fields

  * `enum` - List of strings. An enumeration of string values to be used if the substitution options are limited to a specific set.

  * `default` - **REQUIRED**. String. The default value to use for substitution, which SHALL be sent if an alternate value is not supplied.
    Note this behavior is different from the Schema Object's treatment of default values, where default is used only if the field is not supplied.

  * `description` - String. An optional description for the server variable.
    CommonMark syntax MAY be used for rich text representation.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  # A server variable with an enum
  %ApiSpectre.OpenApi.ServerVariable{
    enum: ["8443", "443"],
    default: "8443",
    description: "The port to connect to"
  }

  # A server variable without enum (open value)
  %ApiSpectre.OpenApi.ServerVariable{
    default: "demo",
    description: "A user-specific subdomain. Use `demo` for a free sandbox environment."
  }
  ```
  """

  @type t :: %__MODULE__{
          enum: [String.t()] | nil,
          default: String.t(),
          description: String.t() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :enum,
    :default,
    :description,
    extensions: %{}
  ]
end
