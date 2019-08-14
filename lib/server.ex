defmodule ChatApp.Server do
  require Logger
  use GenServer

  def start_link(port) do
    GenServer.start_link(__MODULE__, port, name: __MODULE__)
  end

  def init(port) do
    IO.inspect(port, label: "ChatApp.Server trying to listen on port")
    {:ok, listening_socket} = :gen_tcp.listen(port, [:binary, active: true, reuseaddr: true])
    Logger.info("Accepting connections on port #{port}...")

    ChatApp.SocketCoordinator.listener_ready(listening_socket)

    {:ok, listening_socket}
  end
end
