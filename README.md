# Elixir load test

A simple test that I've ran on my computer
to showcase the way Elixir/Erlang handles balance.

There's two parts on this, one is a Phoenix application
which accepts requests on some endpoints 
(consult `router.ex` for details), two is a nodejs script
which sends concurrent request to the Phenios server.

Play with the `interval` variable or remove it all
together.

## In order to use start the Phoenix server run the following

- `mix deps.get`
- `mix phx.server`

## In order to use start the nodejs script run the following

- yarn
- node src/

