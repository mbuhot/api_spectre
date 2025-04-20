defmodule ApiSpectre.OpenApi.Contact do
  @moduledoc """
  Represents the Contact Object from the OpenAPI 3.1.1 specification (section 4.8.3).

  The Contact Object provides contact information for the exposed API.

  ## Fields

  * `name` - String. The identifying name of the contact person/organization.

  * `url` - String. The URL pointing to the contact information. This MUST be in the form of a URI.

  * `email` - String. The email address of the contact person/organization. This MUST be in the form of an email address.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.Contact{
    name: "API Support",
    url: "https://www.example.com/support",
    email: "support@example.com"
  }
  ```
  """

  @type t :: %__MODULE__{
          name: String.t() | nil,
          url: String.t() | nil,
          email: String.t() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :name,
    :url,
    :email,
    extensions: %{}
  ]
end
