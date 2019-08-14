defmodule ChatApp.SocketCoordinator do
  require Logger
  use GenServer

  @me __MODULE__

  def start_link do
    GenServer.start_link(__MODULE__, [], name: @me)
  end

  def init(_) do
    {:ok, []}
  end

  ### Client API

  def listener_ready(listening_socket) do
    GenServer.cast(@me, {:listener_ready, listening_socket})
  end

  ### Server callbacks

  def handle_cast({:listener_ready, listening_socket}, state) do
    ChatApp.SocketSupervisor.accept_listening_socket(listening_socket)

    {:noreply, state}
  end
end
