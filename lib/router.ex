defmodule Sample.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  forward "/messenger/webhook", to: FacebookMessenger.Router
  match _, do: send_resp(conn, 500, "error")
end
