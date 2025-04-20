defimpl Jason.Encoder,
  for: [
    ApiSpectre.OpenApi,
    ApiSpectre.OpenApi.Components,
    ApiSpectre.OpenApi.Contact,
    ApiSpectre.OpenApi.Example,
    ApiSpectre.OpenApi.ExternalDocs,
    ApiSpectre.OpenApi.Header,
    ApiSpectre.OpenApi.Info,
    ApiSpectre.OpenApi.License,
    ApiSpectre.OpenApi.Link,
    ApiSpectre.OpenApi.MediaType,
    ApiSpectre.OpenApi.OAuthFlow,
    ApiSpectre.OpenApi.OAuthFlows,
    ApiSpectre.OpenApi.Operation,
    ApiSpectre.OpenApi.Parameter,
    ApiSpectre.OpenApi.PathItem,
    ApiSpectre.OpenApi.RequestBody,
    ApiSpectre.OpenApi.Response,
    ApiSpectre.OpenApi.SecurityScheme,
    ApiSpectre.OpenApi.Server,
    ApiSpectre.OpenApi.ServerVariable,
    ApiSpectre.OpenApi.Tag,
    ApiSpectre.OpenApi.Xml
  ] do
  def encode(value, opts) do
    value
    |> Map.from_struct()
    |> Map.pop(:extensions)
    |> then(fn {extensions, m} -> Map.merge(m, extensions || %{}) end)
    |> Map.filter(fn {_k, v} -> v != nil end)
    |> Jason.Encode.map(opts)
  end
end
