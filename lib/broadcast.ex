defmodule Sample.Broadcast do
  def broadcast(message, notification_type \\ "NO_PUSH") do
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", notification_type)
  end
end
