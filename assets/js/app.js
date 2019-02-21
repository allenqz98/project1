import css from "../css/app.css";
import "phoenix_html";
import $ from "jquery";
// Import local files
import socket from "./socket"

import game_init from "./starter-game";

$(() => {
  let root = document.getElementById('root');
  if (root) {
    let channel = socket.channel("games:" + window.gameName, {user: window.userName})
    game_init(root, channel);
  }

});
