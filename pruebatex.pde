// The next line is needed if running in JavaScript Mode with Processing.js
/* @pjs preload="imagenes/lineas.png,imagenes/lineas_1.png,imagenes/lineas2.png,imagenes/lineas2_1.png";
     crisp="true";*/ 


PImage tex;
PImage tex2;
PImage tex_1;
PImage tex2_1;
PImage tex3;
PImage logo;
//float rotx = PI/4;
//float roty = PI/4;
float rotx = 0;
float roty = 0;
float rotx1 = 0;
float roty1 = 0;
float rotx2 = 0;
float roty2 = 0;
float rotx3 = 0;
float roty3 = 0;
float aceleracion = 0.05;
boolean cambio = false;
boolean rotar = false;
int lapso = 0;
int lapsorotar = 0;
int escala = 200;
int pointillize = 16;
int textura = 1;
int constante = 3;


void setup() {
  size( $(window).width(),$(window).height(),P3D);
  //size(1000, 360, P3D);
  tex = loadImage("imagenes/lineas.png");
  tex_1 = loadImage("imagenes/lineas_1.png");
  tex2 = loadImage("imagenes/lineas2.png");
  tex2_1 = loadImage("imagenes/lineas2_1.png");
  tex3 = loadImage("imagenes/lineas.png");
  textureMode(NORMAL);
  fill(255);
  stroke(color(44,48,32));
  //tex.resize($(window).width(),$(window).height());
  //tex2.resize(1000, 360);
  image(tex2,0,0,$(window).width(),$(window).height());
}

void draw() {
 
  //background(0);
  
 //1
 pushMatrix();
  translate(width/4, height/2, -100);
  roty = roty + aceleracion;
  rotx = rotx + aceleracion;
  rotateX(rotx);
  rotateY(roty);
  scale(escala);
   if (cambio == true){
    TexturedCube(tex);
  }else{
    TexturedCube(tex2);
  }
  popMatrix();
  
  //2
  pushMatrix();
  translate(width*3/4, height/2, -100);
  roty1 = roty1 - aceleracion;
  rotx1 = rotx1 + aceleracion;
  rotateX(rotx1);
  rotateY(roty1);
  scale(escala);
  if (cambio == true){
    TexturedCube(tex);
    textura = 1;
  }else{
    TexturedCube(tex2);
    textura = 2;
  }
  popMatrix();
  
  //3
  pushMatrix();
  translate(width/2, height/4, -100);
  rotx2 = rotx2 + aceleracion;
  rotateX(rotx2);
  rotateY(roty2);
  scale(escala);
  if (cambio == true){
    TexturedCube(tex2);
  }else{
    TexturedCube(tex);
  }
  popMatrix();
  
  //4
  pushMatrix();
  translate(width/2, height*3/4, -100);
  rotx3 = rotx3 - aceleracion;
  rotateX(rotx3);
  rotateY(roty3);
  scale(escala);
  if (cambio == true){
    TexturedCube(tex2);
  }else{
    TexturedCube(tex);
  }
  popMatrix();
  
  lapso = lapso+1;
  lapsorotar = lapsorotar+1;
  escala = escala + constante;
  //System.out.println(escala);
  if ( escala >= 7000 || escala <= 200){
  //if ( escala == 1001 || escala == 200){
    //escala = 200;
    constante = constante * (-1);
  }  
  
  if (lapso == 100){
    cambio = !cambio;
    lapso = 0;
  }
  
 
  if (lapsorotar == 100){
    rotar = true;
    aceleracion = 0.00001;
  }else if (lapsorotar == 200){
    rotar = false;
    aceleracion = 0.001;
    //lapsorotar = 0;    
  }else if (lapsorotar == 300){
    aceleracion = 0.05;
    lapsorotar = 0;
  }
 
}

void TexturedCube(PImage tex) {
  beginShape(QUADS);
  texture(tex);

  // Given one texture and six faces, we can easily set up the uv coordinates
  // such that four of the faces tile "perfectly" along either u or v, but the other
  // two faces cannot be so aligned.  This code tiles "along" u, "around" the X/Z faces
  // and fudges the Y faces - the Y faces are arbitrarily aligned such that a
  // rotation along the X axis will put the "top" of either texture at the "top"
  // of the screen, but is not otherwised aligned with the X/Z faces. (This
  // just affects what type of symmetry is required if you need seamless
  // tiling all the way around the cube)
  
  // +Z "front" face
  vertex(-1, -1,  1, 0, 0);
  vertex( 1, -1,  1, 1, 0);
  vertex( 1,  1,  1, 1, 1);
  vertex(-1,  1,  1, 0, 1);

  // -Z "back" face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1,  1, -1, 1, 1);
  vertex( 1,  1, -1, 0, 1);

  // +Y "bottom" face
  vertex(-1,  1,  1, 0, 0);
  vertex( 1,  1,  1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  // -Y "top" face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1,  1, 1, 1);
  vertex(-1, -1,  1, 0, 1);

  // +X "right" face
  vertex( 1, -1,  1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex( 1,  1,  1, 0, 1);

  // -X "left" face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1,  1, 1, 0);
  vertex(-1,  1,  1, 1, 1);
  vertex(-1,  1, -1, 0, 1);

  endShape();
}

void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}


