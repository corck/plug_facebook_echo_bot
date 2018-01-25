defmodule Sample.Broadcast do
  def broadcast(height) when is_number(height) and height == 0 do
    message = "Flascher Wert Höhe #{0}"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "REGULAR")
  end

  def broadcast(height) when is_number(height) and height > 3.5 do
    message = "Die Furt ist gesperrt. Höhe: #{inspect height}"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "REGULAR")
  end

  def broadcast(height) when is_number(height) and height > 3.0 do
    message = "Die Furt wird bald geschlossen sein"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "NO_PUSH")
  end

  def broadcast(height) when is_number(height) and height < 3.0 do
    message = "Die Furt wird bald wieder offen sein"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "NO_PUSH")
  end

  def broadcast(height) do
    message = "Die Furt hat einen Höhenstand von #{inspect(height)}"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "NO_PUSH")
  end

  def broadcast(message, notification_type \\ "NO_PUSH") do
    IO.puts(message)
#    FacebookMesse+nger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", notification_type)
  end
end
