defmodule ApiSpectre.OpenApi.Info do
  @moduledoc """
  Represents the Info Object from the OpenAPI 3.1.1 specification (section 4.8.2).

  The Info Object provides metadata about the API.

  ## Fields

  * `title` - **REQUIRED**. String. The title of the API.

  * `summary` - String. A short summary of the API.

  * `description` - String. A description of the API. CommonMark syntax MAY be used for rich text representation.

  * `termsOfService` - String. A URL to the Terms of Service for the API. This MUST be in the form of a URI.

  * `contact` - Contact Object. The contact information for the exposed API.

  * `license` - License Object. The license information for the exposed API.

  * `version` - **REQUIRED**. String. The version of the OpenAPI Document (which is distinct from the
    OpenAPI Specification version or the version of the API being described).

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.Info{
    title: "Example Pet Store App",
    summary: "A pet store manager.",
    description: "This is an example server for a pet store.",
    termsOfService: "https://example.com/terms/",
    contact: %ApiSpectre.OpenApi.Contact{
      name: "API Support",
      url: "https://www.example.com/support",
      email: "support@example.com"
    },
    license: %ApiSpectre.OpenApi.License{
      name: "Apache 2.0",
      url: "https://www.apache.org/licenses/LICENSE-2.0.html"
    },
    version: "1.0.1"
  }
  ```
  """

  alias ApiSpectre.OpenApi.{Contact, License}

  @type t :: %__MODULE__{
          title: String.t(),
          summary: String.t() | nil,
          description: String.t() | nil,
          termsOfService: String.t() | nil,
          contact: Contact.t() | nil,
          license: License.t() | nil,
          version: String.t(),
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :title,
    :summary,
    :description,
    :termsOfService,
    :contact,
    :license,
    :version,
    extensions: %{}
  ]
end
