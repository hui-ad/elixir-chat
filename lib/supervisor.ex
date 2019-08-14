defmodule ChatApp.Supervisor do
  require Logger
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      worker(ChatApp.SocketCoordinator, []),
      supervisor(ChatApp.SocketSupervisor, []),
      worker(ChatApp.SocketBroadcaster, []),
      worker(ChatApp.Server, [])
    ]

    supervise(children, strategy: :one_for_one)
   end
end