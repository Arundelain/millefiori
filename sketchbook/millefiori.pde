
//Karen Royer - Millefiori Pattern
//********************************

//import pdf library for drawing to file
import processing.pdf.*;  // Import PDF code





PFont messageFont;

//two vectors - dots holds the values of valid snap points
//largeDishInit holds the values of the origins of the large dishes that are valid
PVector[] dots = new PVector[97];
PVector[] largeDishInit = new PVector[dots.length];
PVector[] mediumDishInit = new PVector[dots.length];

int[] imageNumber = new int[100];
String[] imageStr = new String[100];

int imageNum = 0;
//int smallImageNum;
//int mediumImageNum;
//int largeImageNum;



//the millefiori pattern is made of the following shapes
//parallelogram is the center - nParallelogram is the narrow one one the second row
//mParallelogram is the mirror image of the first one
//rParallelogram is the first one rotated on its end
//pentagon is drawn with a flat side at the top and the point at the bottom
//rPentagon is the reversed with the point at the top and flat side at the bottom
//star is standing on two legs and rStar is the reverse
PShape parallelogram;
PShape nParallelogram;
PShape mParallelogram;
PShape rParallelogram;
PShape pentagon;
PShape rPentagon;
PShape star;
PShape rStar;

PImage paraImage;
PImage nParaImage;
PImage n1ParaImage;
PImage mParaImage;
PImage rParaImage;
PImage pentaImage;
PImage altAPentaImage;
PImage altBPentaImage;
PImage rPentaImage;
PImage altCPentaImage;
PImage starImage;
PImage rStarImage;
PImage backing;

PGraphics paraMask;
PGraphics nParaMask;
PGraphics n1ParaMask;
PGraphics mParaMask;
PGraphics rParaMask;
PGraphics pentaMask;
PGraphics altAPentaMask;
PGraphics altBPentaMask;
PGraphics rPentaMask;
PGraphics altCPentaMask;
PGraphics starMask;
PGraphics rStarMask;

String largeDish = "You have drawn a large dish.";
String mediumDish = "You have drawn a medium dish.";
String tooClose = "You are too close to a dish. Try again.";
String validSelection = "Your selection has been received and snapped to a valid location.";
String rightMouse = "Right mouse was pressed";
//String initInstr = "Use the left mouse button to select a spot where you want a pattern to go." + "\n"+"Use L or l for a large dish and M or m for a medium dish";
String allKeys = "H - Help for what keys are available to press. S - Stop program and save an image called MillefioriPattern.jpg to this folder."
  + "\n" + "L - Large dish. M - Medium dish. N - New fabrics for upcoming dishes. Left mouse click - Next pattern location.";

//pressed x and y hold the value of the x and y coordinates of the left mouse button press
float pressedX = 0;
float pressedY = 0;


//random origin is used to begin the drawing with a randomly placed large dish on the screen
int randOrigin = 0;

//counter keeps track of how many large dishes have been drawn
int lCounter = 0;
int mCounter = 0;
//side length refers to the sides of the parallelograms, pentagons and the length of the star arms
//the unit angle is followed by the half unit angle and quarter unit angle
float sideLength = 30;
float uAngle = (radians(72));
float hUAngle = (radians(36));
float qUAngle = (radians(18));

//The following triangle definitions are used in calculating the shapes
//small triangle dimensions
float sTLength = sideLength;
float sTHeight = sTLength*sin(uAngle);
float sTHBase = sTLength*cos(uAngle);
float sTBase = 2*sTHBase;

//tiny triangle dimensions
float tTLength = sTBase;
float tTHeight = tTLength*sin(uAngle);
float tTHBase = tTLength*cos(uAngle);
float tTBase = 2 * tTHBase;

//medium triangle dimensions
float mTLength = sTHeight/sin(hUAngle);
float mTHeight = mTLength*sin(uAngle);
float mTHBase = mTLength*cos(uAngle);
float mTBase = 2*mTHBase;

//large triangle dimensions
float lTLength = mTHeight/sin(hUAngle);
float lTHeight = lTLength*sin(uAngle);
float lTHBase = lTLength*cos(uAngle);
float lTBase = 2*lTHBase;

//xLarge triangle dimensions
float xLTLength = mTLength + lTLength;
float xLTHeight = xLTLength*sin(uAngle);
float xLTHBase = xLTLength*cos(uAngle);
float xLTBase = 2*xLTHBase;

//large dish radius is the distance from the origin of the large dish to the 
//farthest point of the farthest star arm
float largeDishRadius = sqrt(pow(mTHeight, 2)+pow((2*xLTLength+mTHBase), 2));
float mediumDishRadius = sqrt(pow(xLTHeight, 2)+pow((lTBase+mTHBase+sTBase), 2));

//The following values are the valid points on which the shapes can be drawn without
//overlapping or "breaking" the shape patterns. This will help the sewer to avoid cutting
//weird shapes. The first section is the x axis and second is the y axis.
float xA = 0;
float xB = xA+lTHBase;
float xC = xB+xLTHBase;
float xD = xC+xLTHBase;
float xE = xD+lTHBase;
float xF = xE+xLTHBase;
float xG = xF+xLTHBase;
float xH = xG+lTHBase;
float xI = xH+xLTHBase;
float xJ = xI+lTHBase+xLTHBase;
float xK = xJ+lTHBase+xLTHBase;
float xL = xK+xLTHBase;
float xM = xL+lTHBase+xLTHBase;
float xN = xM+xLTHBase;
float xO = xN+lTHBase;
float xP = xO+xLTHBase;
float xQ = xP+xLTHBase;
float xR = xQ+lTHBase;
float xS = xR+xLTHBase;
float xT = xS+lTHBase+xLTHBase;
float xU = xT+xLTHBase;
float xV = xU+lTHBase+xLTHBase;
float xW = xV+lTHBase+xLTHBase;
float xX = xW+xLTHBase;
float xY = xX+lTHBase;
float xZ = xY+xLTHBase;
float AA = xZ+xLTHBase;
float BB = AA+lTHBase;
float CC = BB+xLTHBase;
float DD = CC+xLTHBase;
float EE = DD+lTHBase;

float yA = 0;
float yB = yA+xLTHeight;
float yC = yB+lTHeight;
float yD = yC+mTHeight;
float yE = yD+lTHeight;
float yF = yE+xLTHeight;
float yG = yF+lTHeight;
float yH = yG+xLTHeight;
float yI = yH+lTHeight;
float yJ = yI+mTHeight;
float yK = yJ+lTHeight;
float yL = yK+xLTHeight;
float yM = yL+lTHeight;
float yN = yM+xLTHeight;
float yO = yN+xLTHeight;
float yP = yO+lTHeight;
float yQ = yP+xLTHeight;
float yR = yQ+lTHeight;
float yS = yR+mTHeight;
float yT = yS+lTHeight;

int iWidth = 400;
int iHeight = 400;
String word = "";

//set up the size of the screen, background color and create all of the shapes
void setup() {
  size(2000, 2000);
  //fullScreen();
  background(255); 
 
  messageFont = createFont("Arial", 35, true);
  for (int i= 0; i<100; i++) {  
    imageStr[i] = str(i)+"_images.jpg";
    //println(imageStr[i]);
  }


  //*****************************
  //create the basic shapes
  star();
  reflectedStar();
  parallelogram();
  mirroredParallelogram();
  rotatedParallelogram();
  narrowParallelogram();
  pentagon();
  reflectedPentagon();
  //*****************************
  //get the images
  imageNum = int(random(100));
  word = getARelatedNumberString(imageNum);
  //imageStr[int(random(100))]
  paraImage=loadImage(getARelatedNumberString(imageNum));
  nParaImage=loadImage(imageStr[int(random(100))]);
  n1ParaImage=loadImage(getARelatedNumberString(imageNum));
  mParaImage=loadImage(imageStr[int(random(100))]);
  rParaImage=loadImage(getARelatedNumberString(imageNum));
  pentaImage=loadImage(imageStr[int(random(100))]);
  altAPentaImage=loadImage(getARelatedNumberString(imageNum));
  altBPentaImage=loadImage(getARelatedNumberString(imageNum));
  rPentaImage=loadImage(imageStr[int(random(100))]);
  altCPentaImage=rPentaImage;
  starImage=loadImage(getARelatedNumberString(imageNum));
  rStarImage=loadImage(imageStr[int(random(100))]);

  backing = loadImage(word);
  println(imageNum);
  //println(backing);
  for (int i = 0; i<4; i++) {
    for (int j = 0; j<5; j++) {
      image(backing, i*400, j*400);
    }
  }

  paraMask = createGraphics(iWidth, iHeight);
  paraMask.beginDraw();
  paraMask.shape(parallelogram);
  paraMask.endDraw(); 
  paraImage.mask(paraMask);

  rParaMask = createGraphics(iWidth, iHeight);
  rParaMask.beginDraw();
  rParaMask.shape(rParallelogram);
  rParaMask.endDraw(); 
  rParaImage.mask(rParaMask);

  nParaMask = createGraphics(iWidth, iHeight);
  nParaMask.beginDraw();
  nParaMask.shape(nParallelogram);
  nParaMask.endDraw(); 
  nParaImage.mask(nParaMask);

  n1ParaMask = createGraphics(iWidth, iHeight);
  n1ParaMask.beginDraw();
  n1ParaMask.shape(nParallelogram);
  n1ParaMask.endDraw(); 
  n1ParaImage.mask(n1ParaMask);

  mParaMask = createGraphics(iWidth, iHeight);
  mParaMask.beginDraw();
  mParaMask.shape(mParallelogram);
  mParaMask.endDraw(); 
  mParaImage.mask(mParaMask);

  pentaMask = createGraphics(iWidth, iHeight);
  pentaMask.beginDraw();
  pentaMask.shape(pentagon);
  pentaMask.endDraw(); 
  pentaImage.mask(pentaMask);

  altAPentaMask = createGraphics(iWidth, iHeight);
  altAPentaMask.beginDraw();
  altAPentaMask.shape(pentagon);
  altAPentaMask.endDraw(); 
  altAPentaImage.mask(altAPentaMask);

  altBPentaMask = createGraphics(iWidth, iHeight);
  altBPentaMask.beginDraw();
  altBPentaMask.shape(pentagon);
  altBPentaMask.endDraw(); 
  altBPentaImage.mask(altBPentaMask);

  rPentaMask = createGraphics(iWidth, iHeight);
  rPentaMask.beginDraw();
  rPentaMask.shape(rPentagon);
  rPentaMask.endDraw(); 
  rPentaImage.mask(rPentaMask);

  altCPentaMask = createGraphics(iWidth, iHeight);
  altCPentaMask.beginDraw();
  altCPentaMask.shape(pentagon);
  altCPentaMask.endDraw(); 
  altCPentaImage.mask(altCPentaMask);

  starMask = createGraphics(iWidth, iHeight);
  starMask.beginDraw();
  starMask.shape(star);
  starMask.endDraw(); 
  starImage.mask(starMask);

  rStarMask = createGraphics(iWidth, iHeight);
  rStarMask.beginDraw();
  rStarMask.shape(rStar);
  rStarMask.endDraw(); 
  rStarImage.mask(rStarMask);

  //fill the valid snap dots vector array
  validSnaps();

  //get a random number that will be used as an array
  //index for the program to draw an initial large dish
  randOrigin = int(random(dots.length));

  //for the sake of safety, initialize the large dish array at the random location
  //the idea here was to keep track of how many dishes had been drawn to stop the 
  //user from being able to try to draw large dishes. This may not be necessary any more
  for (int i = 0; i<largeDishInit.length; i ++) {
    if (i < 20) {
      largeDishInit[i] = new PVector(dots[randOrigin].x, dots[randOrigin].y);
    } else {
      largeDishInit[i] = new PVector(-2*largeDishRadius, -2*largeDishRadius);
    }
  }//end for fill the large dish array

  for (int i = 0; i<mediumDishInit.length; i ++) {
    mediumDishInit[i] = new PVector(dots[randOrigin].x, dots[randOrigin].y);
  }//end for fill the medium dish array



  //clear the VBO using the pushMatrix, translate the first dish to the random location and
  //pop this translation value back to the origin.
  fill(255);
  rect(1405,0,800,1800);
  fill(0);
  textSize(35);
  text("Before doing anything else, left" + "\n" + "mouse click on image" + "\n" + "This is the current fabric selection" + "\n" + "If you like it, then left mouse " + "\n" + 
  "click again somewhere to the left" + "\n" + "in a place of your choosing" 
  + "\n" + "and select either L for a" + "\n" + "large dish or M for a medium dish." + "\n" + "If you do not like the fabric" + "\n" + "selection, then" + "\n" + "press N for a new one." 
  + "\n" + "\n" + "L - Large Dish" + "\n" + "M - Medium Dish" + "\n" + "N - New fabric selection" + "\n" + "S - stops program and " + "\n" + "saves an image", 1415,700);
  pushMatrix();
  translate(1700,300);
 
  drawLargeDish();
  popMatrix();
  textFont(messageFont);
  sendMessage(allKeys);
}//end setup

void draw() {

  //this for loop build the little dots on the drawing screen for the user to have
  //an idea of where they can draw
  pushMatrix(); 
  for (int i = 0; i<dots.length; i++) {   
    fill(0);
    ellipse(dots[i].x, dots[i].y, 3, 3);
    fill(255);
  }
  popMatrix();
}//end draw





void drawLargePattern() {
  //cycle through the dishes. If the current origin is too close to any of the other origins, then do nothing
  //otherwise continue on. The variables pressedX and pressedY are resolved in the mouse event function.
  for (int i = 0; i < mediumDishInit.length; i++) {    
    if (!largeEnoughDistanceBetween(largeDishInit[i].x, largeDishInit[i].y, pressedX, pressedY, largeDishRadius)||
      (!largeEnoughDistanceBetween(mediumDishInit[i].x, mediumDishInit[i].y, pressedX, pressedY, mediumDishRadius))) {
      sendMessage(tooClose);
      return;
    }// end if too close
  }//end for loop

  //if the location the at which the mouse was pressed is far enough away from other large dishes, then 
  if (largeEnoughDistanceBetween(largeDishInit[lCounter].x, largeDishInit[lCounter].y, pressedX, pressedY, largeDishRadius)) {
    pushMatrix();        
    translate(pressedX, pressedY);      
    drawLargeDish();   
    //set the location of the present dish to the snapped pressedX and Y values
    largeDishInit[lCounter].x = pressedX;
    largeDishInit[lCounter].y = pressedY; 
    //println(pressedY);
    popMatrix();
    sendMessage(largeDish);
    lCounter++;
  }//end if larger or equal to radius
}//end draw pattern

void drawMediumPattern() {
  //PVector curPos;
  for (int i = 0; i < mediumDishInit.length; i++) {
    //check to make sure the points are far enough away from the large dishes and the other medium dishes.
    if (!largeEnoughDistanceBetween(largeDishInit[i].x, largeDishInit[i].y, pressedX, pressedY, mediumDishRadius)||
      !largeEnoughDistanceBetween(mediumDishInit[i].x, mediumDishInit[i].y, pressedX, pressedY, mediumDishRadius)) {
      //curPos=getPosition();
      /* pushMatrix();
       translate(-pressedX, -pressedY);
       sendMessage("You are too close. Try again.");
       popMatrix();*/
      sendMessage(tooClose);
      return;
    }// end if too close
  }//end for loop

  //if the location the at which the mouse was pressed is far enough away from other large dishes, then 
  if (largeEnoughDistanceBetween(mediumDishInit[mCounter].x, mediumDishInit[mCounter].y, pressedX, pressedY, mediumDishRadius)) {
    pushMatrix();        
    translate(pressedX, pressedY);      
    drawMediumDish();   
    //set the location of the present dish to the snapped pressedX and Y values
    mediumDishInit[mCounter].x = pressedX;
    mediumDishInit[mCounter].y = pressedY; 
    println(pressedX);
    popMatrix();
sendMessage(mediumDish);
    //curPos=getPosition();
    /* pushMatrix();
     translate(-pressedX, -pressedY);
     sendMessage("You have drawn a medium dish.");
     popMatrix();*/
    // l.setLabel("you have drawn a medium dish.");
    mCounter++;
  }//end if larger or equal to radius
}

boolean largeEnoughDistanceBetween(float x1, float y1, float x2, float y2, float radius) {
  float temp = sqrt(pow(x1 - x2, 2)+pow(y1 - y2, 2));  
  if (temp<radius) {
    return false;
  }
  return true;
}

void mousePressed() { 
  if (mouseButton == LEFT) {
    pressedX = mouseX;
    pressedY  = mouseY;
    whatSnapLocation();
    sendMessage("Press L or l to see if you can draw a large dish or M or m for a medium dish or press S to stop");
    //println("now pressed x an y are " + pressedX + " " + pressedY);
    //sendMessage(validSelection + "\n" + instructions);
    //drawLargePattern();
  } else {
    sendMessage(rightMouse);
    //println("right mouse pressed was called and pressed x is " + pressedX + " "+ pressedY);
  }
}//end mouse pressed

PVector getPosition () 
{
  PVector buffer = new PVector (pressedX, pressedY);
  return buffer;
}


void sendMessage(String m) {
  fill(255);
  noStroke();
  rect(0, 1800, width, 200);
  fill(0);
  text(m, 15, 1850);
}//message

void drawTinyDishComponent() {
  /*  shape( parallelogram, 0, 0);
   shape(nParallelogram, sTHBase, sTHeight);*/

  image(paraImage, 0, 0);
  //image(nParaImage,sTHBase, sTHeight+tTHeight);
  image(nParaImage, -mTHBase-tTHBase, sTHeight);
}//tiny slice

void drawSmallDishComponent() {
  pushMatrix();
  for (int i = 0; i<2; i++) {
    //shape(pentagon, sTHBase-sTLength*cos(hUAngle), sTHeight + sTLength*sin(hUAngle));
    image(pentaImage, -sTLength*cos(hUAngle), sTHeight + sTLength*sin(hUAngle));
    rotate(radians(-36));
  }
  popMatrix();
}//small slice

void drawMediumDishComponent() {
  pushMatrix();
  for (int i = 0; i<2; i++) {
    //shape(star, 0.5f*sTLength + sTHBase, sTHeight+(0.5f*sTLength)*tan(uAngle));
    //shape(mParallelogram, 0.5f*sTLength + sTHBase, sTHeight+(0.5f*sTLength)*tan(uAngle));
    image(starImage, 0.5f*sTLength + sTHBase, (0.5f*sTLength)*tan(uAngle));
    image(mParaImage, 0.5f*sTLength + sTHBase-sTLength*sin(qUAngle), sTHeight+(0.5f*sTLength)*tan(uAngle));

    rotate(radians(36));
  }
  popMatrix();
}//medium slice


void drawLargeDishComponent() {
  pushMatrix();

  for (int i = 0; i<2; i++) {
    /* shape(pentagon, -xLTHBase, xLTHeight); 
     shape(pentagon, sTHBase, xLTHeight);
     shape(rPentagon, -mTHBase, xLTHeight + lTHeight);
     shape(nParallelogram, mTLength, xLTHeight + sTHeight);
     shape(pentagon, -lTBase-tTHBase, xLTHeight+mTHeight);
     shape(pentagon, 0.5f * mTLength, xLTHeight+mTHeight);
     shape(pentagon, -mTHBase, xLTHeight + lTHeight);
     shape(rStar, -lTLength, 2*xLTHeight);
     shape(rStar, 0, 2*xLTHeight);
     shape(rParallelogram, lTBase + mTHBase, xLTHeight+lTHeight);*/
    image(altAPentaImage, -xLTHBase-sTHBase, xLTHeight); 
    image(altAPentaImage, sTHBase-sTHBase, xLTHeight);
    image(rPentaImage, -mTHBase-sTHBase, xLTHeight + lTHeight+(-0.5f*sTLength)*tan(uAngle));
    image(n1ParaImage, mTLength-mTBase, xLTHeight + sTHeight);
    image(altBPentaImage, -lTBase-tTHBase-sTHBase, xLTHeight+mTHeight);
    image(altBPentaImage, 0.5f * mTLength-sTHBase, xLTHeight+mTHeight);
    image(altCPentaImage, -mTHBase-sTHBase, xLTHeight + lTHeight);
    image(rStarImage, -lTLength, 2*xLTHeight-mTHeight);
    image(rStarImage, 0, 2*xLTHeight-mTHeight);
    image(rParaImage, lTBase + mTHBase-sTHBase, xLTHeight+lTHeight);

    rotate(-hUAngle);
  }
  popMatrix();
}//large slice

void drawMediumDish() {
  pushMatrix();
  for (int i=0; i<5; i++) {
    drawTinyDishComponent();
    drawSmallDishComponent();
    drawMediumDishComponent();
    rotate(uAngle);
  }
  popMatrix();
}//medium

void drawLargeDish() {
  pushMatrix();
  for (int i=0; i<5; i++) {
    drawTinyDishComponent();
    drawSmallDishComponent();
    drawMediumDishComponent();
    drawLargeDishComponent();
    rotate(uAngle);
  }
  popMatrix();
}//large

void whatSnapLocation() {
  //this function will intake the pressedX and pressedY locations and figure out which is the 
  //closest snap coordinates, then it will reassign pressedX and pressedY to those values

  float tempX = 0;
  float tempY = 0;
  float tempDistance = 3000;
  for (int i = 0; i<dots.length; i++) {
    if (sqrt(pow(dots[i].x - pressedX, 2)+pow(dots[i].y - pressedY, 2))<tempDistance) {
      tempX = dots[i].x;
      tempY = dots[i].y;
      tempDistance = sqrt(pow(dots[i].x - pressedX, 2)+pow(dots[i].y - pressedY, 2));
    }
  }
  pressedX = tempX;
  pressedY = tempY;
}//snap


void keyPressed() {
  sendMessage(allKeys);
  
  if (key =='L'||key=='l') {
    drawLargePattern();
  } else if (key == 'M'||key == 'm') {
    drawMediumPattern();
  } 
  else if (key == 'S'||key == 's') {
    save("MillefioriPattern.jpg");
  exit(); 
  } else if (key == 'N'||key == 'n') {    
    getNewFabrics();
  } else if (key == 'H'||key == 'h') {
    sendMessage(allKeys);
  } else {
    return;
  }

  /*
  else if (key == 'B' || key == 'b') {         // When 'B' or 'b' is pressed,
   beginRecord(PDF, "dots_01.pdf");        // start recording to the PDF 
   //look up save
   background(255);                      // Set a white background
   } else if (key == 'E' || key == 'e') {  // When 'E' or 'e' is pressed,
   endRecord();                          // stop recording the PDF and
   exit();  
   }   */
}//keypressed

void star() {
  star = createShape();
  star.beginShape();
  star.vertex( 0, sTHeight);
  star.vertex( sTLength, sTHeight );
  star.vertex( sTLength + sTHBase, 0);
  star.vertex( sTLength + sTBase, sTHeight );
  star.vertex(lTLength, sTHeight);
  star.vertex( sTLength*cos(hUAngle) + sTLength, sTLength * sin(hUAngle)+sTHeight);
  star.vertex(lTLength*cos(hUAngle), lTLength*sin(hUAngle)+sTHeight );
  star.vertex(sTLength + sTHBase, 2*sTHeight);
  star.vertex( lTLength - lTLength * cos(hUAngle), lTLength*sin(hUAngle)+sTHeight);
  star.vertex( sTLength*cos(hUAngle), sTLength * sin(hUAngle)+sTHeight);
  star.endShape(CLOSE);
}

void reflectedStar() {
  rStar = createShape();
  rStar.beginShape();
  rStar.vertex( 0, mTHeight);
  rStar.vertex( sTLength, mTHeight );
  rStar.vertex( sTLength + sTHBase, sTHeight+mTHeight);
  rStar.vertex(sTLength + sTBase, +mTHeight );
  rStar.vertex(lTLength, mTHeight);
  rStar.vertex(sTLength*cos(hUAngle) + sTLength, -sTLength * sin(hUAngle)+mTHeight);
  rStar.vertex(lTLength*cos(hUAngle), 0 );
  rStar.vertex(sTLength + sTHBase, tTHeight);
  rStar.vertex( lTLength - lTLength * cos(hUAngle), 0);
  rStar.vertex( sTLength*cos(hUAngle), -sTLength * sin(hUAngle)+mTHeight);
  rStar.endShape(CLOSE);
}

void parallelogram() {
  //This parallelogram begins at the origin and extends along the x-axis 
  //by one side length. The rest of its coordinates lay in the first quadrant (x,y).
  parallelogram = createShape();
  parallelogram.beginShape();
  parallelogram.vertex(0, 0);
  parallelogram.vertex(sTLength, 0);
  parallelogram.vertex(sTLength + sTHBase, sTHeight);
  parallelogram.vertex(sTHBase, sTHeight);
  parallelogram.endShape(CLOSE);
}

void mirroredParallelogram() {
  //This parallelogram is the same as parallelogram but is mirrored around the x - axis.
  mParallelogram = createShape();
  mParallelogram.beginShape();
  mParallelogram.vertex(sTLength*sin(qUAngle), 0);
  mParallelogram.vertex(sTLength*cos(hUAngle)+sTLength*sin(qUAngle), sTLength*sin(hUAngle));
  mParallelogram.vertex(mTLength*cos(uAngle)+sTLength*sin(qUAngle), mTLength*sin(uAngle));
  mParallelogram.vertex(0, sTLength*cos(qUAngle));
  mParallelogram.endShape(CLOSE);
}

void rotatedParallelogram() {
  //This parallelogram is the same as parallelogram but is rotated by 36 degrees explicitly
  rParallelogram = createShape();
  rParallelogram.beginShape();
  rParallelogram.vertex(sTHBase, 0);
  rParallelogram.vertex(sTLength*cos(hUAngle)+sTHBase, sTLength*sin(hUAngle));
  rParallelogram.vertex(mTHBase+sTHBase, mTHeight);
  rParallelogram.vertex(0, sTHeight);
  rParallelogram.endShape(CLOSE);
}

void narrowParallelogram() {
  //This is a narrow parallelogram equal to two small triangles put end to end. It starts at the origin, extends for one side length along the x- axis 
  //and continues in the positive y direction back the way it came and ends with one of its verts in the second (-x, y) quadrant.
  nParallelogram = createShape();
  nParallelogram.beginShape();
  nParallelogram.vertex(mTBase, 0);
  nParallelogram.vertex(sTLength+mTBase, 0);
  nParallelogram.vertex(tTHBase+mTBase, tTHeight);
  nParallelogram.vertex(-sTLength+mTBase + tTHBase, tTHeight);
  nParallelogram.endShape(CLOSE);
}

void pentagon() {
  //this pentagon shape starts at the origin is flat on top and dips upside down of how you 
  //would expect to see a pentagon. One of the verts is in the second (-x,y) quadrant.
  pentagon = createShape();
  pentagon.beginShape();
  pentagon.vertex(sTHBase, 0);
  pentagon.vertex(sTLength+sTHBase, 0);
  pentagon.vertex(sTHBase + sTLength+sTHBase, sTHeight);
  pentagon.vertex(0.5f*sTLength+sTHBase, (0.5f*sTLength)*tan(uAngle));
  pentagon.vertex(0, sTHeight);
  pentagon.endShape(CLOSE);
}

void reflectedPentagon() {
  //this pentagon shape starts at the origin is flat on bottom and is oriented how you 
  //would expect to see a pentagon. It has two vertices in the 4th quadrant (x,-y) and one in the third quadrant (-x,-y).
  rPentagon = createShape();
  rPentagon.beginShape();
  rPentagon.vertex(sTHBase, (0.5f*sTLength)*tan(uAngle));
  rPentagon.vertex(sTLength+sTHBase, (0.5f*sTLength)*tan(uAngle));
  rPentagon.vertex(sTHBase + sTLength+sTHBase, -sTHeight+(0.5f*sTLength)*tan(uAngle));
  rPentagon.vertex(0.5f*sTLength+sTHBase, 0);
  rPentagon.vertex(0, -sTHeight+(0.5f*sTLength)*tan(uAngle));
  rPentagon.endShape(CLOSE);
}

void validSnaps() {
  //first create new pvectors for all the dots and set them to zero
  for (int i = 0; i<dots.length; i++) {
    dots[i]=new PVector(0, 0);
  }//end for create new vectors

  //hard code the values of the valid snap points
  dots[0].x = xF;   
  dots[0].y = yA;   
  dots[1].x = xM;   
  dots[1].y = yA;
  dots[2].x = xS;   
  dots[2].y = yA;   
  dots[3].x = xZ;   
  dots[3].y = yA;
  dots[4].x = xA;   
  dots[4].y = yB;   
  dots[5].x = xA;   
  dots[5].y = yB;
  dots[6].x = xA;   
  dots[6].y = yB;   
  dots[7].x = xJ;   
  dots[7].y = yB;
  dots[8].x = xV;   
  dots[8].y = yB;   
  dots[9].x = xV;   
  dots[9].y = yB;
  dots[10].x = xV;   
  dots[10].y = yB; 
  dots[11].x = EE;   
  dots[11].y = yB;
  dots[12].x = xL;   
  dots[12].y = yC;   
  dots[13].x = xL;   
  dots[14].y = yC;  
  dots[14].x = xL;   
  dots[14].y = yC;   
  dots[15].x = xT;   
  dots[15].y = yC;
  dots[16].x = xT;   
  dots[16].y = yC;
  dots[17].x = xT;   
  dots[17].y = yC;
  dots[18].x = xF;   
  dots[18].y = yD;   
  dots[19].x = xZ;   
  dots[19].y = yD;
  dots[20].x = xC;   
  dots[20].y = yE;   
  dots[21].x = xI;   
  dots[21].y = yE;
  dots[22].x = xK;   
  dots[22].y = yE;   
  dots[23].x = xP;   
  dots[23].y = yE;
  dots[24].x = xU;   
  dots[24].y = yE;   
  dots[25].x = xW;   
  dots[25].y = yE;
  dots[26].x = CC;
  dots[26].y = yE;
  dots[27].x = xD;
  dots[27].y = yF;
  dots[28].x = xH;
  dots[28].y = yF;
  dots[29].x = xL;
  dots[29].y = yF;
  dots[30].x = xT;
  dots[30].y = yF;
  dots[31].x = xX;
  dots[31].y = yF;
  dots[32].x = BB;
  dots[32].y = yF;
  dots[33].x = xJ;
  dots[33].y = yG;
  dots[34].x = xV;
  dots[34].y = yG;
  dots[35].x = xF;
  dots[35].y = yH;
  dots[36].x = xM;
  dots[36].y = yH;
  dots[37].x = xS;
  dots[37].y = yH;
  dots[38].x = xZ;
  dots[38].y = yH;
  dots[39].x = xM;
  dots[39].y = yH;
  dots[40].x = xA;
  dots[40].y = yJ;
  dots[41].x = xL;
  dots[41].y = yK;
  dots[42].x = xL;
  dots[42].y = yK;
  dots[43].x = EE;
  dots[43].y = yJ;
  dots[44].x = xD;
  dots[44].y = yK;
  dots[45].x = xH;
  dots[45].y = yK;
  dots[46].x = xL;
  dots[46].y = yK;
  dots[47].x = xL;
  dots[47].y = yK;
  dots[48].x = xL;
  dots[48].y = yK;
  dots[49].x = xT;
  dots[49].y = yK;
  dots[50].x = xX;
  dots[50].y = yK;
  dots[51].x = BB;
  dots[51].y = yK;
  dots[52].x = xC;
  dots[52].y = yL;
  dots[53].x = xI;
  dots[53].y = yL;
  dots[54].x = xP;
  dots[54].y = yL;
  dots[55].x = xW;
  dots[55].y = yL;
  dots[56].x = CC;
  dots[56].y = yL;
  dots[57].x = xF;
  dots[57].y = yM;
  dots[58].x = xZ;
  dots[58].y = yM;
  dots[59].x = xA;
  dots[59].y = yN;
  dots[60].x = xE;
  dots[60].y = yN;
  dots[61].x = xJ;
  dots[61].y = yN;
  dots[62].x = xN;
  dots[62].y = yN;
  dots[63].x = xR;
  dots[63].y = yN;
  dots[64].x = xV;
  dots[64].y = yN;
  dots[65].x = AA;
  dots[65].y = yN;
  dots[66].x = EE;
  dots[66].y = yN;
  dots[67].x = xM;
  dots[67].y = yO;
  dots[68].x = xS;
  dots[68].y = yO;
  dots[69].x = xC;
  dots[69].y = yP;
  dots[70].x = xK;
  dots[70].y = yP;
  dots[71].x = xP;
  dots[71].y = yP;
  dots[72].x = xU;
  dots[72].y = yP;
  dots[73].x = CC;
  dots[73].y = yP;
  dots[74].x = xH;
  dots[74].y = yQ;
  dots[75].x = xH;
  dots[75].y = yQ;
  dots[76].x = xH;
  dots[76].y = yQ;
  dots[77].x = xL;
  dots[77].y = yQ;
  dots[78].x = xL;
  dots[78].y = yQ;
  dots[79].x = xL;
  dots[79].y = yQ;
  dots[80].x = xT;
  dots[80].y = yQ;
  dots[81].x = xX;
  dots[81].y = yQ;
  dots[82].x = xX;
  dots[82].y = yQ;
  dots[83].x = xX;
  dots[83].y = yQ;
  dots[84].x = xH;
  dots[84].y = yQ;
  dots[85].x = xH;
  dots[85].y = yQ;
  dots[86].x = xL;
  dots[86].y = yQ;
  dots[87].x = xL;
  dots[87].y = yQ;
  dots[88].x = xX;
  dots[88].y = yQ;
  dots[89].x = xX;
  dots[89].y = yQ;
  dots[90].x = xH;
  dots[90].y = yQ;
  dots[91].x = xL;
  dots[91].y = yQ;
  dots[92].x = xX;
  dots[92].y = yQ;
  dots[93].x = xF;
  dots[93].y = yT;
  dots[94].x = xM;
  dots[94].y = yT;
  dots[95].x = xS;
  dots[95].y = yT;
  dots[96].x = xZ;
  dots[96].y = yT;
}//snaps

void getNewFabrics() {
  imageNum = int(random(100));
  word = getARelatedNumberString(imageNum);

  paraImage=loadImage(getARelatedNumberString(imageNum));
  nParaImage=loadImage(imageStr[int(random(100))]);
  n1ParaImage=loadImage(getARelatedNumberString(imageNum));
  mParaImage=loadImage(imageStr[int(random(100))]);
  rParaImage=loadImage(getARelatedNumberString(imageNum));
  pentaImage=loadImage(imageStr[int(random(100))]);
  altAPentaImage=loadImage(getARelatedNumberString(imageNum));
  altBPentaImage=loadImage(getARelatedNumberString(imageNum));
  rPentaImage=loadImage(imageStr[int(random(100))]);
  altCPentaImage=rPentaImage;
  starImage=loadImage(getARelatedNumberString(imageNum));
  rStarImage=loadImage(imageStr[int(random(100))]);

  paraMask = createGraphics(iWidth, iHeight);
  paraMask.beginDraw();
  paraMask.shape(parallelogram);
  paraMask.endDraw(); 
  paraImage.mask(paraMask);

  rParaMask = createGraphics(iWidth, iHeight);
  rParaMask.beginDraw();
  rParaMask.shape(rParallelogram);
  rParaMask.endDraw(); 
  rParaImage.mask(rParaMask);

  nParaMask = createGraphics(iWidth, iHeight);
  nParaMask.beginDraw();
  nParaMask.shape(nParallelogram);
  nParaMask.endDraw(); 
  nParaImage.mask(nParaMask);

  n1ParaMask = createGraphics(iWidth, iHeight);
  n1ParaMask.beginDraw();
  n1ParaMask.shape(nParallelogram);
  n1ParaMask.endDraw(); 
  n1ParaImage.mask(n1ParaMask);

  mParaMask = createGraphics(iWidth, iHeight);
  mParaMask.beginDraw();
  mParaMask.shape(mParallelogram);
  mParaMask.endDraw(); 
  mParaImage.mask(mParaMask);

  pentaMask = createGraphics(iWidth, iHeight);
  pentaMask.beginDraw();
  pentaMask.shape(pentagon);
  pentaMask.endDraw(); 
  pentaImage.mask(pentaMask);

  altAPentaMask = createGraphics(iWidth, iHeight);
  altAPentaMask.beginDraw();
  altAPentaMask.shape(pentagon);
  altAPentaMask.endDraw(); 
  altAPentaImage.mask(altAPentaMask);

  altBPentaMask = createGraphics(iWidth, iHeight);
  altBPentaMask.beginDraw();
  altBPentaMask.shape(pentagon);
  altBPentaMask.endDraw(); 
  altBPentaImage.mask(altBPentaMask);

  rPentaMask = createGraphics(iWidth, iHeight);
  rPentaMask.beginDraw();
  rPentaMask.shape(rPentagon);
  rPentaMask.endDraw(); 
  rPentaImage.mask(rPentaMask);

  altCPentaMask = createGraphics(iWidth, iHeight);
  altCPentaMask.beginDraw();
  altCPentaMask.shape(pentagon);
  altCPentaMask.endDraw(); 
  altCPentaImage.mask(altCPentaMask);

  starMask = createGraphics(iWidth, iHeight);
  starMask.beginDraw();
  starMask.shape(star);
  starMask.endDraw(); 
  starImage.mask(starMask);

  rStarMask = createGraphics(iWidth, iHeight);
  rStarMask.beginDraw();
  rStarMask.shape(rStar);
  rStarMask.endDraw(); 
  rStarImage.mask(rStarMask);
 fill(255);
  rect(1405,0,800,1800);
  fill(0);
  text("Before doing anything else, left" + "\n" + "mouse click on image" + "\n" + "This is the current fabric selection" + "\n" + "If you like it, then left mouse " + "\n" + 
  "click again somewhere to the left" + "\n" + "in a place of your choosing" 
  + "\n" + "and select either L for a" + "\n" + "large dish or M for a medium dish." + "\n" + "If you do not like the fabric" + "\n" + "selection, then" + "\n" + "press N for a new one." 
  + "\n" + "\n" + "L - Large Dish" + "\n" + "M - Medium Dish" + "\n" + "N - New fabric selection" + "\n" + "S - stops program and " + "\n" + "saves an image", 1415,700);
  pushMatrix();
  translate(1700,300);
  
 // rect(0,0,300,0);
  drawLargeDish();
  popMatrix();
}

String getARelatedNumberString(int num) {
  int temp = num;
  temp = temp%10;
  num = num - temp;
  //println(num);
  switch(num) {
  case 0: 
    imageNum = int(random(10));
    println(imageStr[imageNum]);
    return imageStr[imageNum];  
    //break;
  case 10: 
    imageNum = int(random(0, 30));
    println(imageStr[imageNum]);
    return imageStr[imageNum];  
    //break;
  case 20: 
    imageNum = int(random(10, 40));
    println(imageStr[imageNum]);
    return imageStr[imageNum];  
    // break;
  case 30: 
    imageNum = int(random(20, 50));
    println(imageStr[imageNum]);
    return imageStr[imageNum];  
    //break;
  case 40: 
    imageNum = int(random(30, 60));
    println(imageStr[imageNum]);
    return imageStr[imageNum];  
    // break;
  case 50: 
    imageNum = int(random(40, 70));
    println(imageStr[imageNum]);
    return imageStr[imageNum];  
    // break;
  case 60: 
    imageNum = int(random(50, 80));
    println(imageStr[imageNum]);
    return imageStr[imageNum];  
    // break;
  case 70: 
    imageNum = int(random(60, 90));
    println(imageStr[imageNum]);
    return imageStr[imageNum]; 
    // break;
  case 80: 
    imageNum = int(random(70, 100));
    println(imageStr[imageNum]);
    return imageStr[imageNum];  
    // break;
  case 90: 
    imageNum = int(random(80, 100));
    println(imageStr[imageNum]);
    return imageStr[imageNum];  
    // break;
  }
  return "0_images.jpg";
}