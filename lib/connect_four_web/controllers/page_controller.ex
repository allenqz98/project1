defmodule ConnectFourWeb.PageController do
  use ConnectFourWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def game_form(conn,  %{"user" => user, "game" => game}) do
  conn
  |> put_session(:user, user)
  |> redirect(to: "/game/#{game}")
end


def game(conn, params) do
  user = get_session(conn, :user)
  if user do
    render conn, "game.html", game: params["game"], user: user
  else
    conn
    |> put_flash(:error, "Must pick a username")
    |> redirect(to: "/")
  end
end




end
