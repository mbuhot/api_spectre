defmodule ApiSpectre.OpenApi.Server do
  @moduledoc """
  Represents the Server Object from the OpenAPI 3.1.1 specification (section 4.8.5).

  The Server Object provides connectivity information to a target server.

  ## Fields

  * `url` - **REQUIRED**. String. A URL to the target host. This URL supports Server Variables
    and MAY be relative, to indicate that the host location is relative to the location where
    the document containing the Server Object is being served. Variable substitutions will
    be made when a variable is named in {braces}.

  * `description` - String. An optional string describing the host designated by the URL.
    CommonMark syntax MAY be used for rich text representation.

  * `variables` - Map[string, ServerVariable]. A map between a variable name and its value.
    The value is used for substitution in the server's URL template.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  # A simple server
  %ApiSpectre.OpenApi.Server{
    url: "https://development.gigantic-server.com/v1",
    description: "Development server"
  }

  # A server with variables
  %ApiSpectre.OpenApi.Server{
    url: "https://{username}.gigantic-server.com:{port}/{basePath}",
    description: "The production API server",
    variables: %{
      "username" => %ApiSpectre.OpenApi.ServerVariable{
        default: "demo",
        description: "A user-specific subdomain. Use `demo` for a free sandbox environment."
      },
      "port" => %ApiSpectre.OpenApi.ServerVariable{
        enum: ["8443", "443"],
        default: "8443"
      },
      "basePath" => %ApiSpectre.OpenApi.ServerVariable{
        default: "v2"
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.ServerVariable

  @type t :: %__MODULE__{
          url: String.t(),
          description: String.t() | nil,
          variables: %{optional(String.t()) => ServerVariable.t()} | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :url,
    :description,
    :variables,
    extensions: %{}
  ]
end
