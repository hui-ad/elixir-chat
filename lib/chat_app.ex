defmodule ChatApp do
  use Application

  def start(_type, _args) do
    ChatApp.Supervisor.start_link
  end
end
