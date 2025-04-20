defmodule ApiSpectre.Mixfile do
  use Mix.Project

  @source_url "https://github.com/mbuhot/api_spectre"
  @version "0.1.0"

  def project do
    [
      app: :api_spectre,
      version: @version,
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      consolidate_protocols: Mix.env() != :test,
      package: package(),
      deps: deps(),
      docs: docs(),
      dialyzer: dialyzer()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application, do: [extra_applications: []]

  defp package() do
    [
      name: "api_spectre",
      description: "OpenAPI (3.1) Descriptions for Plug and Phoenix applications.",
      files: [
        "lib",
        "mix.exs",
        "README.md",
        "LICENSE",
        "CHANGELOG.md"
      ],
      maintainers: [
        "Mike Buhot (m.buhot@gmail.com)"
      ],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/api_spectre/changelog.html",
        "GitHub" => @source_url
      }
    ]
  end

  defp deps do
    [
      {:credo, ">= 0.0.0", only: [:dev], runtime: false},
      {:dialyxir, ">= 0.0.0", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:jason, ">= 0.0.0"},
      {:jsv, "~> 0.6.3"},
      {:plug, ">= 0.0.0"}
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md",
        {:LICENSE, [title: "License"]},
        "README.md"
      ],
      main: "readme",
      logo: "api_spectre_logo.png",
      homepage_url: @source_url,
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"],
      groups_for_modules: [
        "Describing your API": [
          ApiSpectre.OpenApi,
          ApiSpectre.OpenApi.Callback,
          ApiSpectre.OpenApi.Components,
          ApiSpectre.OpenApi.Contact,
          ApiSpectre.OpenApi.Encoding,
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
          ApiSpectre.OpenApi.Paths,
          ApiSpectre.OpenApi.Reference,
          ApiSpectre.OpenApi.RequestBody,
          ApiSpectre.OpenApi.Response,
          ApiSpectre.OpenApi.Responses,
          ApiSpectre.OpenApi.SecurityRequirement,
          ApiSpectre.OpenApi.SecurityScheme,
          ApiSpectre.OpenApi.ServerVariable,
          ApiSpectre.OpenApi.Server,
          ApiSpectre.OpenApi.Tag,
          ApiSpectre.OpenApi.Xml
        ],
        "Integration with Phoenix": [ApiSpectre]
      ],
      nest_modules_by_prefix: [ApiSpectre.OpenApi]
    ]
  end

  defp dialyzer do
    [
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end
end
