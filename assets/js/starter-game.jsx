import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';


export default function game_init(root, channel) {
  ReactDOM.render(<Starter channel={channel}/>, root);
}

class Starter extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = {
      players: [],
      cur_player: 0,
      finished: 0,
      board: [[]],
    };

    this.channel
        .join()
        .receive("ok", this.got_view.bind(this))
        .receive("error", resp => {console.log("Unable to join", resp); })

    this.channel.on("update", this.got_view.bind(this));

  }

  got_view(view) {
    console.log(view)
    this.setState(view.game);
  }


  on_move(i) {
    console.log(i)
    var resp = this.channel.push("move", {index: i})
                           .receive("ok", this.got_view.bind(this));
  }


  restart() {
    this.channel.push("restart", {})
                .receive("ok", this.got_view.bind(this));
  }

  leave() {
    this.channel.push("remove_user",{user:window.userName});
    window.location = "/";
  }


  render() {
    const board = this.state.board;
    const players = this.state.players;
    const cur_player = this.state.cur_player;
    const finished = this.state.finished;
    return(
      <div className="column">
        <h3> Player(s){players.length}/2 </h3>
        <div>
          <ul>
            <Users players={players} />
          </ul>
        </div>
        <div>
          <ul>
            <p>Current Player's turn:{cur_player}</p>
          </ul>
        </div>
        <div className="board container">
          <div className="row">
             {board[0].map((piece, i) =>
              <Tile className="Button" index={[0, i]} piece={board[0][i]} on_move={this.on_move.bind(this, [i, 0])} />)}
          </div>

          <div className="row">
            {board[0].map((piece, i) =>
             <Tile className="Button" index={[1, i]} piece={board[1][i]} on_move={this.on_move.bind(this, [i, 1])} />)}
          </div>

          <div className="row">
            {board[0].map((piece, i) =>
             <Tile className="Button" index={[2, i]} piece={board[2][i]} on_move={this.on_move.bind(this, [i, 2])} />)}
          </div>

          <div className="row">
            {board[0].map((piece, i) =>
             <Tile className="Button" index={[3, i]} piece={board[3][i]} on_move={this.on_move.bind(this, [i, 3])} />)}
          </div>

          <div className="row">
            {board[0].map((piece, i) =>
             <Tile className="Button" index={[4, i]} piece={board[4][i]} on_move={this.on_move.bind(this, [i, 4])} />)}
          </div>

          <div className="row">
            {board[0].map((piece, i) =>
             <Tile className="Button" index={[5, i]} piece={board[5][i]} on_move={this.on_move.bind(this, [i, 5])} />)}
          </div>
        </div>
        <p><button onClick={this.restart.bind(this)}>Restart</button></p>
        <p><button onClick={this.leave.bind(this)}>Leave Game</button></p>
      </div>);
    }
}



let Tile = (props) => {
  return (
    <div className="column">
      <div className="cell" onClick={props.on_move}>
        {props.piece}
      </div>
    </div>)
}

let Users = (props) => {
  return(
    <div className="column">
      Players List: {props.players}
    </div>)
}
