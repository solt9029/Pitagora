class Image {
  private int y;
  private int x;
  private int w;
  private int h;
  private PImage image;
  private int rollSpeed;
  private int angle=0;
  public Image(PImage i, int x, int y, int w,int h, int r) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.image=i;
    this.rollSpeed=r;
  }
  public void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(this.x,this.y);
    rotate(radians(this.angle));
    image(this.image,0,0,this.w,this.h);
    popMatrix();
  }
  public void roll(){
    this.angle+=this.rollSpeed;
  }
}