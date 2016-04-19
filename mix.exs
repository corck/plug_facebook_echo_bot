defmodule Sample.Mixfile do
  use Mix.Project

  def project do
    [app: :plug_sample,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :plug, :cowboy, :facebook_messenger],
     mod: {Sample.Server, []}]
  end

  defp deps do
    [{:facebook_messenger, ">= 0.2.0", github: "oarrabi/ExFacebook-Messenger"},
     {:plug, "> 0.0.0"},
     {:cowboy, "> 0.0.0"}]
  end
end
