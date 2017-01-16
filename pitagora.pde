//以下のフリー素材を使用しています。
//http://free-illustrations-ls01.gatag.net/thum02/gi01a201503311000.jpg
//http://free-illustrations-ls01.gatag.net/images/lgi01a201403240600.jpg
//http://free-illustrations-ls01.gatag.net/images/lgi01a201308151600.jpg
import fisica.*;
FWorld world;
static final int CIRCLE_NUM=10;
static final int CIRCLE_DIAMETER=10;
static final int CIRCLE_POS_X=30;
static final int CIRCLE_POS_Y=15;
static final int CIRCLE_RED=200;
static final int CIRCLE_GREEN=200;
static final int CIRCLE_BLUE=100;
static final float CIRCLE_RESTITUTION=0.5;
ArrayList <Image> images;
FCircle[] circles;
ArrayList <FBody> bodies;
ArrayList <Particle> particles;
boolean rebound=false;
boolean isBox=false;
boolean blackhole=false;
boolean warp=false;
boolean clear=false;
boolean start=false;
void setup() {
  size(768, 432);
  textAlign(CENTER, CENTER);
  Fisica.init(this);

  world=new FWorld();
  world.setEdges();

  particles=new ArrayList <Particle>();

  circles=new FCircle[CIRCLE_NUM];
  for (int i=0; i<circles.length; i++) {
    circles[i]=new FCircle(CIRCLE_DIAMETER);
    circles[i].setPosition(CIRCLE_POS_X, CIRCLE_POS_Y);
    circles[i].setFill(CIRCLE_RED, CIRCLE_GREEN, CIRCLE_BLUE);
    circles[i].setRestitution(CIRCLE_RESTITUTION);
    world.add(circles[i]);
  }

  images=new ArrayList<Image>();
  for (int i=0; i<3; i++) {
    images.add(new Image(loadImage("gear.png"), 45, 90+i*100, 50, 50, 3));
  }
  for (int i=0; i<3; i++) {
    images.add(new Image(loadImage("gear.png"), 150, 45+i*100, 50, 50, 3));
  }
  images.add(new Image(loadImage("tank.jpg"), 20, 385, 140, 40, 0));
  images.add(new Image(loadImage("blackhole.png"), 550, 280, 80, 80, 5));

  bodies=new ArrayList<FBody>();
  for (int i=0; i<4; i++) {
    FBox box=new FBox(100, 10);
    box.setStatic(true);
    box.setPosition(57, 100*i+50);
    box.setFill(153, 76, 0);
    box.setRotation(radians(10));
    bodies.add(box);
    world.add(box);
  }
  for (int i=0; i<4; i++) {
    FBox box=new FBox(100, 10);
    box.setStatic(true);
    box.setPosition(137, 100*i+100);
    box.setFill(153, 76, 0);
    box.setRotation(radians(-10));
    bodies.add(box);
    world.add(box);
  }

  for (;; ) {
    FPoly poly=new FPoly();
    poly.vertex(635, 130);
    poly.vertex(635, 210);
    poly.vertex(755, 210);
    poly.vertex(755, 130);
    poly.vertex(755, 130);
    poly.vertex(745, 130);
    poly.vertex(745, 200);
    poly.vertex(645, 200);
    poly.vertex(645, 130);
    poly.setStatic(true);
    poly.setFill(153, 76, 0);
    poly.setStatic(true);
    poly.setFill(153, 76, 0);
    bodies.add(poly);
    world.add(poly);
    break;
  }

  for (;; ) {
    FBox box=new FBox(300, 10);
    box.setStatic(true);
    box.setPosition(450, 50);
    box.setFill(153, 76, 0);
    bodies.add(box);
    world.add(box);
    break;
  }

  for (int i=0; i<20; i++) {//29ko
    FBox box=new FBox(3, 25);
    box.setPosition(550-10*i, 29.999+2.5);
    box.setFill(255, 127, 0);
    bodies.add(box);
    world.add(box);
  }

  for (;; ) {//30ko
    FCircle circle=new FCircle(10);
    circle.setPosition(315, 39);
    circle.setFill(200, 200, 0);
    circle.setRestitution(0.5);
    bodies.add(circle);
    world.add(circle);
    break;
  }

  for (int i=0; i<2; i++) {
    FBox box=new FBox(10, 200);
    box.setPosition(500+i*100, height-105.1);
    box.setFill(153, 57, 0);
    box.setStatic(true);
    bodies.add(box);
    world.add(box);
  }

  for (int i=0; i<2; i++) {
    FBox box=new FBox(90, 10);
    box.setPosition(550, height-201+i*190);
    box.setFill(153, 57, 0);
    box.setStatic(true);
    bodies.add(box);
    world.add(box);
  }

  for (;; ) {
    FBox box=new FBox(10, 10);
    box.setPosition(511, 410);
    box.setFill(255, 0, 0);
    box.setStatic(true);
    bodies.add(box);
    world.add(box);
    break;
  }

}

void draw() {
  background(255);
  for (int i=0; i<images.size(); i++) {
    Image image=(Image)images.get(i);
    image.roll();
    image.display();
  }
  if (rebound==false) {
    fill(random(255), random(255), random(255));
    text("LIMIT: 10 BALLS", width-73, 100);
  }
  if (blackhole==false) {
    fill(random(255), random(255), random(255));
    text("WARNING: BLACK HOLE", 270, 25);
  }
  fill(random(255), random(255), random(255));
  textSize(10);
  text("SWITCH TO CLEAR", 550, height-35);


  for (int i=0; i<7; i++) {
    particles.add(new Particle(-1));
  }

  for (int i=0; i<particles.size(); i++) {
    Particle particle=(Particle)particles.get(i);
    if (particle.getCircleNum()>=0) {
      FCircle circle=circles[particle.getCircleNum()];
      particle.display(int(circle.getX()), int(circle.getY()));
    } else {
      particle.display(90, 385);
    }
    particle.update();
  }

  for (int i=0; i<circles.length; i++) {
    FBox box=(FBox)bodies.get(7);
    if (circles[i].isTouchingBody(box)) {
      circles[i].setVelocity(500, 1000);
      for (int j=0; j<100; j++) {
        particles.add(new Particle(i));
      }
    }
  }

  for (;; ) {
    int num=0;
    for (int i=0; i<circles.length; i++) {
      FPoly poly=(FPoly)bodies.get(8);
      if (circles[i].isTouchingBody(poly)) {
        num++;
      }
    }
    if (num>=circles.length) {
      FPoly poly=(FPoly)bodies.get(8);
      poly.setStatic(false);
    }
    break;
  }

  for (;; ) {
    FBox box=(FBox)world.getBody(width/2, height);
    if (box.isTouchingBody(bodies.get(8)) && rebound==false) {
      for (int i=0; i<circles.length; i++) {
        circles[i].setVelocity(-100, 1750);
      }      
      rebound=true;
    }
    break;
  }

  for (;; ) {//29と30
    FCircle circle=(FCircle)bodies.get(30);
    if (circle.isTouchingBody(bodies.get(29)) && blackhole==false) {
      images.add(new Image(loadImage("blackhole.png"), 350, 250, 250, 275, 5));
      for (;; ) {
        FBox box=new FBox(300, 10);
        box.setPosition(400, 110);
        box.setFill(153, 57, 0);
        box.setStatic(true);
        box.setRotation(radians(10));
        bodies.add(box);
        world.add(box);
        break;
      }

  for (;; ) {
        FBox box=new FBox(300, 10);
        box.setPosition(550, 170);
        box.setFill(153, 57, 0);
        box.setStatic(true);
        box.setRotation(radians(-10));
        bodies.add(box);
        world.add(box);
        break;
      }

      
      blackhole=true;
    }
    break;
  }
  for (;; ) {
    FCircle circle=(FCircle)bodies.get(30);
    if (dist(circle.getX(), circle.getY(), 350, 250)<30 && warp==false) {
      circle.setPosition(550, 280);
      warp=true;
    }//30ko
    break;
  }

  for (;; ) {
    //35
    FBox box=(FBox)bodies.get(35);
    if (box.isTouchingBody(bodies.get(30))) {
      clear=true;
    }
    break;
  }

  if (clear==false && start==true) {
    world.step();
    world.draw();
  } else if(clear==true) {
    background(255);
    textSize(40);
    text("CLEAR", width/2, height/2);
  }else{
    background(255);
    textSize(40);
    text("START", width/2, height/2);
  }
}

void keyPressed(){
  if(keyCode==32){
    start=true;
  }
}