defmodule ChatApp.Server do
  require Logger
  use GenServer

  @port 8000

  def start_link do
    GenServer.start_link(__MODULE__, @port, name: :chat_server)
  end

  def init(port) do
    {:ok, listening_socket} = :gen_tcp.listen(port, [:binary, active: true])
    Logger.info "Accepting connections on port #{port}..."

    {:ok, listening_socket}
  end
end