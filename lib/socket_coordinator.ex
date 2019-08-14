defmodule ChatApp.SocketCoordinator do
  require Logger
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :socket_coordinator)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_cast({:listener_ready, listening_socket}, state) do
    ChatApp.SocketSupervisor.accept_listening_socket(listening_socket)

    {:noreply, state}
  end

end