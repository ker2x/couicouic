
/* @pjs preload="asset.jpeg"; */
PImage img;

// Laser position and direction
int X, Y;
int dX, dY;
int delay = 10;


// Processing code
void setup() {
	size(800,600);
	background(100);
	stroke(255);
  	img = loadImage("asset.jpeg");
}

void draw() {
  image(img, 100, 100);
}