defmodule ChatApp do
  use Application

  def start(_type, _args) do
    ChatApp.Supervisor.start_link

    # TODO: idk where to put this to dynamically spawn processes 
    listening_socket = :sys.get_state(:chat_server)
    ChatApp.SocketSupervisor.accept_listening_socket(listening_socket)
    ChatApp.SocketSupervisor.accept_listening_socket(listening_socket)
  end
end
