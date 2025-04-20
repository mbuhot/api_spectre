defmodule ApiSpectre.OpenApi.OAuthFlow do
  @moduledoc """
  Represents the OAuth Flow Object from the OpenAPI 3.1.1 specification (section 4.8.29).

  Configuration details for a supported OAuth Flow.

  ## Fields

  * `authorizationUrl` - String. **REQUIRED** for `implicit` and `authorizationCode` flows.
    The authorization URL to be used for this flow. This MUST be in the form of a URL.
    The OAuth2 standard requires the use of TLS.

  * `tokenUrl` - String. **REQUIRED** for `password`, `clientCredentials` and `authorizationCode` flows.
    The token URL to be used for this flow. This MUST be in the form of a URL.
    The OAuth2 standard requires the use of TLS.

  * `refreshUrl` - String. The URL to be used for obtaining refresh tokens. This MUST be in the
    form of a URL. The OAuth2 standard requires the use of TLS.

  * `scopes` - Map[String, String]. **REQUIRED**. A map between the scope name and a short
    description for it. The map MAY be empty.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Examples

  ```elixir
  # Implicit flow
  %ApiSpectre.OpenApi.OAuthFlow{
    authorizationUrl: "https://example.com/oauth/authorize",
    scopes: %{
      "read:pets" => "read your pets",
      "write:pets" => "modify pets in your account"
    }
  }

  # Authorization Code flow
  %ApiSpectre.OpenApi.OAuthFlow{
    authorizationUrl: "https://example.com/oauth/authorize",
    tokenUrl: "https://example.com/oauth/token",
    refreshUrl: "https://example.com/oauth/refresh",
    scopes: %{
      "read:pets" => "read your pets",
      "write:pets" => "modify pets in your account"
    }
  }

  # Client Credentials flow
  %ApiSpectre.OpenApi.OAuthFlow{
    tokenUrl: "https://example.com/oauth/token",
    scopes: %{
      "read:pets" => "read your pets"
    }
  }

  # Password flow
  %ApiSpectre.OpenApi.OAuthFlow{
    tokenUrl: "https://example.com/oauth/token",
    scopes: %{
      "read:pets" => "read your pets",
      "write:pets" => "modify pets in your account",
      "admin" => "administrator access"
    }
  }
  ```
  """

  @type t :: %__MODULE__{
          authorizationUrl: String.t() | nil,
          tokenUrl: String.t() | nil,
          refreshUrl: String.t() | nil,
          scopes: %{optional(String.t()) => String.t()},
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :authorizationUrl,
    :tokenUrl,
    :refreshUrl,
    scopes: %{},
    extensions: %{}
  ]
end
