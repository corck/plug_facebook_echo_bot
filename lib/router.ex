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
    %{ "height" => height } = conn.params

    {h, _} = Float.parse(height)
    Logger.info(inspect(h))
    broadcast(h)

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

  def broadcast(height) when is_float(height) and height > 3.5 do
    message = "Die Furt ist gesperrt"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "NO_PUSH")
  end

  def broadcast(height) when is_float(height) and height > 3.0 do
    message = "Die Furt wird bald geschlossen sein"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "NO_PUSH")
  end

  def broadcast(height) when is_float(height) and height < 3.0 do
    message = "Die Furt wird bald wieder offen sein"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "NO_PUSH")
  end

  def broadcast(height) do
    message = "Die Furt hat einen Höhenstand von #{inspect(height)}"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "NO_PUSH")
  end
end
