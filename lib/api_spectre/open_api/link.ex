defmodule ApiSpectre.OpenApi.Link do
  @moduledoc """
  Represents the Link Object from the OpenAPI 3.1.1 specification (section 4.8.20).

  The Link Object represents a possible design-time link for a response. The presence of a link
  does not guarantee the caller's ability to successfully invoke it, rather it provides a known
  relationship and traversal mechanism between responses and other operations.

  Unlike dynamic links (i.e. links provided in the response payload), the OAS linking mechanism
  does not require link information in the runtime response.

  For computing links, and providing instructions to execute them, a runtime expression is used
  for accessing values in an operation and using them as parameters while invoking the linked
  operation.

  ## Fields

  * `operationRef` - String. A relative or absolute URI reference to an OAS operation. This field
    is mutually exclusive of the operationId field, and MUST point to an Operation Object.
    Relative operationRef values MAY be used to locate an existing Operation Object in the OpenAPI
    definition.

  * `operationId` - String. The name of an existing, resolvable OAS operation, as defined with a
    unique operationId. This field is mutually exclusive of the operationRef field.

  * `parameters` - Map[String, Any]. A map representing parameters to pass to an operation as specified
    with operationId or identified via operationRef. The key is the parameter name to be used,
    whereas the value can be a constant or an expression to be evaluated and passed to the linked
    operation. The parameter name can be qualified using the parameter location [{in}.]{name}
    for operations that use the same parameter name in different locations (e.g. path.id).

  * `requestBody` - Any | runtime expression. A literal value or runtime expression to use as a request body
    when calling the target operation.

  * `description` - String. A description of the link. CommonMark syntax may be used for rich text
    representation.

  * `server` - Server Object. A server object to be used by the target operation.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Examples

  ```elixir
  # Link to an operation by operationId
  %ApiSpectre.OpenApi.Link{
    operationId: "getUserAddress",
    parameters: %{
      "userId" => "$response.body#/id"
    },
    description: "The address for this user"
  }

  # Link to an operation by operationRef
  %ApiSpectre.OpenApi.Link{
    operationRef: "#/paths/~1users~1{id}/get",
    parameters: %{
      "id" => "$response.body#/userId"
    }
  }

  # Link with a request body
  %ApiSpectre.OpenApi.Link{
    operationId: "createShippingLabel",
    parameters: %{
      "addressId" => "$response.body#/addressId"
    },
    requestBody: %{
      "weight" => 10,
      "priority" => "STANDARD"
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.Server

  @type t :: %__MODULE__{
          operationRef: String.t() | nil,
          operationId: String.t() | nil,
          parameters: %{optional(String.t()) => any()} | nil,
          requestBody: any() | nil,
          description: String.t() | nil,
          server: Server.t() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :operationRef,
    :operationId,
    :parameters,
    :requestBody,
    :description,
    :server,
    extensions: %{}
  ]
end
