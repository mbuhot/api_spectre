defmodule ApiSpectre.OpenApi.Xml do
  @moduledoc """
  Represents the XML Object from the OpenAPI 3.1.1 specification (section 4.8.26).

  The XML Object allows for additional customization of XML model generation by providing
  details of XML namespaces, attribute/element names, and prefixes.

  ## Fields

  * `name` - String. Replaces the name of the element/attribute used for the described schema property.
    When defined within `items`, it will affect the name of the individual XML elements within the list.
    When defined alongside `type="array"`, it will affect the wrapping element and only if `wrapped` is true.
    If `wrapped` is false, it will be ignored.

  * `namespace` - String. The URL of the namespace definition. Value MUST be in the form of a URL.

  * `prefix` - String. The prefix to be used for the name.

  * `attribute` - Boolean. Declares whether the property definition translates to an attribute
    instead of an element. Default value is false.

  * `wrapped` - Boolean. MAY be used only for an array definition. Signifies whether the array
    is wrapped (for example, `<books><book/><book/></books>`) or unwrapped (`<book/><book/>`).
    Default value is false. The definition takes effect only when defined alongside `type="array"`.

  * `extensions` - Map of custom extensions. The keys MUST begin with 'x-'.

  ## Example

  ```elixir
  %ApiSpectre.OpenApi.Xml{
    name: "animal",
    namespace: "http://example.com/schema/sample",
    prefix: "sample",
    attribute: false,
    wrapped: false
  }
  ```

  XML object which extends a string property to include an XML attribute:

  ```elixir
  %{
    type: "string",
    xml: %ApiSpectre.OpenApi.Xml{
      name: "text",
      attribute: true
    }
  }
  ```

  XML that wraps an array:

  ```elixir
  %{
    type: "array",
    items: %{
      type: "string"
    },
    xml: %ApiSpectre.OpenApi.Xml{
      name: "animals",
      wrapped: true
    }
  }
  ```

  XML with namespace:

  ```elixir
  %{
    type: "string",
    xml: %ApiSpectre.OpenApi.Xml{
      name: "text",
      namespace: "http://example.com/schema",
      prefix: "ex"
    }
  }
  ```
  """

  @type t :: %__MODULE__{
          name: String.t() | nil,
          namespace: String.t() | nil,
          prefix: String.t() | nil,
          attribute: boolean() | nil,
          wrapped: boolean() | nil,
          extensions: %{optional(String.t()) => any()} | nil
        }

  defstruct [
    :name,
    :namespace,
    :prefix,
    :attribute,
    :wrapped,
    extensions: %{}
  ]
end