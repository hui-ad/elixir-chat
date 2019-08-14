defmodule ChatApp do
  use Application

  def start(_type, _args) do
    port = Application.get_env(:chat_app, :port)

    ChatApp.Supervisor.start_link(port)
  end
end
