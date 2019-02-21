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
      board: [],
    };

    this.channel
        .join()
        .receive("ok", this.got_view.bind(this))
        .receive("error", resp => {console.log("Unable to join", resp); })

  }

  got_view(view) {
    this.setState(view.game);
  }


  on_move(i) {
    var resp = this.channel.push("move", {index: i})
                           .receive("ok", this.got_view.bind(this));
  }


  restart() {
    this.channel.push("restart", {})
                .receive("ok", this.got_view.bind(this));
  }


  render() {
    const board = this.state.board;
    return(
      <div className="column">
        <p>Connect Four</p>
        <h3> Player(s) /2 </h3>
        <div className="board container">
          <div className="row">
            {Enum.at(board,0).map((piece, i) =>
              <Tile className="Button" index={[0, i]} piece={board[i]} on_move={this.on_move.bind(this, i)} />)}
          </div>

          <div className="row">

          </div>

          <div className="row">

          </div>

          <div className="row">

          </div>
        </div>
        <p><button onClick={this.restart.bind(this)}>Restart</button></p>
      </div>);
    }
}

let Tile = (props) => {
  let piece_type;
  if (props.piece === 1) {
    piece_type = "player1-piece"
  } else if (props.piece === 2) {
    piece_type = "player2-piece"
  } else {
    piece_type = "empty"
  }
  return (
    <div className="column">
      <div className={piece_type} onClick={props.on_move}>
        {props.piece}
      </div>
    </div>)
}
