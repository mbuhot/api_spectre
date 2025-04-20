defmodule ApiSpectre.OpenApi.Reference do
  @moduledoc """
  Represents the Reference Object from the OpenAPI 3.1.1 specification (section 4.8.23).

  A simple object to allow referencing other components in the OpenAPI document, internally and externally.

  The Reference Object is defined by JSON Schema and follows the same structure, behavior and rules.
  For OpenAPI, the Reference Object contains a pointer to a different location in the same document
  or to an external document or resource.

  ## Fields

  * `$ref` - String. REQUIRED. The reference string.

  * `summary` - String. A short summary which by default SHOULD override that of the referenced component.
    If the referenced object-type does not allow a summary field, then this field has no effect.

  * `description` - String. A description which by default SHOULD override that of the referenced component.
    CommonMark syntax MAY be used for rich text representation. If the referenced object-type
    does not allow a description field, then this field has no effect.

  ## Examples

  ```elixir
  # Reference to a component in the same document
  %ApiSpectre.OpenApi.Reference{
    "$ref": "#/components/schemas/Pet"
  }

  # Reference with overriding summary and description
  %ApiSpectre.OpenApi.Reference{
    "$ref": "#/components/schemas/User",
    "summary": "User account information",
    "description": "Detailed user account information including contact details."
  }

  # Reference to an external document
  %ApiSpectre.OpenApi.Reference{
    "$ref": "https://gigantic-server.com/schemas/Monster/schema.json"
  }

  # Reference to a local file
  %ApiSpectre.OpenApi.Reference{
    "$ref": "./common.json#/components/schemas/Error"
  }
  ```

  ## Relative References and Document Structure

  Relative references, including those in `$ref` values, are resolved based on the location of
  the document containing the reference. This OpenAPI specification does not specify the behavior
  of references that use URI fragments which are not JSON Pointers.

  ### Examples of Valid References:
  - `#/components/schemas/Pet` - Reference to a local component
  - `../common.yaml#/components/schemas/Pet` - Reference to another file relative to current file
  - `https://example.com/schemas/customer.json#/components/schemas/Address` - Reference to external document

  ### JSON Schema Compatibility
  The Reference Object is compatible with JSON Schema's Reference Object. It can be used to reference
  schemas in the components section or in external files.
  """

  @type t :: %{
          :"$ref" => String.t(),
          optional(:summary) => String.t(),
          optional(:description) => String.t()
        }

  @doc """
  Creates a new Reference object with the specified reference string.

  ## Parameters

  * `ref` - String. The reference string, e.g., "#/components/schemas/Pet".
  * `opts` - Keyword list of options.
    * `:summary` - Optional summary that overrides the referenced component's summary.
    * `:description` - Optional description that overrides the referenced component's description.

  ## Examples

      iex> Reference.new("#/components/schemas/Pet")
      %{:"$ref" => "#/components/schemas/Pet"}

      iex> Reference.new("./common.json#/components/schemas/Error",
      ...>   summary: "Error object",
      ...>   description: "Standard error response")
      %{:"$ref" => "./common.json#/components/schemas/Error",
        :summary => "Error object",
        :description => "Standard error response"}
  """
  def new(ref, opts \\ []) do
    result = %{:"$ref" => ref}

    result =
      if summary = Keyword.get(opts, :summary) do
        Map.put(result, :summary, summary)
      else
        result
      end

    if description = Keyword.get(opts, :description) do
      Map.put(result, :description, description)
    else
      result
    end
  end
end
