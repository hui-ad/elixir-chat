# ChatApp

To run this code first:
* Install elixir 1.9 (asdf recommended, but note that erlang will take 15+ minutes to install)
  * https://asdf-vm.com/#/core-manage-asdf-vm
  * https://github.com/asdf-vm/asdf-erlang/
  * https://github.com/asdf-vm/asdf-elixir/
* Install netcat
  * https://linoxide.com/linux-how-to/install-use-netcat-command-linux/
  * https://joncraton.org/blog/46/netcat-for-windows/

Then clone this repository and run these commands in your terminal from within the directory of this repository:
```
mix deps.get
iex -S mix
```

In another terminal:
```
nc 127.0.0.1 8000   # nc is the netcat command line program
# type "hi" and press enter
```

In yet another terminal:
```
nc 127.0.0.1 8000   # nc is the netcat command line program
# type "I see you" and press enter
```

You should see in the server's terminal that both "hi" and "I see you" were broadcast, also in the second terminal you should see "I see you" even though you typed that into the third terminal.
