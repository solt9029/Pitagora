class Particle {
  private float x=0;
  private float y;
  private float v;
  private float G=1;
  static final private float PARTICLE_DIAMETER=1.5;
  private int circleNum;
  public Particle(int cn) {
    this.y=random(-5, 5);
    this.v=random(10);
    this.circleNum=cn;
  }
  public void display(int circleX, int circleY) {
    if (this.v<0)return;
    fill(255, 255, 0);
    if(this.circleNum<0)fill(int(random(150,255)),0,0);
    pushMatrix();
    translate(circleX, circleY);
    translate(this.x, this.y);
    noStroke();
    ellipse(0, 0, PARTICLE_DIAMETER, PARTICLE_DIAMETER);
    popMatrix();
  }
  public void update() {
    if (this.circleNum<0) {
      this.x+=this.v/7;
    } else {
      this.x-=this.v;
      this.y+=G;
    }
    this.v-=0.12;
  }
  public int getCircleNum() {
    return this.circleNum;
  }
}