// value to adapt
var nb_player = 11;
var nb_team = 2;

// size : 800*600
var icon_size = 20; // used to calculat position for left corner
var height = 600;
var width = 800;

// color
var color = ['black','blue'];

// create positions for nb_player * nb_team player 
// position of top left corner of the icon (icon_size)
// return array of array 
// example Array[[w,h],[w2,h2]]
function placement() {
  // do not place too high, near the border, etc...
  var min_height = icon_size;
  var max_height = height - 2 * icon_size;
  var min_width = icon_size;
  var max_width = width - 2 * icon_size;

  // create enough random position
  var combinaisons = Array();
  while (combinaisons.length < nb_player * nb_team) {
    var nb = combinaisons.length;
    var w = Math.floor(Math.random() * (max_width - min_width + 1) + min_width);
    var h = Math.floor(Math.random() * (max_height - min_height + 1) + min_height);

    // check for not too near icon
    var is_ok = true;
    var x = 0;
    while (x < combinaisons.length && is_ok) {
      if (   w > combinaisons[x][0] - icon_size 
        && w < combinaisons[x][0] + icon_size 
        && h > combinaisons[x][1] - icon_size 
        && h < combinaisons[x][1] + icon_size) {
        console.log("Un joueur mort sur la pelouse, appel du remplacant");
        is_ok = false;
      }
      // check and set is_ok to false if needed
      x++;
    }
    // Save the coords
    if (is_ok) {
      combinaisons[nb] = Array(w, h);
    }
  }
  return combinaisons;
}