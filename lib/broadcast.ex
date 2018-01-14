defmodule Sample.Broadcast do
  def broadcast(height) when is_float(height) and height > 3.5 do
    message = "Die Furt ist gesperrt. Höhe: #{inspect height}"
    FacebookMessenger.Sender.text_broadcast(message, "TRANSPORTATION_UPDATE", "REGULAR")
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

