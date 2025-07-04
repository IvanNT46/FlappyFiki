import processing.sound.*;
SoundFile music;

PImage backg, fiki, TopPipe, BotPipe;
int fikiX, fikiY, gravity, VelofikiY, gameState, score;
int[] pipeX, pipeY;

void setup(){
  size(800, 620);
  backg = loadImage("./img/background.jpg");
  
  fiki = loadImage("./img/fiki.png");
  fikiX = 100;
  fikiY = 50;
  gravity = 1;
  
  pipeX = new int[5];
  pipeY = new int[pipeX.length];
  BotPipe = loadImage("./img/BotPipe.png");
  TopPipe = loadImage("./img/TopPipe.png");
  for(int i = 0; i < pipeX.length; i++)
  {
    pipeX[i] = width + 200*i;
    pipeY[i] = (int)random(-250, 150);
  }
  gameState = -1;
  
  music = new SoundFile(this, "./music/OtpusniSe.mp3");
  music.loop();
  music.rate(1.09);
  
}

void draw(){
  if(gameState == -1)
  {
    startScreen();
  }
  else if(gameState == 0)
  {
    image(backg, -350, 0);
    Pipes();
    Fiki();
    Score();
  }
  else
  {
    fill(255);
    textSize(32);
    text("You Lost", 20, 100);
    text("Click To Restart", 20, 150);
    if(mousePressed){
      Restart();
    }
  }
}

void startScreen()
{
  image(backg, -350, 0);
  image(fiki,fikiX,height/2);
  textSize(45);
  text("Click to Start!", 100, 100);
  if(mousePressed)
  {
    fikiY = height/2;
    gameState = 0;
  }
}

void Fiki()
{
  image(fiki, fikiX, fikiY);
  fikiY = fikiY + VelofikiY;
  VelofikiY = VelofikiY + gravity;
  if(fikiY > height - 32 || fikiY < 0)
  {
    gameState = 1;
  }
  
}

void Pipes()
{
  for(int i = 0; i < pipeX.length; i++)
  {
    image(TopPipe, pipeX[i], pipeY[i] - 200);
    image(BotPipe, pipeX[i], pipeY[i] + 500);
    pipeX[i]-=4;
    if(pipeX[i] < -200)
    {
      pipeX[i] = width;
    }
    if(fikiX > (pipeX[i] - 32) && fikiX < pipeX[i] + 29)
    {
      if(!(fikiY > pipeY[i] + 250 && fikiY < pipeY[i] + 500-45))
      {
        gameState = 1;
      }
      else if (fikiX == pipeX[i] || fikiX == pipeX[i] + 1)
      {
        score++;
      }
    }
  }
}

void Score()
{
  fill(0);
  textSize(32);
  text("SCORE: " + score, width - 170, 40);
}

void Restart(){
    fikiY = height / 2;
    VelofikiY = 0;
    for(int i = 0; i < pipeX.length; i++)
    {
      pipeX[i] = width + 200 * i;
      pipeY[i] = (int)random(-250, 150);
    }
    score = 0;
    gameState = 0;
    mousePressed();
}

void mousePressed()
{
  VelofikiY = -15;
}
