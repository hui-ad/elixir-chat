defmodule ChatApp.SocketConnection do
  require Logger
  use GenServer

  def start_link(listening_socket) do
    GenServer.start_link(__MODULE__, listening_socket)
  end

  def init(listening_socket) do
    {:ok, socket} = :gen_tcp.accept(listening_socket)
    Logger.info "Client connected!"
    :gen_tcp.send(socket, "Connected!\n")

    GenServer.cast(:socket_broadcaster, {:accepted, socket})
    GenServer.cast(:socket_coordinator, {:listener_ready, listening_socket})

    {:ok, socket}
  end

  def handle_info({:tcp, socket, message}, socket) do
    GenServer.cast(:socket_broadcaster, {:broadcast, socket, message})

    {:noreply, socket}
  end

  def handle_info({:tcp_closed, socket}, state) do
    GenServer.cast(:socket_broadcaster, {:disconnect, socket})
    Logger.info "Client disconnected!"

    {:stop, :normal, state}
  end

  def handle_info({:tcp_error, socket}, state) do
    Logger.info "Client disconnected!"
    GenServer.cast(:socket_broadcaster, {:disconnect, socket})

    {:stop, :normal, state}
  end
end