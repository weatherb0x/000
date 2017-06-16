/* @pjs font='Media/Fonts/AnonymousPro-Regular.ttf' */
/* @pjs transparent='true';    */


public class Particle {
 Ring ring;
  public Particle() {
    ring = new Ring();
  }
  int   ring_count = 7;
  float rate =  .001;
  float c    =    0;
  float radius = 0;

  float x = width/2;
  float y     = height/2; 
  float mass  = .001; 

  void draw(){
  pushMatrix();
    translate(this.x,this.y);
    rotate(c);
    translate(-width/2,-height/2);
      for(int x = 0 ; x < ring_count ; x++ ){
        ring.draw(width/2+sin(x+c)*radius,height/2+cos(x+c)*radius, sin(x+c) + cos(x+c) , -sin(x+c) + cos(x+c));
        //ring.draw(width/2+sin(x+c)*radius,height/2+cos(x+c)*radius, sin(x+c) + cos(x+c) , -sin(x+c) + cos(x+c));
      }
  popMatrix();
  c = c + rate ; 
  }
}

        public class Ring {


          PImage[] t;
          int triangle_count = 11 ; 
          int circle_width   = 333 ;

          float spacing = 2 * PI /triangle_count;

          public Ring (){
              //t = new PImage[triangle_count];
              //for(int x = 0 ; x < triangle_count; x++){
              // t[x] = loadImage("t.gif"); 
              //}
          }
          float angle =    0; 
          float rate  = .001;
    

          public void draw(float x_loc,float y_loc,_w,_s){



          angle = angle + rate;

            for(int x = 0 ; x < triangle_count; x++){
             pushMatrix();
               translate(x_loc,y_loc);
               //rotate(angle);
               translate(sin(spacing*x)*circle_width*_w,cos(spacing*x)*circle_width*_w);
               rotate(  PI -  x*spacing );
               //image(t[x],0,0,11*_s,11*_s);
               //colorMode(HSB);
               //fill(0,0,360,155);
               //noStroke();
               rect(0,0,17*_s,17*_s);
               //colorMode(RGB);
               //box(7);
             popMatrix();
            }

          }

           


        }
         

//  [] <---> [] // with some kind of tween to represent time


public class Interfold {

  Particle l;
  Particle r;

  float distance;
  float angle   ;
  float velocity_x;
  float velocity_y;  

  PVector l_v ;
  PVector r_v ;

  public Interfold(l,r){
    this.velocity_x = 0 ; 
    this.velocity_y = 0 ; 

    this.l = l
    this.r = r

    this.l_v = new PVector(this.l.x,this.l.y,0);
    this.r_v = new PVector(this.r.x,this.r.y,0);

  }

  static float angleTo(l,r){
    float a = atan2(l.y-r.y , r.x-l.x);
    if(a < 0){
      a= a + 2*PI;
    }
    return a ;
  }

  public void math(){
    this.l_v.set(this.l.x , this.l.y,0);
    this.r_v.set(this.r.x , this.r.y,0);
    this.angle    =  Interfold.angleTo(this.l_v,this.r_v)   ;
    this.velocity_x = this.velocity_x + (  cos(angle) * this.r.mass ) ;
    this.velocity_y = this.velocity_y + (  sin(angle) * this.r.mass ) ;
    this.l.x = this.l.x + this.velocity_x;
    this.l.y = this.l.y - this.velocity_y;
  }


  public void draw(){
  }

}

 
 
Particle particle ; 

int particle_count = 3;

Particle    particle ; 
Particle[]  particles;
Interfold[] interfolds;



//PFont rgb_font;


PGraphics overlay ;


void setup(){

  frameRate(11);

  overlay = createGraphics(133,133,P2D);


  //rgb_font = loadFont("rgb-Regular.otf");
  //textFont(rgb_font);
  //textAlign(CENTER);
  //textSize(33);


  size(document.body.offsetWidth,document.body.offsetHeight);

  //size(document.body.getBoundingClientRect().width,document.body.getBoundingClientRect().height);

  smooth();

    // x y direction speed attraction


    particles  = new Particles[particle_count];
    particle   = new Particle();
    interfolds = new Interfold[pow(particle_count,particle_count-1)];

    for(int x = 0 ; x < particle_count ; x++ ){
      particles[x] = new Particle();
      particles[x].x = random(0+width/3 ,width-width/3);
      particles[x].y = random(0+height/3,height-height/3);
    }

    for(int x = 0 ; x < particle_count ; x++){
      for(int y = 0 ; y < particle_count ; y++ ){
        if(particles[x] == particles[y]){
         continue
        }   
        interfolds[x] = new Interfold(particles[x],particles[y]);
      }
    }



  background(0,0,0,0);
}



//var current = createGraphics(document.body.offsetWidth,document.body.offsetHeight,P2D); 

void draw(){

  fill(0,0,0,4);
  rect(0,0,width,height);

  for(int x = 0 ; x < particle_count ; x++ ){
    interfolds[x].math();
  }

    noStroke();

  float color_step = 260/particle_count ; 

  for(int x = 0 ; x < particle_count ; x++ ){
    colorMode(HSB);
    fill(color_step*x,100,360,135);
    particles[x].draw();
    colorMode(RGB);
  }

  //fill(0,0,0,11);
  //rect(0,0,width,height);

  /*
    current.image(get());
    background(0,0,0,0);
    current.loadPixels();
    for(int x = 0 ; x < current.width*current.height;x++){
      if( brightness( current.pixels[x] ) < 1 ){
        current.pixels[x]  = 0    
      }
    }
    current.updatePixels();
    image(current)
  */


  /*
  overlay.beginDraw();
  overlay.background(255,0,0);
  overlay.endDraw();
  pushMatrix();
   translate(0,0,0);
   tint(255,100);
   image(overlay.get(),0,0);
   noTint();
  popMatrix();
  */


}

