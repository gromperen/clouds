import java.util.*;

final int sz = 1025; // 2^n+1
final float roughness = 0.3;
Random r;
ArrayList<Particle> particles;


float[][] pixmap;

void setup() {
  r = new Random();
  size(1025, 1025, P2D);
  background(135, 206, 235);
  colorMode(HSB, 360, 255, 100);
  rectMode(CENTER);
  noStroke();
  loadPixels();
  particles = new ArrayList<Particle>();
  plasma();
} 


void plasma() {
  pixmap = new float[sz][sz];
    float c1, c2, c3, c4;
    c1 = random(1.0);
    c2 = random(1.0);
    c3 = random(1.0);
    c4 = random(1.0);
    
    sqr(0, 0, sz, sz, c1, c2, c3, c4, 1.0);
    
    for (int i = 0; i < sz; ++i) {
      for (int j = 0; j < sz; j++) {
        set(i,j, color(210, pixmap[i][j], 100));
      }
    }
}

void sqr(int x, int y, int w, int h, float c1, float c2, float c3, float c4, float std) {
  float p1, p2, p3, p4, mid;
  if (w <= 1 && h <= 1) {
    float p = (c1+c2+c3+c4)/4;
    for (int i = x; i < x + w; ++i) {
      for (int j = y; j < y + h; ++j) {
        pixmap[x][y]=p*255;
      }
    }
    
    return;  
  }
  mid = (c1 + c2 + c3 + c4) / 4 + (float)r.nextGaussian()*std * roughness;
  p1 = (c1 + c2) / 2;
  p2 = (c2 + c3) / 2;
  p3 = (c3 + c4) / 2;
  p4 = (c4 + c1) / 2;
  
  p1 = max(0.0, min(p1, 1.0));
  p2 = max(0.0, min(p2, 1.0));
  p3 = max(0.0, min(p3, 1.0));
  p4 = max(0.0, min(p4, 1.0));
  
  sqr(x,y,w/2,h/2,            c1,p1,mid,p4,std/2);
  sqr(x+w/2,y,w-w/2,h/2,      p1,c2,p2,mid,std/2);
  sqr(x+w/2,y+h/2,w-w/2,h-h/2,mid,p2,c3,p3,std/2);
  sqr(x,y+h/2,w/2,h-h/2,      p4,mid,p3,c4,std/2);
  
}



void draw() {
  for (int i = 0; i < particles.size(); ++i) {
    Particle p = particles.get(i);
      p.drawparticle();
      p.reproduce();
       particles.remove(i);
  }
  
}



void mousePressed() {
  particles.add(new Particle(mouseX, mouseY, 50, color(255, 0, 255), 10));
  println("OK1");
}

void keyPressed() {
  plasma();
}
