PImage img;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
FFT fftLog;
BeatDetect beat;


void setup(){
  
  size(500,500);
  img = loadImage("image_black_white.jpg");
  img.resize(500,500);
  
  minim = new Minim(this);
  player = minim.loadFile("audio.mp3");
  player.play();
  
  beat = new BeatDetect();
  
}

void draw(){
  
  beat.detect(player.mix);
  
  background(255);
  fill(0);
  noStroke();
  
  float tiles = mouseX/10;
  float tileSize = width/tiles; 

  translate(tileSize/2, tileSize/2);
  
  if ( beat.isOnset() ) {
    // only appear at beat onset
  
    for (int x = 0; x < tiles; x++) {
      
      for (int y = 0; y < tiles; y++) {
      
        color c = img.get( int(x*tileSize), int(y*tileSize));
        float size = map(brightness(c), 0, 255, 0, tileSize); // --> invert 0/tileSize for B/N inversion
        
        ellipse(x*tileSize, y*tileSize, size, size);
      }
    }
  }
  
}
