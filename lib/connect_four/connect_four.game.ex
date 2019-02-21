defmodule ConnectFour.Game do

  def new do
    %{
      players: [],
      cur_player: 1,
      finished: 0,
      board: Enum.chunk([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],7),
    }
  end


  def client_view(game) do
    %{
      players: [],
      cur_player: game.cur_player,
      finished: game.finished,
      board: game.board,
    }
  end

  def add_user(game, user) do
    players = game.players
    cond do
      length(players) == 0 -> players = [1, user]
      Enum.at(Enum.at(players, 0),0) == 1 -> Map.put(game, :players, players ++ [2, user])
      Enum.at(Enum.at(players, 0),0) == 2 -> Map.put(game, :players, players ++ [1, user])
    end
  end


  def remove_user(game, user) do
    Enum.filter(game.players, fn [num, user_name] -> user == user_name end)

  end


  def move(game, index, player) do
    player_num = get_player_num(game, player)
    x = Enum.at(index, 0)
    y = Enum.at(index, 1)
    if Enum.at(game.board, index) == 0 do
      cond do
        player_num == 1 && game.cur_player == 1 ->
          Map.put(game, :board, List.replace_at(Enum.at(game.board, x), y, 1))
          Map.put(game, :cur_player , 2)
          Map.put(game, :finished , check_win(game))
        player_num == 2 && game.cur_player == 2 ->
          Map.put(game, :board, List.replace_at(Enum.at(game.board, x), y, 2))
          Map.put(game, :cur_player , 1)
          Map.put(game, :finished , check_win(game))
      end
    else
      game
    end
  end

  def get_player_num(game, player) do
    players = game.players
    result = 0
    Enum.map(players, fn [num, username] -> if player == username do result = num end end)
    result
  end


  def check_win(game) do
  end




end
