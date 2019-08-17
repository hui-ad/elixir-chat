defmodule ChatApp do
  use Application

  def start(_type, _args) do
    port = Application.get_env(:chat_app, :port)

    children = [
      ChatApp.SocketCoordinator,
      ChatApp.SocketSupervisor,
      ChatApp.SocketBroadcaster,
      {ChatApp.Server, port}
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
