defmodule ChatApp.SocketBroadcaster do
  require Logger
  use GenServer

  @me __MODULE__

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: @me)
  end

  def init(_) do
    {:ok, []}
  end

  ### Client API

  def accepted(socket) do
    GenServer.cast(@me, {:accepted, socket})
  end

  def broadcast(socket, message) do
    GenServer.cast(@me, {:broadcast, socket, message})
  end

  def disconnect(socket) do
    GenServer.cast(@me, {:disconnect, socket})
  end

  ### Server callbacks

  def handle_cast({:accepted, socket}, sockets) do
    {:noreply, [socket | sockets]}
  end

  def handle_cast({:disconnect, socket}, sockets) do
    {:noreply, filter_out(sockets, socket)}
  end

  def handle_cast({:broadcast, sender, message}, sockets) do
    Logger.info("Broadcasting: #{message}")

    filter_out(sockets, sender)
    |> Enum.each(fn socket -> :gen_tcp.send(socket, message) end)

    {:noreply, sockets}
  end

  defp filter_out(sockets, socket) do
    Enum.reject(sockets, fn s -> s == socket end)
  end
end
