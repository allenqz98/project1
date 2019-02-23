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
      players: game.players,
      cur_player: game.cur_player,
      finished: game.finished,
      board: game.board,
    }
  end

  def add_user(game, user) do
    players = game.players
    if length(players) < 2 do
      cond do
        length(players) == 0 -> players = Map.put(game, :players, [[1, user]])
        Enum.at(Enum.at(players, 0),0) == 1 -> Map.put(game, :players, players ++ [[2, user]])
        Enum.at(Enum.at(players, 0),0) == 2 -> Map.put(game, :players, players ++ [[1, user]])
      end
    end
  end


  def remove_user(game, user) do
    players = game.players
    players = Enum.filter(players, fn [num, user_name] -> user != user_name end)
    Map.put(game, :players, players)

  end


  def move(game, index, player) do
    player_num = get_player_num(game, player)
    x = Enum.at(index, 0)
    y = Enum.at(index, 1)
    IO.puts("hi there")
    IO.inspect player_num
    if Enum.at(Enum.at(game.board, x),y) == 0 do
      cond do
        player_num == 1 && game.cur_player == 1 ->
          game = Map.put(game, :board, new_board(game, x, y, 1))
          game = Map.put(game, :cur_player , 2)
          game = Map.put(game, :finished , check_win(game,index))
        player_num == 2 && game.cur_player == 2 ->
          game = Map.put(game, :board, new_board(game, x, y, 2))
          game = Map.put(game, :cur_player , 1)
          game = Map.put(game, :finished , check_win(game,index))
        true ->
          game
      end
    else
      game
    end
  end

  def get_player_num(game, player) do
    players = game.players
    val= Enum.find(players, fn [_, username] -> player == username end)
      if length(val)!=0 do
        [result , _] = val
        result
      end
  end

  def new_board(game, x, y, piece) do
    new_row = Enum.at(game.board, y)|>List.replace_at(x, piece)
    List.replace_at(game.board, y, new_row)
  end


  def check_win(game, index) do
    x = Enum.at(index, 0)
    y = Enum.at(index, 1)
    check_horizontal(game, x, y) || check_vertical(game, x, y) ||
    check_diagonal(game,x, y)
  end

  def check_diagonal(game,x,y) do
    (check_top_left(game, x, y, 0) + check_bot_right(game, x, y, 0) > 2) ||
    (check_top_right(game,x,y,0) + check_bot_left(game,x,y,0) > 2)
  end

  def check_horizontal(game, x, y) do
    (check_left(game,x,y,0) + check_right(game,x,y,0)) > 2
  end

  def check_vertical(game, x, y) do
    (check_top(game,x,y,0) + check_bot(game,x,y,0)) > 2
  end

  def check_left(game,x,y,acc) do
    player = game.cur_player
    if x == 0 do
      acc
    else
      if Enum.at(Enum.at(game.board, y), x - 1) ==  player do
        check_left(game, x - 1, y, acc + 1)
          else
            acc
            end
          end
        end

        def check_right(game,x,y,acc) do
          player = game.cur_player
          if x == 6 do
            acc
          else
            if Enum.at(Enum.at(game.board, y), x + 1) ==  player do
              check_right(game, x + 1, y, acc + 1)
            else
              acc
            end
          end
        end

        def check_top(game,x,y,acc) do
          player = game.cur_player
          if y == 0 do
            acc
          else
            if Enum.at(Enum.at(game.board, y - 1), x) ==  player do
              check_top(game, x, y - 1, acc + 1)
            else
              acc
            end
          end
        end

        def check_bot(game,x,y,acc) do
          player = game.cur_player
          if y == 5 do
            acc
          else
            if Enum.at(Enum.at(game.board, y + 1), x) ==  player do
              check_bot(game, x, y + 1, acc + 1)
            else
              acc
            end
          end
        end
        def check_bot_left(game,x,y,acc) do
          player = game.cur_player
          if y == 5 or x == 0 do
            acc
          else
            if Enum.at(Enum.at(game.board, y + 1), x - 1) ==  player do
              check_bot_left(game, x - 1, y + 1, acc + 1)
            else
              acc
            end
          end
        end
        def check_bot_right(game,x,y,acc) do
          player = game.cur_player
          if y == 5 or x == 6 do
            acc
          else
            if Enum.at(Enum.at(game.board, y + 1), x + 1) ==  player do
              check_bot_right(game, x + 1, y + 1, acc + 1)
            else
              acc
            end
          end
        end
        def check_top_right(game,x,y,acc) do
          player = game.cur_player
          if y == 0 or x == 6 do
            acc
          else
            if Enum.at(Enum.at(game.board, y - 1), x + 1) ==  player do
              check_top_right(game, x + 1, y - 1, acc + 1)
            else
              acc
            end
          end
        end
        def check_top_left(game,x,y,acc) do
          player = game.cur_player
          if y == 0 or x == 0 do
            acc
          else
            if Enum.at(Enum.at(game.board, y - 1), x - 1) ==  player do
              check_top_left(game, x - 1, y - 1, acc + 1)
            else
              acc
            end
          end
        end





      end
