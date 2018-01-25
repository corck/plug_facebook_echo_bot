defmodule Sample.Waterlevel do
  require IEx
  use GenServer
  require Logger
  alias __MODULE__
  defstruct waterlevel: 0,
            state: :initialized

  def new(), do: %Waterlevel{}

  def start_link(state \\ []), do:
    GenServer.start_link(__MODULE__, state, name: __MODULE__)

  def init(name) do
    {:ok, %{waterlevel: 0, state: :initialized}}
  end

  def new_height(height) do
    GenServer.call(__MODULE__, {:new_height, height})
  end

  def handle_call({:new_height, height}, _from, state_data) do
    state_data
    |> check(height)
    |> IO.inspect(label: "data")
    |> reply_success(:ok)
  end

  def demo_cast(pid, new_value) do
    GenServer.cast(pid, {:demo_cast, new_value})
  end

  # flodded && alarm sent already
  def check(%{state: :flodded} = state_data, height) when height > 3.5 do
    %{state_data | state: :flodded, waterlevel: height}
  end

  # flodded
  def check(%{state: :warned} = state_data, height) when height > 3.5 do
    message = "Die Furt ist gesperrt. Höhe: #{inspect height}"
    Sample.Broadcast.broadcast(message, "REGULAR")
    %{state_data | state: :flodded, waterlevel: height}
  end

  # not flodded anymore
  def check(%{state: :flodded} = state_data, height) when height < 3.0 do
    message = "Die Furt wird wahrscheinlich bald wieder offen sein. Höhe: #{inspect height}"
    Sample.Broadcast.broadcast(message, "REGULAR")
    %{state_data | state: :open, waterlevel: height}
  end

  # soon flodded, already sent
  def check(%{state: :warned} = state_data, height) when height > 3.0 do
    %{state_data | state: :warned, waterlevel: height}
  end

  # notify soon flodded
  def check(%{state: :normal} = state_data, height) when height >= 3.0 do
    message = "Die Furt wird bald geschlossen sein"
    Sample.Broadcast.broadcast(message, "REGULAR")
    %{state_data | state: :warned, waterlevel: height}
  end

  # normal level
  def check(%{state: _} = state_data, height) when height < 3.0 do
    %{state_data | state: :normal, waterlevel: height}
  end

  def check(state, _action) do
    IO.puts("Error #{state}")
    state
  end

  defp reply_success(state_data, reply), do: {:reply, reply, state_data}

  defp update_height(state_data, height) do
    put_in(state_data.waterlevel, height)
  end
end
