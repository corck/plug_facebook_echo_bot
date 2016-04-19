defmodule Sample.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  forward "/messenger/webhook",
    to: FacebookMessenger.Router,
    message_received: &Sample.Router.message/1

  match _, do: send_resp(conn, 500, "error")

  def message(msg) do
    text = FacebookMessenger.Response.message_texts(msg) |> hd
    sender = FacebookMessenger.Response.message_senders(msg) |> hd
    FacebookMessenger.Sender.send(sender, text)
    send(self, 3)
  end
end
