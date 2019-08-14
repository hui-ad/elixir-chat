defmodule ChatApp.SocketBroadcaster do
  require Logger
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: :socket_broadcaster)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_cast({:accepted, socket}, sockets) do
    {:noreply, [socket | sockets]}
  end

  def handle_cast({:disconnect, socket}, sockets) do

    {:noreply, filter_out(sockets, socket)}
  end

  def handle_cast({:broadcast, sender, message}, sockets) do
    Logger.info "Broadcasting: #{message}"

    # TODO: I tried using Stream here, but it wasn't working
    filter_out(sockets, sender)
    |> Enum.each(fn socket -> :gen_tcp.send(socket, message) end)

    {:noreply, sockets}
  end

  defp filter_out(sockets, socket) do
    Enum.filter(sockets, fn s ->
      cond do
        s == socket -> false
        true -> true
      end
    end)
  end

end