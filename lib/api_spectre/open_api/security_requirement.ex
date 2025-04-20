defmodule ApiSpectre.OpenApi.SecurityRequirement do
  @moduledoc """
  Represents the Security Requirement Object from the OpenAPI 3.1.1 specification (section 4.8.30).

  Lists the required security schemes to execute this operation. The name used for each property
  MUST correspond to a security scheme declared in the Security Schemes under the Components Object.

  Security Requirement Objects are not technically structs but maps where:
  - Each key is the name of a security scheme, which MUST correspond to a security scheme
    declared in the Components Object's securitySchemes field.
  - Each value is an array of strings representing the required scopes for the security scheme.
    This can be an empty array for security schemes that don't use scopes (like basic auth).

  When a list of Security Requirement Objects is defined on the OpenAPI Object or Operation Object,
  only one of the security requirement objects needs to be satisfied to authorize the request.

  ## Examples

  ```elixir
  # Basic authentication with no scopes
  %{"basicAuth" => []}

  # API key authentication with no scopes
  %{"api_key" => []}

  # OAuth2 authentication with required scopes
  %{"oauth2" => ["read:pets", "write:pets"]}

  # Requiring multiple security schemes (AND relationship)
  %{"api_key" => [], "oauth2" => ["read:pets"]}

  # Alternative security requirements (OR relationship)
  [
    %{"api_key" => []},
    %{"oauth2" => ["read:pets"]},
    %{"basic_auth" => []}
  ]
  ```
  """

  @type t :: %{optional(String.t()) => [String.t()]}
end
