defmodule ApiSpectre.OpenApi.Operation do
  @moduledoc """
  Represents the Operation Object from the OpenAPI 3.1.1 specification (section 4.8.10).

  The Operation Object describes a single API operation on a path.

  ## Fields

  * `tags` - List of strings. A list of tags for API documentation control. Tags can be used for logical
    grouping of operations by resources or any other qualifier.

  * `summary` - String. A short summary of what the operation does.

  * `description` - String. A verbose explanation of the operation behavior.
    CommonMark syntax MAY be used for rich text representation.

  * `externalDocs` - External Documentation Object. Additional external documentation for this operation.

  * `operationId` - String. Unique string used to identify the operation. The id MUST be unique among
    all operations described in the API. The operationId value is case-sensitive.

  * `parameters` - List of Parameter Objects or Reference Objects. A list of parameters that are applicable
    for this operation. If a parameter is already defined at the Path Item level, the new definition will
    override it but can never remove it. The list MUST NOT include duplicated parameters.

  * `requestBody` - Request Body Object or Reference Object. The request body applicable for this operation.

  * `responses` - Responses Object. The list of possible responses as they are returned from executing
    this operation. REQUIRED.

  * `callbacks` - Map[string, Callback Object | Reference Object]. A map of possible out-of-band callbacks
    related to the parent operation. The key is a unique identifier for the Callback Object.

  * `deprecated` - Boolean. Declares this operation to be deprecated. Consumers SHOULD refrain from using
    the declared operation. Default value is false.

  * `security` - List of Security Requirement Objects. A declaration of which security mechanisms
    can be used for this operation. The list of values includes alternative security requirement objects
    that can be used. Only one of the security requirement objects need to be satisfied to authorize a request.

  * `servers` - List of Server Objects. An alternative servers array to service this operation. If a servers
    array is specified at the Path Item or OpenAPI Object level, it will be overridden by this value.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.Operation{
    tags: ["pet"],
    summary: "Updates a pet in the store with form data",
    operationId: "updatePetWithForm",
    parameters: [
      %ApiSpectre.OpenApi.Parameter{
        name: "petId",
        in: "path",
        description: "ID of pet that needs to be updated",
        required: true,
        schema: %{
          type: "string"
        }
      }
    ],
    requestBody: %ApiSpectre.OpenApi.RequestBody{
      content: %{
        "application/x-www-form-urlencoded": %{
          schema: %{
            type: "object",
            properties: %{
              name: %{
                description: "Updated name of the pet",
                type: "string"
              },
              status: %{
                description: "Updated status of the pet",
                type: "string"
              }
            },
            required: ["status"]
          }
        }
      }
    },
    responses: %{
      "200" => %ApiSpectre.OpenApi.Response{
        description: "Pet updated.",
        content: %{
          "application/json": %ApiSpectre.OpenApi.MediaType{},
          "application/xml": %ApiSpectre.OpenApi.MediaType{}
        }
      },
      "405" => %ApiSpectre.OpenApi.Response{
        description: "Method Not Allowed",
        content: %{
          "application/json": %ApiSpectre.OpenApi.MediaType{},
          "application/xml": %ApiSpectre.OpenApi.MediaType{}
        }
      }
    },
    security: [
      %{
        "petstore_auth": [
          "write:pets",
          "read:pets"
        ]
      }
    ]
  }
  ```
  """

  alias ApiSpectre.OpenApi.{
    Callback,
    ExternalDocs,
    Parameter,
    Reference,
    RequestBody,
    Responses,
    SecurityRequirement,
    Server
  }

  @type t :: %__MODULE__{
          tags: [String.t()] | nil,
          summary: String.t() | nil,
          description: String.t() | nil,
          externalDocs: ExternalDocs.t() | nil,
          operationId: String.t() | nil,
          parameters: [Parameter.t() | Reference.t()] | nil,
          requestBody: RequestBody.t() | Reference.t() | nil,
          responses: Responses.t(),
          callbacks: %{optional(String.t()) => Callback.t() | Reference.t()} | nil,
          deprecated: boolean() | nil,
          security: [SecurityRequirement.t()] | nil,
          servers: [Server.t()] | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :tags,
    :summary,
    :description,
    :externalDocs,
    :operationId,
    :parameters,
    :requestBody,
    :responses,
    :callbacks,
    :deprecated,
    :security,
    :servers,
    extensions: %{}
  ]
end
