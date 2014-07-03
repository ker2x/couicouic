/* @pjs preload="blood_a_0001.png, blood_a_0002.png, blood_a_0003.png, blood_a_0004.png, blood_a_0005.png, blood_a_0006.png, blood_b_0001.png, blood_b_0002.png, blood_b_0003.png, blood_b_0004.png, blood_b_0005.png, blood_b_0006.png, ../keru/cdmtitle.jpg"; */


BloodSprites bloodSprites;
PImage bg;

class BloodSprites {
  int MAX_SPLATTERS=10;
  int FRAMES_PER_SPRITE=8;

  PImage[] imagesA;
  PImage[] imagesB;
  int imageCount = 6;

  float[] splattersX;
  float[] splattersY;
  float[] splattersFrameIdx;
  int splattersNext;

  BloodSprites() {
    imagesA = new PImage[imageCount];
    imagesB = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      imagesA[i] = loadImage("blood_a_" + nf(i+1, 4) + ".png");
      imagesB[i] = loadImage("blood_b_" + nf(i+1, 4) + ".png");
    }

    splattersX = new float[MAX_SPLATTERS];
    splattersY = new float[MAX_SPLATTERS];
    splattersFrameIdx = new float[MAX_SPLATTERS];
    for (int i = 0; i < MAX_SPLATTERS; i++) {
      splattersFrameIdx[i] = -1;
    }
  }

  void addSplatter(float x, float y) {
    splattersX[splattersNext] = x;
    splattersY[splattersNext] = y;
    splattersFrameIdx[splattersNext] = 0;
    splattersNext = (splattersNext+1) % MAX_SPLATTERS;
  }

  void draw() {
    imageMode(CENTER);
    for (int i = 0; i < MAX_SPLATTERS; i++) {
      if (splattersFrameIdx[i] == -1) continue;
      int idx = floor(splattersFrameIdx[i]);
      if (idx < imageCount) {
        splattersFrameIdx[i] += 1/FRAMES_PER_SPRITE;
        PImage img;
        if(i % 2 == 0) {
          img = imagesA[idx];
        } else {
          img = imagesB[idx];
        }
        image(img, splattersX[i], splattersY[i]);
      } else {
        splattersFrameIdx[i] = -1;
      }
    }
    imageMode(CORNERS);
  }
}

void setup() {
	size(800, 600);
	bloodSprites = new BloodSprites();
	bg = loadImage("../keru/cdmtitle.jpg");
}

void draw() {
	image(bg,0,0);
	bloodSprites.draw();
}

void mouseClicked() {
	bloodSprites.addSplatter(mouseX,mouseY);
}
