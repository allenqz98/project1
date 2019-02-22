defmodule ConnectFour.GameServer do
  use GenServer

  def reg(name) do
    {:via, Registry, {ConnectFour.GameReg, name}}
  end

  def start(name) do
    spec = %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [name]},
      restart: :permanent,
      type: :worker,
    }
    ConnectFour.GameSup.start_child(spec)
  end

  def start_link(name) do
    game = ConnectFour.Game.new()
    GenServer.start_link(__MODULE__, game, name: reg(name))
  end

  def view(name, user) do
    GenServer.call(reg(name), {:view, name, user})
  end

  def add_user(name, "player", user) do
    GenServer.call(reg(name), {:add_user, name, user})
  end

  def remove_user(name, "player", user) do
    GenServer.call(reg(name), {:remove_user, name, user})
  end

  def move(name, user, index) do
    GenServer.call(reg(name), {:move, user, index})
  end

  def init(name) do
    {:ok, name}
  end

  def handle_call({:view, name, user}, _from, game) do
    game = ConnectFour.Game.client_view(game)
    {:reply, game, game}
  end

  def handle_call({:add_user, name, user}, _from, game) do
    game = ConnectFour.Game.add_user(game, user)
    {:reply, game, game}
  end

  def handle_call({:remove_user, name, user}, _from, game) do
    game = ConnectFour.Game.remove_user(game, user)
    {:reply, game, game}
  end

  def handle_call({:move, user, index}, _from, game) do
    game = ConnectFour.Game.move(game, index, user)
    {:reply, game, game}
  end
end
