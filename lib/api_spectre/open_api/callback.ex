defmodule ApiSpectre.OpenApi.Callback do
  @moduledoc """
  Represents the Callback Object from the OpenAPI 3.1.1 specification (section 4.8.18).

  A map of possible out-of-band callbacks related to the parent operation. Each value in the map is a
  Path Item Object that describes a set of requests that may be initiated by the API provider and the
  expected responses. The key value used to identify the Path Item Object is a runtime expression
  that identifies a URL to use for the callback operation.

  ## Runtime Expressions as Keys

  The key that identifies the Path Item Object is a runtime expression that can be evaluated
  in the context of a runtime HTTP request/response to identify the URL to be used for the callback request.

  A runtime expression is defined as follows:

  - It must start with `$`
  - It can reference parts of the HTTP message using JSONPath-like expressions:
      - `$request.body#/url` references body property "url"
      - `$request.path.eventType` references path parameter "eventType"
      - `$request.query.queryUrl` references query parameter "queryUrl"
      - `$request.header.content-type` references header "Content-Type"

  ## Example

  ```elixir
  %{
    # Callback triggered on event, with URL provided in the request body
    "$request.body#/url" => %ApiSpectre.OpenApi.PathItem{
      post: %ApiSpectre.OpenApi.Operation{
        requestBody: %ApiSpectre.OpenApi.RequestBody{
          description: "Callback payload",
          content: %{
            "application/json" => %ApiSpectre.OpenApi.MediaType{
              schema: %{
                "$ref" => "#/components/schemas/CallbackPayload"
              }
            }
          }
        },
        responses: %{
          "200" => %ApiSpectre.OpenApi.Response{
            description: "Callback processed successfully"
          }
        }
      }
    },

    # Alternative URL using a query parameter for the callback
    "$request.query.url" => %ApiSpectre.OpenApi.PathItem{
      post: %ApiSpectre.OpenApi.Operation{
        responses: %{
          "200" => %ApiSpectre.OpenApi.Response{
            description: "Callback processed successfully"
          }
        }
      }
    },

    # Hard-coded URL with dynamic parameters from the request body
    "http://notificationServer.com?transactionId={$request.body#/id}&email={$request.body#/email}" => %ApiSpectre.OpenApi.PathItem{
      post: %ApiSpectre.OpenApi.Operation{
        requestBody: %ApiSpectre.OpenApi.RequestBody{
          description: "Callback payload",
          content: %{
            "application/json" => %ApiSpectre.OpenApi.MediaType{
              schema: %{
                "$ref" => "#/components/schemas/SomePayload"
              }
            }
          }
        },
        responses: %{
          "200" => %ApiSpectre.OpenApi.Response{
            description: "Callback successfully processed"
          }
        }
      }
    }
  }
  ```
  """

  alias ApiSpectre.OpenApi.{PathItem, Reference}

  @type t :: %{optional(String.t()) => PathItem.t() | Reference.t()}
end
