{application,chat_app,
             [{applications,[kernel,stdlib,elixir,logger,observer]},
              {description,"chat_app"},
              {modules,['Elixir.ChatApp','Elixir.ChatApp.Server',
                        'Elixir.ChatApp.SocketBroadcaster',
                        'Elixir.ChatApp.SocketConnection',
                        'Elixir.ChatApp.SocketCoordinator',
                        'Elixir.ChatApp.SocketSupervisor']},
              {registered,[]},
              {vsn,"0.1.0"},
              {mod,{'Elixir.ChatApp',[]}}]}.