defmodule ApiSpectre.OpenApi.Tag do
  @moduledoc """
  Represents the Tag Object from the OpenAPI 3.1.1 specification (section 4.8.22).

  Adds metadata to a single tag that is used by the Operation Object.
  It is not mandatory to have a Tag Object per tag defined in the Operation Object instances.

  ## Fields

  * `name` - String. REQUIRED. The name of the tag.

  * `description` - String. A short description for the tag. CommonMark syntax MAY be used for rich text representation.

  * `externalDocs` - External Documentation Object. Additional external documentation for this tag.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Examples

  ```elixir
  # Basic tag
  %ApiSpectre.OpenApi.Tag{
    name: "pets",
    description: "Pet operations"
  }

  # Tag with external documentation
  %ApiSpectre.OpenApi.Tag{
    name: "store",
    description: "Store operations",
    externalDocs: %ApiSpectre.OpenApi.ExternalDocs{
      description: "Find out more about our store",
      url: "https://example.com/docs/store"
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.ExternalDocs

  @type t :: %__MODULE__{
          name: String.t(),
          description: String.t() | nil,
          externalDocs: ExternalDocs.t() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :name,
    :description,
    :externalDocs,
    extensions: %{}
  ]
end
