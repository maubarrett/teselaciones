// Presionar A para cambiar tamaño de triángulos
// Presionar S para volver al tamaño normal
// Presionar Mouse para cambiar color

// Mauricio Zúñiga Bernal

ArrayList <Figura> figuras;
float lado = 25;
float altura = sqrt(sq(lado) - sq(lado/2f));
float apotema = lado/ 2*tan(PI/6f);
float radio = altura - apotema;
float delta = 0;
void setup()
{
  size(600,600,P3D);
  figuras = new ArrayList<Figura>();
  for (float j = radio; j<=height; j+= altura){
    int paso = (round((j - radio)/altura));
    float offset =0;
    if (paso%2 == 0){
      offset = lado/2f;
    }
    for (float i =-offset; i<=width; i+= lado){
      figuras.add(new Triangulo(i,j,lado,0));
    }
    for (float i =lado/2f-offset; i<=width; i+= lado){
      figuras.add(new Triangulo(i,j-apotema,lado,PI));
    }
  }
}
void draw()
{
  background(255);
  noStroke();
  fill(0);
  for (Figura f: figuras){
    f.display();
  }
}
interface Figura
{
  float perimetro ();
  float area ();
  void display();
}
class Triangulo implements Figura
{
  float x,y,l,rc,ri,a,a1,deltax,deltay,h,b,rota;
  Triangulo (float x_,float y_,float l_, float rota_)
  {
    x=x_;
    y=y_;
    l=l_;
    rc=(l*sqrt(3))/3f;
    b=l;
    a1=TWO_PI/3;
    rota = rota_;
  }
  float perimetro ()
  {
    return l*3;
  }
  float area ()
  {
    return ((l*l)*(sqrt(3)))/4;
  }
  void display()
  {
    fill (random(255),0,0);
    pushMatrix();
    translate(x,y);
    rotate(HALF_PI - PI/3 + rota);
    beginShape();
      if(mousePressed){
        fill(0,0,random(255));
            }
            if(key == 'a'){
             rc=(l*sqrt(random(1,8)))/random(2,8);
            }
            if(key == 's'){
             rc=(l*sqrt(3))/3f; 
            }
    for(float a = 0;a<TWO_PI;a+=a1)
    {
      deltax=cos(a)*rc;
      deltay=sin(a)*rc;
      vertex(deltax,deltay);
    }
    endShape(CLOSE);
    popMatrix();
  }
}