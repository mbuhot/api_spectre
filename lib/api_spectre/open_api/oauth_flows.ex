defmodule ApiSpectre.OpenApi.OAuthFlows do
  @moduledoc """
  Represents the OAuth Flows Object from the OpenAPI 3.1.1 specification (section 4.8.28).

  Allows configuration of the supported OAuth Flows.

  ## Fields

  * `implicit` - OAuth Flow Object. Configuration for the OAuth Implicit flow.
  * `password` - OAuth Flow Object. Configuration for the OAuth Resource Owner Password flow.
  * `clientCredentials` - OAuth Flow Object. Configuration for the OAuth Client Credentials flow.
  * `authorizationCode` - OAuth Flow Object. Configuration for the OAuth Authorization Code flow.
  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.OAuthFlows{
    implicit: %ApiSpectre.OpenApi.OAuthFlow{
      authorizationUrl: "https://example.com/oauth/authorize",
      scopes: %{
        "read:pets" => "read your pets",
        "write:pets" => "modify pets in your account"
      }
    },
    authorizationCode: %ApiSpectre.OpenApi.OAuthFlow{
      authorizationUrl: "https://example.com/oauth/authorize",
      tokenUrl: "https://example.com/oauth/token",
      scopes: %{
        "read:pets" => "read your pets",
        "write:pets" => "modify pets in your account"
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.OAuthFlow

  @type t :: %__MODULE__{
          implicit: OAuthFlow.t() | nil,
          password: OAuthFlow.t() | nil,
          clientCredentials: OAuthFlow.t() | nil,
          authorizationCode: OAuthFlow.t() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :implicit,
    :password,
    :clientCredentials,
    :authorizationCode,
    extensions: %{}
  ]
end
