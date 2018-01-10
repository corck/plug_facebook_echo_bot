defmodule Sample.Router do
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
    %{ "message" => message } = conn.params
    recipient_id = "1629070620483444" # hard coded recipient id
    FacebookMessenger.Sender.send(recipient_id, message)
    send_resp(conn, 200, "Sent message #{message}")
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
