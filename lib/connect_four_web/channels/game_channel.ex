defmodule ConnectFourWeb.GamesChannel do
  use ConnectFourWeb, :channel

  alias ConnectFour.GameServer
  alias ConnectFour.Game


  def join("games:" <> game, %{"user" => user}, socket) do
      GameServer.start_link(game)
      socket = assign(socket, :game, game)
      |> assign(:user, user)
      GameServer.add_user(game,"player",user)

      view = GameServer.view(game, socket.assigns[:user])
      {:ok, %{"join" => game, "game" => view}, socket}

  end


  def handle_in("move", %{"index" => index}, socket) do
      IO.puts("in handle move")
      IO.puts(index)
      IO.puts(socket.assigns[:user])
      view = GameServer.move(socket.assigns[:game], index, socket.assigns[:user])
      {:reply, {:ok, %{ "game" => view}}, socket}
  end

  def handle_in("add_user", %{"user" => user}, socket) do
      view = GameServer.add_user(socket.assigns[:game], "player", socket.assigns[:user])
      {:reply, {:ok, %{ "game" => view}}, socket}
  end

  def handle_in("remove_user", %{"user" => user}, socket) do
      view = GameServer.remove_user(socket.assigns[:game], "player", socket.assigns[:user])
      {:reply, {:ok, %{ "game" => view}}, socket}
  end

  # def handle_in("restart", payload, socket) do
  #     name = socket.assign[:name]
  #     game = Game.new()
  #     socket = assign(socket, :game, game)
  #     view = GameServer.view(game, socket.assign[:user])
  #     |> assign(:user, user)
  #     {:reply, {:ok, %{"game" => view}}, socket}
  # end



end
