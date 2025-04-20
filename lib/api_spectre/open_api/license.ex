defmodule ApiSpectre.OpenApi.License do
  @moduledoc """
  Represents the License Object from the OpenAPI 3.1.1 specification (section 4.8.4).

  The License Object provides license information for the exposed API.

  ## Fields

  * `name` - **REQUIRED**. String. The license name used for the API.

  * `identifier` - String. An SPDX license expression for the API. The `identifier` field is mutually
    exclusive of the `url` field.

  * `url` - String. A URI for the license used for the API. This MUST be in the form of a URI.
    The `url` field is mutually exclusive of the `identifier` field.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.License{
    name: "Apache 2.0",
    identifier: "Apache-2.0"
  }
  ```

  OR

  ```elixir
  %ApiSpectre.OpenApi.License{
    name: "Apache 2.0",
    url: "https://www.apache.org/licenses/LICENSE-2.0.html"
  }
  ```
  """

  @type t :: %__MODULE__{
          name: String.t(),
          identifier: String.t() | nil,
          url: String.t() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :name,
    :identifier,
    :url,
    extensions: %{}
  ]
end
