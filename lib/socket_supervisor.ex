defmodule ChatApp.SocketSupervisor do
  require Logger

  use DynamicSupervisor

  def start_link do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def accept_listening_socket(socket) do
    spec = {ChatApp.SocketConnection, socket}

    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end