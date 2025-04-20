defmodule ApiSpectre.OpenApi do
  @moduledoc """
  This is the root object of the OpenAPI Description.

  Represents the OpenAPI Object as defined in section 4.8.1 of the OpenAPI 3.1.1 specification.

  ## Fields

  * `openapi` - **REQUIRED**. String. The semantic version number of the OpenAPI Specification that this OpenAPI document uses.
    Must be "3.1.x" to match this specification.

  * `info` - **REQUIRED**. Info Object. Provides metadata about the API.

  * `jsonSchemaDialect` - String. The default value for the $schema keyword within Schema Objects contained within this OAS document.
    This MUST be in the form of a URI.

  * `servers` - List of Server Objects. An array of Server Objects which provide connectivity information to a target server.
    If not provided, defaults to a Server Object with a url value of /.

  * `paths` - Paths Object. The available paths and operations for the API.
    Either this field or `webhooks` MUST be present.

  * `webhooks` - Map of Webhook Objects or Reference Objects. The incoming webhooks that MAY be received as part of this API.
    The key name is a unique string used to identify each webhook, while the (optionally referenced) Path Item Object
    describes a request that may be initiated by the API provider and the expected responses.
    Either this field or `paths` MUST be present.

  * `components` - Components Object. An element to hold various schemas for the OpenAPI document.

  * `security` - List of Security Requirement Objects. A declaration of which security mechanisms can be used across the API.
    The list of values includes alternative security requirement objects that can be used.
    Only one of the security requirement objects need to be satisfied to authorize a request.
    Individual operations can override this definition.

  * `tags` - List of Tag Objects. A list of tags used by the document with additional metadata.

  * `externalDocs` - External Documentation Object. Additional external documentation.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.
  """
  alias ApiSpectre.OpenApi.{
    Components,
    ExternalDocs,
    Info,
    PathItem,
    Paths,
    Reference,
    SecurityRequirement,
    Server,
    Tag
  }

  @type t :: %__MODULE__{
          openapi: String.t(),
          info: Info.t(),
          jsonSchemaDialect: String.t() | nil,
          servers: [Server.t()] | nil,
          paths: Paths.t() | nil,
          webhooks: %{String.t() => PathItem.t() | Reference.t()} | nil,
          components: Components.t() | nil,
          security: [SecurityRequirement.t()] | nil,
          tags: [Tag.t()] | nil,
          externalDocs: ExternalDocs.t() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :openapi,
    :info,
    :jsonSchemaDialect,
    :servers,
    :paths,
    :webhooks,
    :components,
    :security,
    :tags,
    :externalDocs,
    extensions: %{}
  ]
end
