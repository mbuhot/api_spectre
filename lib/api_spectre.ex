defmodule ApiSpectre do
  @moduledoc """
  TODO:
   - Functions for building a complete OpenAPI Description from routes
  """
  alias ApiSpectre.OpenApi.Operation
  alias ApiSpectre.OpenApi.PathItem
  @spec add_router(ApiSpectre.OpenApi.t(), module()) :: ApiSpectre.OpenApi.t()
  def add_router(%ApiSpectre.OpenApi{} = api, router) do
    add_routes(api, router.__routes__())
  end

  @spec add_routes(ApiSpectre.OpenApi.t(), list()) :: ApiSpectre.OpenApi.t()
  def add_routes(%ApiSpectre.OpenApi{} = api, routes) do
    paths =
      routes
      |> Enum.group_by(fn route -> route.path end)
      |> Enum.flat_map(fn {path, route_group} ->
        case make_path_item(route_group) do
          {:ok, %PathItem{} = path_item} -> [{open_api_path(path), path_item}]
          _ -> []
        end
      end)
      |> Map.new()

    put_in(api.paths, Map.merge(api.paths, paths))
  end

  @spec add_schemas(ApiSpectre.OpenApi.t(), map()) :: ApiSpectre.OpenApi.t()
  def add_schemas(%ApiSpectre.OpenApi{} = api, extra_schemas) do
    schemas = get_in(api.components.schemas) || %{}
    schemas = Map.merge(schemas, extra_schemas)
    put_in(api.components.schemas, schemas)
  end

  def make_path_item(route_group) do
    Enum.each(route_group, fn route ->
      Code.ensure_loaded(route.plug)
    end)

    route_group
    |> Enum.filter(&function_exported?(&1.plug, :open_api_operation, 1))
    |> case do
      [] ->
        {:error, :no_operations}

      valid_routes ->
        valid_routes
        |> Enum.flat_map(fn route ->
          case make_operation(route) do
            %Operation{} = op -> [{route.verb, op}]
            _ -> []
          end
        end)
        |> case do
          [] -> {:error, :no_operations}
          attrs -> {:ok, struct!(PathItem, attrs)}
        end
    end
  end

  def make_operation(route) do
    route.plug.open_api_operation(route.plug_opts)
  end

  @spec open_api_path(String.t()) :: String.t()
  defp open_api_path(path) do
    path
    |> String.split("/")
    |> Enum.map_join("/", fn
      ":" <> segment -> "{#{segment}}"
      segment -> segment
    end)
  end
end
