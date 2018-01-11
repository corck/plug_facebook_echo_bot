defmodule Sample.Router do
  alias Sample.{Broadcast}
  import Plug.Conn
  use Plug.Router
  require Logger

  plug Plug.Logger, log: :debug
  plug :match
  plug :dispatch

  forward "/webhook",
    to: FacebookMessenger.Router,
    message_received: &Sample.Router.message/1

  get("/broadcast") do
    conn = fetch_query_params(conn) # get parameters
    %{ "height" => height } = conn.params

    {h, _} = Float.parse(height)

    Broadcast.broadcast(h)

    send_resp(conn, 200, "Sent message")
  end

  match _, do: send_resp(conn, 500, "error")

  def message(msg) do
    text = FacebookMessenger.Response.message_texts(msg) |> hd
    sender = FacebookMessenger.Response.message_senders(msg) |> hd
    Logger.info(sender)
    FacebookMessenger.Sender.send(sender, text)
    send(self, 3)
  end
end
