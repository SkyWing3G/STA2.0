//functional
int stagecount=0,
    error=0,
    score=0;
    
//can click on enemy or not
boolean clickOnEnemy = false;
//can click on bottom continer or not
boolean clickOnBottom = true;
//can user click on heal
boolean clickOnHeal = true;
//is the loot open or not
boolean lootOpen = false;
//can open chest or not
boolean canOpenLoot = true;

//ini player charater    
Player player = new Player();

//ini enemies
Enemy en1 = new Enemy(1); 
Enemy en2 = new Enemy(2); 
Enemy en3 = new Enemy(3); 

//how many enemies to spawn
EnemyTracker er = new EnemyTracker();

//generate a random number between 1 to 100
Random100 random100 = new Random100();

//plaers turn
boolean urTurn = true;
//enemys turn
boolean en1Turn = false;
boolean en2Turn = false;
boolean en3Turn = false;

//what text to display
String displayText;

//display hit/get hit/heal effect
//boolean effectTime = false;
//what color to display
int effectColor=1;

void setup() {
  size(800, 600);
  stroke(20);
  frameRate(10);
}

void draw() {
  background(255);
  
  //fill(255);
  //rect(250,450,300,80,10);
  //fill(0);
  //textSize(50);
  //text("LOAD",340,505);
  
  switch(stagecount) {
    //Main Menu
    case 0: 
    
      textSize(80);
      fill(0);
      text("STICKMAN",230,100);
      text("TURN-BASED",180,180);
      text("ADVENTURE",200,260);
      
      //start button
      if (mouseX>250 && mouseX<550 && mouseY>350 && mouseY<430 && urTurn){
        fill(140);
        rect(250,350,300,80,10);
        fill(0);
        textSize(50);
        text("START",330,405);
      
        //click to enter battle
        if(mousePressed){
          stagecount=2;
        }
      }else{
        fill(0);
        textSize(50);
        text("START",330,405);
      }
    break;
    
    //load
    case 1: 
    
    break;
    
    //**battle sceen**
    case 2: 
    //functional

    //*draw maincharacter*
    player.drawPlayer();
    
    //bottom container
    fill(255);
    stroke(0);
    rect(20,400,760,180,10);
    
    //**Attack Heal Void button**
    //*attack button*
    if(mouseX>40 && mouseX<260 && mouseY>420 && mouseY<560 && clickOnBottom){
      //draw the hovered button
      fill(255,100,100);
      rect(40,420,220,140,10);
      
      //text color if allow to click turn black
      if(clickOnBottom){
        fill(255);
        textSize(50);
        text("Attack", 85, 505);
      }else{
        fill(200);
        textSize(50);
        text("Attack", 85, 505);
      }
      
      //allow user to click on enemy
      if(mousePressed){
          clickOnEnemy = true;
      }
       
    }else{
      //text color if allow to click turn red
      if(clickOnBottom){
        fill(255);
        stroke(0);
        rect(40,420,220,140,10);
        fill(255,100,100);
        textSize(50);
        text("Attack", 85, 505);
      }else{
        fill(255);
        stroke(200);
        rect(40,420,220,140,10);
        fill(200);
        textSize(50);
        text("Attack", 85, 505);
      }
    }
    
    //*heal button*
    if(mouseX>290 && mouseX<420 && mouseY>420 && mouseY<560 && urTurn && clickOnBottom && player.healthCheck()){
      //draw the hovered button
      fill(100,200,100);
      rect(290,420,220,140,10);
      
      //text color if allow to click turn black
      if(clickOnBottom){
        fill(255);
        textSize(50);
        text("Heal", 355, 505);
      }else{
        fill(200);
        textSize(50);
        text("Heal", 355, 505);
      }
      
      //allow user to click on enemy
      if(mousePressed){
        player.gainHp();
        drawEffect(1);
        urTurn = false;
        en1Turn = true;
        en2Turn = true;
        en3Turn = true;
        clickOnEnemy = false;
        clickOnBottom = true;
      }
       
    }else{
      //text color if allow to click turn green
      if(clickOnBottom && player.healthCheck()){
        fill(255);
        stroke(0);
        rect(290,420,220,140,10);
        fill(100,200,100);
        textSize(50);
        text("Heal", 355, 505);
      }else{
        fill(255);
        stroke(200);
        rect(290,420,220,140,10);
        fill(200);
        textSize(50);
        text("Heal", 355, 505);
      }
    }
    
    //*void button small chance to loss enemy*
    if(mouseX>540 && mouseX<660 && mouseY>420 && mouseY<560 && urTurn && clickOnBottom){
      //draw the hovered button
      fill(100,100,200);
      rect(540,420,220,140,10);
      
      //text color if allow to click turn black
      if(clickOnBottom){
        fill(255);
        textSize(50);
        text("Void", 605, 505);
      }else{
        fill(200);
        textSize(50);
        text("Void", 605, 505);
      }
      
      //allow user to click on enemy
      if(mousePressed){
        if(random(1,100) > 75){
          er.reduceEnAlive();
        }
        
        urTurn = false;
        en1Turn = true;
        en2Turn = true;
        en3Turn = true;
        clickOnEnemy = false;
        clickOnBottom = true;
      }
       
     }else{
        //text color if allow to click turn green
        if(clickOnBottom){
          fill(255);
          stroke(0);
          rect(540,420,220,140,10);
          fill(100,100,200);
          textSize(50);
          text("Void", 605, 505);
        }else{
          fill(255);
          stroke(200);
          rect(540,420,220,140,10);
          fill(200);
          textSize(50);
          text("Void", 605, 505);
      }
    }
    
    //**spawn enemies**
    //**draw the right foe**
    if(er.loadEnAlive() >= 1 && en1.enHp() > 0){
      
      en1.drawFoe(en1.enHp());
      
      //*players movement*
      if(urTurn && clickOnEnemy){
        //disable bottom click
        clickOnBottom = false;
        
        //allow click on enemy
        en1.clickEnemy();
        
       //user attack on their turn
       if(en1.clickEnemy() && urTurn){
         
         en1.lowerHp(player.attack());
         drawEffect(3);
         urTurn = false;
         en1Turn = true;
         en2Turn = true;
         en3Turn = true;
         clickOnEnemy = false;
         clickOnBottom = true;
       }
      }
      
      //**enemys movement**
      if(en1Turn && en1.enHp() > 0){
        player.beenHit(en1.enAttack());
        drawEffect(0);
        //check if the player is alive
        if(!player.isAlive()){
          //if dead end game
          en1Turn = false;
          en2Turn = false;
          en3Turn = false;
          stagecount=12;
        }else{
          //if not keep play
          en1Turn = false;
          urTurn = true;
        }

      }else if (en1Turn && en1.enHp() <= 0){
        //if enemy health = 0 go to next stage
        er.reduceEnAlive();
        score += 50;
      }
    }
    
    //**draw the middle foe**
    if(er.loadEnAlive() >= 2 && en2.enHp() > 0){
      
      en2.drawFoe(en2.enHp());
      
      //*players movement*
      if(urTurn && clickOnEnemy){
        //disable bottom click
        clickOnBottom = false;
        
        //allow click on enemy
        en2.clickEnemy();
        
       //user attack on their turn
       if(en2.clickEnemy() && urTurn){
         
         en2.lowerHp(player.attack());
         drawEffect(3);
         urTurn = false;
         en1Turn = true;
         en2Turn = true;
         en3Turn = true;
         clickOnEnemy = false;
         clickOnBottom = true;
       }
      }
      
      //**enemys movement**
      if(en2Turn && en2.enHp() > 0){
        player.beenHit(en2.enAttack());
        drawEffect(0);
        //check if the player is alive
        if(!player.isAlive()){
          //if dead end game
          en1Turn = false;
          en2Turn = false;
          en3Turn = false;
          stagecount=12;
        }else{
          //if not keep play
          en2Turn = false;
          //urTurn = true;
        }

      }else if (en2Turn && en2.enHp() <= 0){
        //if enemy health = 0 go to next stage
        er.reduceEnAlive();
        score += 50;
      }
    }
    
    //**draw the left foe**
    if(er.loadEnAlive() == 3 && en3.enHp() > 0){
      
      en3.drawFoe(en3.enHp());
      
      //*players movement*
      if(urTurn && clickOnEnemy){
        //disable bottom click
        clickOnBottom = false;
        
        //allow click on enemy
        en3.clickEnemy();
        
       //user attack on their turn
       if(en3.clickEnemy() && urTurn){
         
         en3.lowerHp(player.attack());
         drawEffect(3);
         urTurn = false;
         en1Turn = true;
         en2Turn = true;
         en3Turn = true;
         clickOnEnemy = false;
         clickOnBottom = true;
       }
      }
      
      //**enemys movement**
      if(en3Turn && en3.enHp() > 0){
        player.beenHit(en3.enAttack());
        drawEffect(0);
        //check if the player is alive
        if(!player.isAlive()){
          //if dead end game
          en1Turn = false;
          en2Turn = false;
          en3Turn = false;
          stagecount=12;
        }else{
          //if not keep play
          en3Turn = false;
          //urTurn = true;
        }

      }else if (en3Turn && en3.enHp() <= 0){
        //if enemy health = 0 go to next stage
        er.reduceEnAlive();
        score += 50;
      }
    }
    
    //if no enemy left move to next stage
    if (er.loadEnAlive() <= 0){
      stagecount=3;
      er.reset();
    }
    break;
    
    //loot menu
    case 3:
      //*draw maincharacter*
      player.drawPlayer();
    
      //bottom container
      fill(255);
      stroke(0);
      rect(20,400,760,180,10);
      //draw village
      //drawVillage();
      
      //draw open button
      if(mouseX>40 && mouseX<260 && mouseY>420 && mouseY<560 && canOpenLoot){
        fill(255,225,0);
        noStroke();
        rect(40,420,220,140,10);
        fill(255);
        textSize(50);
        text("Open", 90, 505);
        
        //check if mouse clicked or not
        if(mousePressed){
          lootOpen = !lootOpen;
          canOpenLoot = false;
          
          //random loot
          if(random100.loadRandom()>95){
            player.gainMaxHp((int)random(1,10));
            displayText = "You gain max health";
            score += 100;
            random100.reset();
          }else if(random100.loadRandom() > 65){
            player.gainHeal((int)random(1,5));
            displayText = "You gain more heal power";
            score += 5;
            random100.reset();
          }else if(random100.loadRandom() > 15){
            player.gainAttack((int)random(1,5));
            displayText = "You gain more attack";
            score += 1;
            random100.reset();
          }else{
            displayText = "You found nothing";
            random100.reset();
            score += 1;
          }
        }
         
      }else{
        //disabled button color grey else black
        if(canOpenLoot){
          fill(255);
          stroke(0);
          rect(40,420,220,140,10);
          fill(0);
        }else{
          fill(255);
          stroke(150);
          rect(40,420,220,140,10);
          fill(150);
        }
        textSize(50);
        text("Open", 90, 505);
      }
      
      //draw display text
      //if chest can be opened display default text
      if(canOpenLoot){
        displayText = "You found some loot";
      }
      textSize(20);
      text(displayText,320,460,200,100);
      
      //move on button
      if(mouseX>540 && mouseX<660 && mouseY>420 && mouseY<560){
        fill(150);
        noStroke();
        rect(540,420,220,140,10);
        fill(255);
        textSize(50);
        text("Moveon", 570, 505);
        
        //check if mouse clicked or not
        if(mousePressed){
          if(random(100)>75){
            lootOpen=false;
            stagecount=4;
          }else{
            lootOpen=false;
            er.reset();
            en1.restEn();
            en2.restEn();
            en3.restEn();
            en1Turn = false;
            en2Turn = false;
            en3Turn = false;
            urTurn = true;
            stagecount=2;
          }
          
          canOpenLoot = true;
        }
      }else{
        fill(255);
        stroke(150);
        rect(540,420,220,140,10);
        fill(0);
        textSize(50);
        text("Moveon", 570, 505);
      }

      //draw chest
      stroke(0);
      if(lootOpen){
        fill(155);
        rect(500,70,150,80);
      }else{
        fill(255);
        rect(500,100,150,50);
      }
      
      fill(255);
      rect(500,150,150,100);
      rect(560,150,30,20);
    
     break;
     
     //village healing boost MaxHp
     case 4:
      //draw village
      drawVillage();
    
      //*draw maincharacter*
      player.drawPlayer();
    
      //bottom container
      fill(255);
      stroke(0);
      rect(20,400,760,180,10);
      
      //rest button
      if(mouseX>40 && mouseX<260 && mouseY>420 && mouseY<560 && canOpenLoot){
        fill(100,200,100);
        noStroke();
        rect(40,420,220,140,10);
        fill(255);
        textSize(50);
        text("Rest", 90, 505);
        
        //check if mouse clicked or not
        if(mousePressed){
          lootOpen = !lootOpen;
          canOpenLoot = false;
          
          player.gainMaxHp(0);
          displayText = "You are fully healed";
          
        }
         
      }else{
        //disabled button color grey else black
        if(canOpenLoot){
          fill(255);
          stroke(0);
          rect(40,420,220,140,10);
          fill(0);
        }else{
          fill(255);
          stroke(150);
          rect(40,420,220,140,10);
          fill(150);
        }
        textSize(50);
        text("Rest", 90, 505);
      }
      
      //draw display text
      //if chest can be opened display default text
      if(canOpenLoot){
        displayText = "You found a safe house";
      }
      fill(0);
      textSize(20);
      text(displayText,320,460,200,100);
    
      //move on button
      if(mouseX>540 && mouseX<660 && mouseY>420 && mouseY<560){
        fill(150);
        noStroke();
        rect(540,420,220,140,10);
        fill(255);
        textSize(50);
        text("Moveon", 570, 505);
        
        //check if mouse clicked or not
        if(mousePressed){
          if(random(100)>50){
            lootOpen=false;
            stagecount=3;
          }else{
            lootOpen=false;
            er.reset();
            en1.restEn();
            en2.restEn();
            en3.restEn();
            en1Turn = false;
            en2Turn = false;
            en3Turn = false;
            urTurn = true;
            stagecount=2;
          }
          canOpenLoot = true;
        }
      }else{
        fill(255);
        stroke(150);
        rect(540,420,220,140,10);
        fill(0);
        textSize(50);
        text("Moveon", 570, 505);
      }

     break;
    
    //End Screen
    case 12:
      fill(0);
      textSize(80);
      text("Game Over",225,200);
      textSize(50);
      text("Score : " + score, 230,270);
      
      //quit
      if (mouseX>250 && mouseX<550 && mouseY>450 && mouseY<530){
        fill(140);
        rect(250,450,300,80,10);
        fill(0);
        textSize(50);
        text("Quit",350,505);
      
        //click to enter battle
        if(mousePressed){
          exit(); 
        }
      }else{
        fill(0);
        textSize(50);
        text("Quit",350,505);
      }
    break;
  }
}

//save random numbers
class EnemyTracker{
  int enAlive;
  
  EnemyTracker(){
    enAlive = (int)random(1,3);
  }
  
  //reduce enemies
  void reduceEnAlive(){
    if(enAlive >= 1){
      enAlive -= 1;
    }else{
      enAlive = 0;
    }
  }
  
  //return saved value
  int loadEnAlive(){
    return enAlive;
  }
  
  //refreash the saved random number
  void reset(){
    enAlive = (int)random(1,3);
  }
}

//save random number
class Random100{
  int randNum;
  
  Random100(){
    randNum = (int)random(1,100);
  }
  
  //return saved value
  int loadRandom(){
    return randNum;
  }
  
  //refreash the saved random number
  void reset(){
    randNum = (int)random(1,100);
  }
}

//create enemy class bandit
class Enemy{
  //location
  int xpos, ypos;
  //status
  int maxHp, curHp, attack, heal;
  
  //setup enemy
  Enemy(int e){
    maxHp = 10;
    curHp = 10;
    attack = 5;
    heal = 0;
    
    if(e == 1){
      xpos = 650;
      ypos = 130;
    }else if(e==2){
      xpos = 500;
      ypos = 130;
    }else if(e==3){
      xpos = 350;
      ypos = 130;
    }
  }
  
  //return attack
  int enAttack(){
    return attack;
  }
  //return the current hp
  int enHp(){
    return curHp;
  }
  
  //draw enemy and their status
  void drawFoe(int hpDisplay){
    //Statues
    fill(255,100,100);
    textSize(20);
    text("HP: " + hpDisplay,xpos-30, ypos-70);
    fill(120);
    text("Attack: " + attack,xpos-40, ypos-45);
  
    fill(255);
    stroke(0);
    //head
    ellipse(xpos, ypos, 50,50);
    //body?
    line(xpos, ypos+25, xpos, ypos+100);
    //leftarm
    line(xpos, ypos+25, xpos-30, ypos+80);
    //rightarm
    line(xpos, ypos+25, xpos+30, ypos+80);
    //leftleg
    line(xpos, ypos+100, xpos-30, ypos+150);
    //rightleg
    line(xpos, ypos+100, xpos+30, ypos+150);
  }
  
  //control click on enemy
  //int mainCharaAttack
  boolean clickEnemy (){
    boolean clicked=false;
    noStroke();
    
    if(mouseX>xpos-50 && mouseX<xpos+50 && mouseY>ypos-100 && mouseY<ypos+160){
      //onclick hit enemy
      if(mousePressed){
       fill(155);
       textSize(100);
       text("Hit",xpos-50, ypos);
       clicked=true;
      }
    
      //on hover change color
      fill(50,50,50,50);
    }else{
      noFill();
      clicked=false;
    }
  
    rect(xpos-50,ypos-100,100,260,10);
    stroke(20);
    return clicked;
  }
  
  //after enemy get hit reduce their current hp
  void lowerHp(int damage){
    if(curHp-damage > 0){
      curHp -= damage;
    }else{
      curHp = 0;
    }
  }
  
  //reset enemy status
  void restEn(){
    maxHp = 10;
    curHp = 10;
    attack = 5;
    heal = 0;
  }
}

//draw effect or not
void drawEffect(int effectColor){
  
  noStroke();
  if(effectColor==0){
    //enemy attack red
    fill(255,100,100,155);
  }else if(effectColor==1){
    //heal green
    fill(100,255,100,155);
  }else if(effectColor==2){
    //chest gold
    fill(255,225,0,155);
  }else{
    //default player hit enemy grey
    fill(80,80,80,155);
  }
  
  //left&right
  rect(0,0,100,600);
  rect(700,0,100,600);
  //up&down
  rect(100,0,600,100);
  rect(100,500,600,100);
  stroke(20);
      
}

//Main character class tracking hp a/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Player {
  int maxHp = 50;
  int curHp = 50;
  int attack = 5;
  int heal = 10;
  
  boolean alive = true;
  
  //draw main character
  void drawPlayer(){
    float xpos=200, ypos=230;
    fill(255);
    stroke(0);
    //head
    ellipse(xpos, ypos, 100,100);
    //body?
    line(xpos, ypos+50, xpos-20, ypos+200);
    //leftarm
    line(xpos, ypos+50, xpos-70, ypos+120);
    //rightarm
    line(xpos, ypos+50, xpos+50, ypos+120);
    
    //status
    fill(30,200,30);
    textSize(30);
    text("HP: "+curHp,260,390);
    fill(120);
    text("Attack: "+attack,400,390);
    fill(255,150,150);
    text("Heal: "+heal,560,390);
  }
  
  boolean healthCheck(){
    boolean temp = true;
    //if maxhp reached return false
    if(curHp == maxHp){
      temp = false;
    }
    return temp;    
  }
  
  //gain more heal
  void gainHeal(int gain){
    heal += gain;
  }
  
  //gain more attack
  void gainAttack(int gain){
    attack += gain;
  }
  
  //gain more Max Hp
  void gainMaxHp(int gain){
    maxHp += gain;
    curHp = maxHp;
  }
  
  //gain more Current Hp
  void gainHp(){
    if(curHp + heal < maxHp){
      curHp += heal;
    }else{
      curHp = maxHp;
    }
  }
  
  //loose hp
  void beenHit(int enAttack){
    if(curHp-enAttack <= 0){
      curHp = 0;
      alive = false;
    }else{
      curHp -= enAttack;
    }
  }
  
  //check if the player is still alive
  boolean isAlive(){
    return alive;
  }
  
  //return attack
  int attack(){
    return attack;
  }
}

void drawVillage(){
  float xpos=350, ypos=50;
  fill(255);
  stroke(20);
  //roof
  triangle(xpos+100,ypos,xpos,ypos+100,xpos+200,ypos+100);
  line(xpos+100, ypos, xpos+300, ypos);
  line(xpos+300, ypos, xpos+400, ypos+100);
  line(xpos+400, ypos+100, xpos+200,ypos+100);
  rect(xpos+230, ypos-30,50,30);
  //body
  rect(xpos+30,ypos+100,340,150);
  line(xpos+170,ypos+100,xpos+170,ypos+250);
  rect(xpos+100,ypos+130,50,120);
  rect(xpos+200,ypos+130,30,30);
  rect(xpos+230,ypos+130,30,30);
  rect(xpos+200,ypos+160,30,30);
  rect(xpos+230,ypos+160,30,30);
}
