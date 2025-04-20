defmodule ApiSpectre.OpenApi.ExternalDocs do
  @moduledoc """
  Represents the External Documentation Object from the OpenAPI 3.1.1 specification (section 4.8.11).

  The External Documentation Object allows referencing an external resource for extended documentation.

  ## Fields

  * `description` - String. A description of the target documentation.
    CommonMark syntax MAY be used for rich text representation.

  * `url` - **REQUIRED**. String. The URI for the target documentation.
    This MUST be in the form of a URI.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.ExternalDocs{
    description: "Find more info here",
    url: "https://example.com/docs"
  }
  ```
  """

  @type t :: %__MODULE__{
          description: String.t() | nil,
          url: String.t(),
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :description,
    :url,
    extensions: %{}
  ]
end
