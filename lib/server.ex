defmodule Sample.Server do
  use Application

  def start(_type, _args) do
    port = System.get_env("PORT") |> String.to_integer || 8080
    IO.puts "Port assigned to #{port}"

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Sample.Router, [], port: port)
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
