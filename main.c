/*
** Portable barely playable chasing game
**
** Fabrizio Caruso (fabrizio_caruso@hotmail.com)
**
*/

#include <stdlib.h>
#include <string.h>

#include <stdio.h>

#include <conio.h>

#include <unistd.h>

#include <time.h>

// If two ghosts bump into eachother you get 2500 points for each ghost
#define GHOST_VS_GHOST_BONUS 2500ul

// If a ghost bumps into a bomb
#define GHOST_VS_BOMBS_BONUS 1000ul

// Extra points for the power up
#define POWER_UP_BONUS 500ul

// Points for each tick
#define LOOP_POINTS 10ul

// Points gained at the end of each level
#define LEVEL_BONUS 5000ul

// Number of levels
#define FINAL_LEVEL 10

unsigned int ghostSlowDown;
unsigned int powerUpCoolDown;
unsigned int ghostLevel = 1u;
unsigned long points = 0ul;
unsigned int ghostSmartness = 1u; // 9u is max = impossible 


// Level
// The level affects:
// 1. powerUpCoolDown (how long before a new powerUp is spawned)
// 2. ghostSlowDown (how much the power up slows the enemies down)
// 3. toggleHunters (how fast the ghosts are woken up at level start-up)
// 4. ghostSmartness (how smart ghosts are in avoiding their death)
// 5. invincibleXCountDown (time needed to acticate the invincible ghost)
// 7. invincibleYCountDown
// 6. invincibleSlowDown (how much the invincible ghost is slowed-down)
// 7. microSleep (how fast the game runs)
unsigned short level = 1;

unsigned int invincibleXCountDown = 100;
unsigned int invincibleYCountDown = 100;
unsigned int invincibleSlowDown = 30000;
unsigned int invincibleLoopTrigger = 1000;
unsigned short ghostCount = 8;
unsigned short invincibleGhostCountTrigger = 2;

struct CharacterStruct
{
	// character coordinates
	int _x;
	int _y;
	
	// how to display the character (i.e., which ASCII character to use
	char _ch;
	
	// _status decides whether the character is active
	short _status;
	
	//_alive decides whether it is dead or alive
	short _alive;
	
};

typedef struct CharacterStruct Character;

void setCharacterPosition(Character* characterPtr, int x, int y)
{
	characterPtr->_x = x;
	characterPtr->_y = y;
}

void setCharacterDisplay(Character* characterPtr, char ch)
{
	characterPtr->_ch = ch;
}

void deleteCharacter(Character* characterPtr)
{
	gotoxy(characterPtr->_x,characterPtr->_y);
	cputc(' ');
}

void displayCharacter(Character* characterPtr)
{
	gotoxy(characterPtr->_x,characterPtr->_y);
	cputc(characterPtr->_ch);
}

int isCharacterAtLocation(int x, int y, Character * characterPtr)
{
	return(characterPtr->_x==x) && (characterPtr->_y==y);
}

int areCharctersAtSamePosition(Character* lhs, Character* rhs)
{
	return (lhs->_x==rhs->_x)&&(lhs->_y==rhs->_y);
}

int leftDanger(Character* characterPtr, Character* bombPtr)
{
	return (characterPtr->_y == bombPtr->_y) && (characterPtr->_x-1 == bombPtr->_x);
}

int rightDanger(Character* characterPtr, Character* bombPtr)
{
	return (characterPtr->_y == bombPtr->_y) && (characterPtr->_x+1 == bombPtr->_x);	  
}

int upDanger(Character* characterPtr, Character* bombPtr)
{
	return (characterPtr->_x == bombPtr->_x) && (characterPtr->_y-1 == bombPtr->_y);
}

int downDanger(Character* characterPtr, Character* bombPtr)
{
	return (characterPtr->_x == bombPtr->_x) && (characterPtr->_y+1 == bombPtr->_y);	  
}


int leftBombs(Character* characterPtr, 
              Character* bombPtr1,  Character* bombPtr2, 
              Character* bombPtr3,  Character* bombPtr4)
{
	return leftDanger(characterPtr, bombPtr1) || leftDanger(characterPtr, bombPtr2) || 
	       leftDanger(characterPtr, bombPtr3) || leftDanger(characterPtr, bombPtr4);
}

int rightBombs(Character* characterPtr, 
              Character* bombPtr1,  Character* bombPtr2, 
              Character* bombPtr3,  Character* bombPtr4)
{
	return rightDanger(characterPtr, bombPtr1) || rightDanger(characterPtr, bombPtr2) || 
	       rightDanger(characterPtr, bombPtr3) || rightDanger(characterPtr, bombPtr4);
}

int upBombs(Character* characterPtr, 
              Character* bombPtr1,  Character* bombPtr2, 
              Character* bombPtr3,  Character* bombPtr4)
{
	return upDanger(characterPtr, bombPtr1) || upDanger(characterPtr, bombPtr2) || 
	       upDanger(characterPtr, bombPtr3) || upDanger(characterPtr, bombPtr4);
}

int downBombs(Character* characterPtr, 
              Character* bombPtr1,  Character* bombPtr2, 
              Character* bombPtr3,  Character* bombPtr4)
{
	return downDanger(characterPtr, bombPtr1) || downDanger(characterPtr, bombPtr2) || 
	       downDanger(characterPtr, bombPtr3) || downDanger(characterPtr, bombPtr4);
}




int leftGhosts(Character* characterPtr, 
              Character* ghostPtr1,  Character* ghostPtr2, 
              Character* ghostPtr3,  Character* ghostPtr4,
              Character* ghostPtr5,  Character* ghostPtr6, 
              Character* ghostPtr7)
{
	return leftDanger(characterPtr, ghostPtr1) || leftDanger(characterPtr, ghostPtr2) || 
	       leftDanger(characterPtr, ghostPtr3) || leftDanger(characterPtr, ghostPtr4) ||
		   leftDanger(characterPtr, ghostPtr5) || leftDanger(characterPtr, ghostPtr6) || 
		   leftDanger(characterPtr, ghostPtr7);
}

int rightGhosts(Character* characterPtr, 
              Character* ghostPtr1,  Character* ghostPtr2, 
              Character* ghostPtr3,  Character* ghostPtr4,
              Character* ghostPtr5,  Character* ghostPtr6, 
              Character* ghostPtr7)
{
	return rightDanger(characterPtr, ghostPtr1) || rightDanger(characterPtr, ghostPtr2) || 
	       rightDanger(characterPtr, ghostPtr3) || rightDanger(characterPtr, ghostPtr4) ||
		   rightDanger(characterPtr, ghostPtr5) || rightDanger(characterPtr, ghostPtr6) || 
		   rightDanger(characterPtr, ghostPtr7);
}

int upGhosts(Character* characterPtr, 
              Character* ghostPtr1,  Character* ghostPtr2, 
              Character* ghostPtr3,  Character* ghostPtr4,
              Character* ghostPtr5,  Character* ghostPtr6, 
              Character* ghostPtr7)
{
	return upDanger(characterPtr, ghostPtr1) || upDanger(characterPtr, ghostPtr2) || 
		   upDanger(characterPtr, ghostPtr3) || upDanger(characterPtr, ghostPtr4) || 
	       upDanger(characterPtr, ghostPtr5) || upDanger(characterPtr, ghostPtr6) ||
		   upDanger(characterPtr, ghostPtr7);
}

int downGhosts(Character* characterPtr, 
              Character* ghostPtr1,  Character* ghostPtr2, 
              Character* ghostPtr3,  Character* ghostPtr4,
              Character* ghostPtr5,  Character* ghostPtr6, 
              Character* ghostPtr7)
{
	return downDanger(characterPtr, ghostPtr1) || downDanger(characterPtr, ghostPtr2) || 
	       downDanger(characterPtr, ghostPtr3) || downDanger(characterPtr, ghostPtr4) ||
		   downDanger(characterPtr, ghostPtr5) || downDanger(characterPtr, ghostPtr6) ||
		   downDanger(characterPtr, ghostPtr7);
}



void chaseCharacterXAvoidBombStrategy(Character* hunterPtr, Character* preyPtr, 
                    Character* bombPtr1, Character* bombPtr2,
					Character* bombPtr3, Character* bombPtr4,
					Character* ghostPtr1, Character *ghostPtr2, Character* ghostPtr3, Character *ghostPtr4,
					Character* ghostPtr5, Character *ghostPtr6, Character* ghostPtr7)
{
	if(!rightBombs(hunterPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4) && 
	   !rightGhosts(hunterPtr, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7) &&
	   hunterPtr->_x<preyPtr->_x)
	{
		deleteCharacter(hunterPtr);
		++hunterPtr->_x;
	}
	else if(!leftBombs(hunterPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4) && 
	        !leftGhosts(hunterPtr, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7) &&
	         hunterPtr->_x>preyPtr->_x)
	{
		deleteCharacter(hunterPtr);
		--hunterPtr->_x;
	}
	else if(!downBombs(hunterPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4) && 
			!downGhosts(hunterPtr, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7) &&
	        hunterPtr->_y<preyPtr->_y)
	{
		deleteCharacter(hunterPtr);
		++hunterPtr->_y;
	}
	else if(!upBombs(hunterPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4) && 
			!upGhosts(hunterPtr, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7) &&
	        hunterPtr->_y>preyPtr->_y)
	{
		deleteCharacter(hunterPtr);
		--hunterPtr->_y;
	}
	displayCharacter(hunterPtr);
}

void chaseCharacterXStrategy(Character* hunterPtr, Character* preyPtr)
{
	if(hunterPtr->_x<preyPtr->_x)
	{
		deleteCharacter(hunterPtr);
		++hunterPtr->_x;
	}
	else if(hunterPtr->_x>preyPtr->_x)
	{
		deleteCharacter(hunterPtr);
		--hunterPtr->_x;
	}
	else if(hunterPtr->_y<preyPtr->_y)
	{
		deleteCharacter(hunterPtr);
		++hunterPtr->_y;
	}
	else if(hunterPtr->_y>preyPtr->_y)
	{
		deleteCharacter(hunterPtr);
		--hunterPtr->_y;
	}
	displayCharacter(hunterPtr);
}

void chaseCharacterYAvoidBombStrategy(Character* hunterPtr, Character* preyPtr, 
                    Character* bombPtr1, Character* bombPtr2,
					Character* bombPtr3, Character* bombPtr4,
					Character* ghostPtr1, Character *ghostPtr2, Character* ghostPtr3, Character *ghostPtr4,
					Character* ghostPtr5, Character *ghostPtr6, Character* ghostPtr7)
{
    if(!downBombs(hunterPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4) && 
	   !downGhosts(hunterPtr, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7) &&
		hunterPtr->_y<preyPtr->_y)
	{
		deleteCharacter(hunterPtr);
		++hunterPtr->_y;
	}
	else if(!upBombs(hunterPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4) && 
	        !upGhosts(hunterPtr, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7) &&
	        hunterPtr->_y>preyPtr->_y)
	{
		deleteCharacter(hunterPtr);
		--hunterPtr->_y;
	}
	else if(!rightBombs(hunterPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4) && 
			!rightGhosts(hunterPtr, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7) &&
			hunterPtr->_x<preyPtr->_x)
	{
		deleteCharacter(hunterPtr);
		++hunterPtr->_x;
	}
	else if(!leftBombs(hunterPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4) && 
			!leftGhosts(hunterPtr, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7) &&
			hunterPtr->_x>preyPtr->_x) 
	{
		deleteCharacter(hunterPtr);
		--hunterPtr->_x;
	}

	displayCharacter(hunterPtr);
}

void chaseCharacterYStrategy(Character* hunterPtr, Character* preyPtr)
{
    if(hunterPtr->_y<preyPtr->_y)
	{
		deleteCharacter(hunterPtr);
		++hunterPtr->_y;
	}
	else if(hunterPtr->_y>preyPtr->_y)
	{
		deleteCharacter(hunterPtr);
		--hunterPtr->_y;
	}
	else if(hunterPtr->_x<preyPtr->_x)
	{
		deleteCharacter(hunterPtr);
		++hunterPtr->_x;
	}
	else if(hunterPtr->_x>preyPtr->_x)
	{
		deleteCharacter(hunterPtr);
		--hunterPtr->_x;
	}

	displayCharacter(hunterPtr);
}

void chaseCharacter(Character* hunterPtr, Character* preyPtr, 
                    Character* bombPtr1, Character* bombPtr2,
					Character* bombPtr3, Character* bombPtr4,
					Character* ghostPtr1, Character *ghostPtr2, Character* ghostPtr3, Character *ghostPtr4,
					Character* ghostPtr5, Character *ghostPtr6, Character* ghostPtr7)
{
	if(rand()%10 > ghostSmartness)
	{
		if(rand()%2) // Select chase strategy
		{
			chaseCharacterXStrategy(hunterPtr, preyPtr);
		}
		else
		{
			chaseCharacterYStrategy(hunterPtr, preyPtr);
		}
	}
	else
	{
		if(rand()%2) // Select chase strategy
		{
			chaseCharacterXAvoidBombStrategy(hunterPtr, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
			ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7);
		}
		else
		{
			chaseCharacterYAvoidBombStrategy(hunterPtr, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
			ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7);
		}
	}
}


void blindChaseCharacter(Character* hunterPtr, Character* preyPtr)
{
	if((hunterPtr->_status==1) && (hunterPtr->_alive==1))
	{
		if(rand()>invincibleSlowDown)
		{
			if(rand()%2) // Select chase strategy
			{
				chaseCharacterXStrategy(hunterPtr, preyPtr);
			}
			else
			{
				chaseCharacterYStrategy(hunterPtr, preyPtr);
			}
		}
	}
}


void chaseCharacterIf(Character* ghostPtr1, Character* preyPtr, 
                    Character* bombPtr1, Character* bombPtr2,
					Character* bombPtr3, Character* bombPtr4,
					Character *ghostPtr2, Character* ghostPtr3, Character *ghostPtr4,
					Character* ghostPtr5, Character *ghostPtr6, Character* ghostPtr7, Character* ghostPtr8)
{
	if((ghostPtr1->_status==1) && (ghostPtr1->_alive==1))
	{
		if(rand()>ghostSlowDown)
		{
			chaseCharacter(ghostPtr1, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4, 
			ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);
		}
		else 
		{
			displayCharacter(ghostPtr1);
		}
	}
}					 

void chasePlayer(Character * ghostPtr1, Character * ghostPtr2, 
                 Character * ghostPtr3, Character * ghostPtr4,
				 Character * ghostPtr5, Character * ghostPtr6, 
                 Character * ghostPtr7, Character * ghostPtr8, 
                 Character* preyPtr, 
                 Character* bombPtr1, Character* bombPtr2,
				 Character* bombPtr3, Character* bombPtr4
				 )
{
	chaseCharacterIf(ghostPtr1, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
	ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);
	
	chaseCharacterIf(ghostPtr2, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
	ghostPtr1, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);
	
	chaseCharacterIf(ghostPtr3, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
	ghostPtr1, ghostPtr2, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);
	
	chaseCharacterIf(ghostPtr4, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
	ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);
    
	chaseCharacterIf(ghostPtr5, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
	ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr6, ghostPtr7, ghostPtr8);
	
	chaseCharacterIf(ghostPtr6, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
	ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr7, ghostPtr8);
	
	chaseCharacterIf(ghostPtr7, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
	ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr8);
	
	chaseCharacterIf(ghostPtr8, preyPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4,
	ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7);
}

void displayScore(unsigned long points)
{
	// Draw score 
	gotoxy(2,2);
	cputs("SCORE: ");
	
	gotoxy(9,2);
	cputs("       ");
	gotoxy(9,2);
	cprintf("%lu",points);
}

void displayGhostLevel()
{
	// Draw score 
	gotoxy(2,1);
	cputs("SPEED: ");
	
	gotoxy(9,1);
	cputs("       ");
	gotoxy(9,1);
	cprintf("%u",ghostLevel);
}

int playerReached(Character * hunterPtr1, Character * hunterPtr2, Character * hunterPtr3, Character * hunterPtr4, 
				  Character * hunterPtr5, Character * hunterPtr6, Character * hunterPtr7, Character * hunterPtr8, 
                  Character* preyPtr)
{
	return(areCharctersAtSamePosition(hunterPtr1,preyPtr) || areCharctersAtSamePosition(hunterPtr2,preyPtr) ||
		   areCharctersAtSamePosition(hunterPtr3,preyPtr) || areCharctersAtSamePosition(hunterPtr4,preyPtr) ||
		   areCharctersAtSamePosition(hunterPtr5,preyPtr) || areCharctersAtSamePosition(hunterPtr6,preyPtr) ||
		   areCharctersAtSamePosition(hunterPtr7,preyPtr) || areCharctersAtSamePosition(hunterPtr8,preyPtr));
}

int playerReachedBombs(Character * bombPtr1, Character * bombPtr2, Character * bombPtr3, Character * bombPtr4,  
					   Character* ghostPtr)
{
	return(areCharctersAtSamePosition(bombPtr1,ghostPtr) || areCharctersAtSamePosition(bombPtr2,ghostPtr) ||
		   areCharctersAtSamePosition(bombPtr3,ghostPtr) || areCharctersAtSamePosition(bombPtr4,ghostPtr));
}

int charactersMeet(Character * hunterPtr1, Character * hunterPtr2, Character * hunterPtr3, 
				   Character * hunterPtr4, Character * hunterPtr5, Character * hunterPtr6,
				   Character * hunterPtr7,
				   Character* preyPtr)
{
	return(areCharctersAtSamePosition(hunterPtr1,preyPtr) || areCharctersAtSamePosition(hunterPtr2,preyPtr) ||
	       areCharctersAtSamePosition(hunterPtr3,preyPtr) || areCharctersAtSamePosition(hunterPtr4,preyPtr) ||
	       areCharctersAtSamePosition(hunterPtr5,preyPtr) || areCharctersAtSamePosition(hunterPtr6,preyPtr) ||
		   areCharctersAtSamePosition(hunterPtr7,preyPtr));
}

int powerUpReached(Character * hunterPtr, Character* preyPtr)
{
	return(areCharctersAtSamePosition(hunterPtr, preyPtr));
}

int computeInvincibleCountDown()
{
	return 100 - level*5;
}

int computeInvincibleSlowDown(int loop)
{
	return 32000 - level * 1000 - loop;
}


void movePlayer(Character *playerPtr, char kbInput)
{
	if((kbInput=='W') || (kbInput=='w'))
	{
		deleteCharacter(playerPtr);
		--playerPtr->_y;
		invincibleYCountDown = computeInvincibleCountDown();
	}
	else if((kbInput=='S') || (kbInput=='s'))
	{
		deleteCharacter(playerPtr);
		++playerPtr->_y;
		invincibleYCountDown = computeInvincibleCountDown();
	}
	else if((kbInput=='A') || (kbInput=='a'))
	{
		deleteCharacter(playerPtr);
		--playerPtr->_x;
		invincibleXCountDown = computeInvincibleCountDown();
	}
	else if((kbInput=='D') || (kbInput=='d'))
	{
		deleteCharacter(playerPtr);
		++playerPtr->_x;
		invincibleXCountDown = computeInvincibleCountDown();
	}
	displayCharacter(playerPtr);
}

void initializeCharacter(Character* characterPtr, int x, int y, char ch, short status)
{
	characterPtr->_x = x;
	characterPtr->_y = y;
	characterPtr->_ch = ch;
	characterPtr->_status = status;
	characterPtr->_alive = 1; // TODO: Maybe we should initialize this with a parameter
}

void drawBorders(int XSize, int YSize)
{
	/* Clear the screen, put cursor in upper left corner */
    clrscr ();
	
	/* Top line */
    cputc (CH_ULCORNER);
    chline (XSize - 2);
    cputc (CH_URCORNER);

    /* Vertical line, left side */
    cvlinexy (0, 1, YSize - 2);

    /* Bottom line */
    cputc (CH_LLCORNER);
    chline (XSize - 2);
    cputc (CH_LRCORNER);

    /* Vertical line, right side */
    cvlinexy (XSize - 1, 1, YSize - 2);
}

void setScreenColors()
{
    (void) textcolor (COLOR_WHITE);
    (void) bordercolor (COLOR_BLACK);
    (void) bgcolor (COLOR_BLACK);
}


void printCenteredMessage(int XSize, int YSize, char *Text)
{
	gotoxy ((XSize - strlen (Text)) / 2, YSize / 2);
    cprintf ("%s", Text);
}

void printLevel(int XSize, int YSize)
{
	char levelString[22];

	sprintf(levelString, "LEVEL %d", level);

	printCenteredMessage(XSize, YSize, levelString);
}

void printPressKeyToStart(int XSize, int YSize)
{
	printCenteredMessage(XSize, YSize, "PRESS ANY KEY TO START");
}

void deleteCenteredMessage(int XSize, int YSize)
{
	gotoxy ((XSize - 22) / 2, YSize / 2);
    cputs( "                      ");
}

void toggleHunters(Character * hunterPtr1, Character * hunterPtr2, 
                   Character * hunterPtr3, Character * hunterPtr4, 
				   Character * hunterPtr5, Character * hunterPtr6, 
                   Character * hunterPtr7, Character * hunterPtr8, 
				   int loop)
{
	if(loop==10)
		hunterPtr1->_status = 1;
	if(loop==25-level*2)
		hunterPtr2->_status = 1;
	if(loop==30-level*2)
		hunterPtr3->_status = 1;
	if(loop==40-level*2)
		hunterPtr4->_status = 1;
	if(loop==50-level*2)
		hunterPtr5->_status = 1;
	if(loop==60-level*2)
		hunterPtr6->_status = 1;
	if(loop==70-level*2)
		hunterPtr7->_status = 1;
	if(loop==80-level*2)
		hunterPtr8->_status = 1;
}

void checkBombsVsGhost(Character * bombPtr1, Character * bombPtr2, 
					   Character * bombPtr3, Character * bombPtr4,
					   Character * ghostPtr)
{
	if(ghostPtr->_alive && playerReachedBombs(bombPtr1, bombPtr2, bombPtr3, bombPtr4, ghostPtr))
	{
		gotoxy(ghostPtr->_x,ghostPtr->_y);
		cputc('X');
		ghostPtr->_alive = 0;
		ghostPtr->_status = 0;
		points+=GHOST_VS_BOMBS_BONUS;
		--ghostCount;
	}
}
						

void checkBombsVsGhosts(Character * bombPtr1, Character * bombPtr2, 
						Character * bombPtr3, Character * bombPtr4,
						Character * ghostPtr1, Character * ghostPtr2, 
						Character * ghostPtr3, Character * ghostPtr4,
						Character * ghostPtr5, Character * ghostPtr6, 
						Character * ghostPtr7, Character * ghostPtr8)
{
	checkBombsVsGhost(bombPtr1, bombPtr2, bombPtr3, bombPtr4, ghostPtr1);
	checkBombsVsGhost(bombPtr1, bombPtr2, bombPtr3, bombPtr4, ghostPtr2);
	checkBombsVsGhost(bombPtr1, bombPtr2, bombPtr3, bombPtr4, ghostPtr3);
	checkBombsVsGhost(bombPtr1, bombPtr2, bombPtr3, bombPtr4, ghostPtr4);
	checkBombsVsGhost(bombPtr1, bombPtr2, bombPtr3, bombPtr4, ghostPtr5);
	checkBombsVsGhost(bombPtr1, bombPtr2, bombPtr3, bombPtr4, ghostPtr6);
	checkBombsVsGhost(bombPtr1, bombPtr2, bombPtr3, bombPtr4, ghostPtr7);
	checkBombsVsGhost(bombPtr1, bombPtr2, bombPtr3, bombPtr4, ghostPtr8);
}


int safeLocation(int x, int y, 
				Character * bombPtr1, Character * bombPtr2, 
				Character * bombPtr3, Character * bombPtr4,
				Character * ghostPtr1, Character * ghostPtr2, 
				Character * ghostPtr3, Character * ghostPtr4,
				Character * ghostPtr5, Character * ghostPtr6, 
				Character * ghostPtr7, Character * ghostPtr8)
{
	return !isCharacterAtLocation(x,y,bombPtr1) && !isCharacterAtLocation(x,y,bombPtr2) &&
	!isCharacterAtLocation(x,y,bombPtr3) && !isCharacterAtLocation(x,y,bombPtr4) &&
	!isCharacterAtLocation(x,y,ghostPtr1) && !isCharacterAtLocation(x,y,ghostPtr2) &&
	!isCharacterAtLocation(x,y,ghostPtr3) && !isCharacterAtLocation(x,y,ghostPtr4) &&
	!isCharacterAtLocation(x,y,ghostPtr5) && !isCharacterAtLocation(x,y,ghostPtr6) &&
	!isCharacterAtLocation(x,y,ghostPtr7) && !isCharacterAtLocation(x,y,ghostPtr8);
}


void relocateCharacter(int XSize, int YSize, Character * characterPtr, 
						Character * bombPtr1, Character * bombPtr2, 
						Character * bombPtr3, Character * bombPtr4,
						Character * ghostPtr1, Character * ghostPtr2, 
						Character * ghostPtr3, Character * ghostPtr4,
						Character * ghostPtr5, Character * ghostPtr6, 
						Character * ghostPtr7, Character * ghostPtr8)
{
	int x; int y; int x_offset; int y_offset;
	int safe = 0;
	while(!safe)
	{
	x_offset = rand() % 38;
	y_offset = rand() % 38;
	if((x_offset==0) && (y_offset==0))
		continue;
	x = characterPtr->_x -19 + x_offset; 
	y = characterPtr->_y -19 + y_offset;
	if(y<=3) // Avoid score line
		continue;
	if((x<2) || (x>XSize-2))
		continue;
	if((y<2) || (y>YSize-2))
		continue;
	
	safe = safeLocation(x,y, bombPtr1, bombPtr2, bombPtr3, bombPtr4, 
						ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, 
						ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);
	}
	characterPtr->_x = x;
	characterPtr->_y = y;
}


void initializeCharacters(int XSize, int YSize,
						  Character * playerPtr, Character * powerUpPtr, 
						  Character * ghostPtr1, Character * ghostPtr2,
						  Character * ghostPtr3, Character * ghostPtr4,
						  Character * ghostPtr5, Character * ghostPtr6,
						  Character * ghostPtr7, Character * ghostPtr8,
						  Character * bombPtr1, Character * bombPtr2,
						  Character * bombPtr3, Character * bombPtr4,
						  Character * invincibleGhostPtr,
						  )
{
	initializeCharacter(ghostPtr2,XSize/6+rand()%4-2,YSize/6+rand()%4-2,'O',0);
	displayCharacter(ghostPtr2);

	initializeCharacter(ghostPtr3,XSize/6+rand()%4-2,YSize/2+rand()%4-2,'O',0);
	displayCharacter(ghostPtr3);
	
	initializeCharacter(ghostPtr4,XSize/6+rand()%4-2,YSize-YSize/6+rand()%4-2,'O',0);
	displayCharacter(ghostPtr4);
	
	initializeCharacter(ghostPtr5,XSize/2+rand()%4-2,YSize/6+rand()%4-2,'O',0);
	displayCharacter(ghostPtr5);

	initializeCharacter(ghostPtr6,XSize/2+rand()%4-2,YSize-YSize/6+rand()%4-2,'O',0);
	displayCharacter(ghostPtr6);

	initializeCharacter(ghostPtr7,XSize-XSize/6+rand()%4-2,YSize/6+rand()%4-2,'O',0);
	displayCharacter(ghostPtr7);
	
	initializeCharacter(ghostPtr8,XSize-XSize/6+rand()%4-2,YSize/2+rand()%4-2,'O',0);
	displayCharacter(ghostPtr8);
	
	initializeCharacter(ghostPtr1,XSize-XSize/6+rand()%4-2,YSize-YSize/6+rand()%4-2,'O',0);
	displayCharacter(ghostPtr1);

	initializeCharacter(bombPtr1,XSize/2,YSize/2,'X',0);
	relocateCharacter(XSize, YSize, bombPtr1, ghostPtr1, ghostPtr1, ghostPtr1, ghostPtr1, 
					   ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, 
					   ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);		
	displayCharacter(bombPtr1);

	initializeCharacter(bombPtr2,XSize/2,YSize/2,'X',0);
	relocateCharacter(XSize, YSize, bombPtr2, bombPtr1, ghostPtr1, ghostPtr1, ghostPtr1, 
				   ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, 
				   ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);		
	displayCharacter(bombPtr2);

	initializeCharacter(bombPtr3,XSize/2,YSize/2,'X',0);
	relocateCharacter(XSize, YSize, bombPtr3, bombPtr1, bombPtr2, ghostPtr1, ghostPtr1, 
				   ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, 
				   ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);	
	displayCharacter(bombPtr3);
	
	initializeCharacter(bombPtr4,XSize/2,YSize/2,'X',0);
	relocateCharacter(XSize, YSize, bombPtr4, bombPtr1, bombPtr2, bombPtr3, ghostPtr1, 
				   ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, 
				   ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);	
	displayCharacter(bombPtr4);
	
	initializeCharacter(playerPtr,XSize/2,YSize/2,'*',1);
	relocateCharacter(XSize, YSize, playerPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4, 
						   ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, 
						   ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);					   
	initializeCharacter(playerPtr,playerPtr->_x,playerPtr->_y,'*',1);
	displayCharacter(playerPtr);

	initializeCharacter(powerUpPtr,XSize/2,YSize/2,'P',1);
	relocateCharacter(XSize, YSize, powerUpPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4, 
						   ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, 
						   ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);	
	initializeCharacter(powerUpPtr,powerUpPtr->_x,powerUpPtr->_y,'P',1);
	displayCharacter(powerUpPtr);
	
	initializeCharacter(invincibleGhostPtr,XSize/2,YSize/2,'+',0);
	relocateCharacter(XSize, YSize, invincibleGhostPtr, bombPtr1, bombPtr2, bombPtr3, bombPtr4, 
						   ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, 
						   ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8);					   
	initializeCharacter(invincibleGhostPtr,invincibleGhostPtr->_x,invincibleGhostPtr->_y,'+',0);
}

int victoryCondition(Character *ghostPtr1, Character *ghostPtr2, Character *ghostPtr3, Character *ghostPtr4,
					 Character *ghostPtr5, Character *ghostPtr6, Character *ghostPtr7, Character *ghostPtr8)
{
	return(!(ghostPtr1->_alive) && !(ghostPtr2->_alive) && !(ghostPtr3->_alive) && !(ghostPtr4->_alive) &&
	       !(ghostPtr5->_alive) && !(ghostPtr6->_alive) && !(ghostPtr7->_alive) && !(ghostPtr8->_alive));
}

void printGameOver(int XSize, int YSize)
{
	printCenteredMessage(XSize, YSize, "G A M E   O V E R");
}

void printVictoryMessage(int XSize, int YSize)
{
	printCenteredMessage(XSize, YSize, "Y O U   W O N ! !");
}

void printDefeatMessage(int XSize, int YSize)
{
	printCenteredMessage(XSize, YSize, "Y O U   L O S T !");
}


unsigned int computeGhostSlowDown()
{
   if(ghostLevel<10)
   {
	   return 32000-level*200;
   }
   else if(ghostLevel<200)
   {
	   return 32000-ghostLevel*10-level*200;
   }
   else if(ghostLevel<300)
   {
	   return 32000-ghostLevel*20-level*200;
   }
   else if(ghostLevel<400)
   {
	   return 32000-ghostLevel*40-level*200;
   }
   else 
   {
	   return 7000-level*200;
   }
}

int wallReached(int XSize, int YSize, Character *characterPtr)
{
	return (characterPtr->_x==0)||(characterPtr->_x==XSize-1) || 
		   (characterPtr->_y==0)||(characterPtr->_y==YSize-1);
}

void die(Character * playerPtr)
{
	gotoxy(playerPtr->_x,playerPtr->_y);
	cputc('X');
	playerPtr->_status = 0;
	playerPtr->_alive = 0;
	playerPtr->_ch = 'X';
}

void defeat(int XSize, int YSize)
{
	printDefeatMessage(XSize, YSize);
	sleep(1);
}

void win(Character * playerPtr)
{
	gotoxy(playerPtr->_x,playerPtr->_y);
	cputc('!');
}

void victory(int XSize, int YSize)
{
	printVictoryMessage(XSize, YSize);
	sleep(1);
}

void decreaseGhostLevel(int level)
{
	if(ghostLevel>level)
		ghostLevel-=level;
	else
		ghostLevel=0;
}

#if defined(CLOCKS_PER_SEC)
unsigned __fastcall__ microSleep (unsigned int wait)
{
    clock_t goal = clock () + ((clock_t) wait / 1000) * (int) (CLOCKS_PER_SEC);
    while ((long) (goal - clock ()) > 0) ;
    return 0;
}
#endif

void checkGhostsVsGhosts(Character *ghostPtr1, Character *ghostPtr2, Character *ghostPtr3, Character *ghostPtr4,
						 Character *ghostPtr5, Character *ghostPtr6, Character *ghostPtr7, Character *ghostPtr8)
{
	if(ghostPtr8->_alive && charactersMeet(ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8))
	{
		die(ghostPtr8);
		points+=GHOST_VS_GHOST_BONUS;
	    --ghostCount;
	}
	if(ghostPtr1->_alive && charactersMeet(ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8, ghostPtr1))
	{
		die(ghostPtr1);
		points+=GHOST_VS_GHOST_BONUS;
		--ghostCount;
	}
	if(ghostPtr2->_alive && charactersMeet(ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8, ghostPtr1, ghostPtr2))
	{
		die(ghostPtr2);
		points+=GHOST_VS_GHOST_BONUS;
		--ghostCount;
	}
	if(ghostPtr3->_alive && charactersMeet(ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8, ghostPtr1, ghostPtr2, ghostPtr3))
	{
		die(ghostPtr3);
		points+=GHOST_VS_GHOST_BONUS;
		--ghostCount;
	}
	if(ghostPtr4->_alive && charactersMeet(ghostPtr5, ghostPtr6, ghostPtr7, ghostPtr8, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4))
	{
		die(ghostPtr4);
		points+=GHOST_VS_GHOST_BONUS;
		--ghostCount;
	}
	if(ghostPtr5->_alive && charactersMeet(ghostPtr6, ghostPtr7, ghostPtr8, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5))
	{
		die(ghostPtr5);
		points+=GHOST_VS_GHOST_BONUS;
		--ghostCount;
	}
	if(ghostPtr6->_alive && charactersMeet(ghostPtr7, ghostPtr8, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6))
	{
		die(ghostPtr6);
		points+=GHOST_VS_GHOST_BONUS;
		--ghostCount;
	}
	if(ghostPtr7->_alive && charactersMeet(ghostPtr8, ghostPtr1, ghostPtr2, ghostPtr3, ghostPtr4, ghostPtr5, ghostPtr6, ghostPtr7))
	{
		die(ghostPtr7);
		points+=GHOST_VS_GHOST_BONUS;
		--ghostCount;
	}
}

int computeGhostSmartness()
{
	if(level<=4)
	{
		return level+3;
	}
	else
	{
		return 8;
	}
}

void computePowerUp(int *coolDownDecreasePtr, int *powerUpInitialCoolDownPtr)
{
	*coolDownDecreasePtr = 200-(level-1)*10;
	*powerUpInitialCoolDownPtr = 200+(level-1)*10;
}

void gameCompleted(int XSize, int YSize)
{
	printCenteredMessage(XSize, YSize, "Y O U  M A D E  I T !"); 
	sleep(2);
	printCenteredMessage(XSize, YSize, "    T H E   E N D    "); 
	sleep(2);
}

void finalScore(int XSize, int YSize)
{
	char scoreString[22];
	clrscr();
	sprintf(scoreString, "SCORE:  %lu", points);
	printCenteredMessage(XSize, YSize, scoreString);
	sleep(3);
}

int computeInvincibleGhostCountTrigger()
{
	if(level<=7)
		return level/2 + 1;
	else
		return 5;
}

int main (void)
{
    unsigned char XSize, YSize;
	
	char kbInput;
	
	Character ghost_1; 	
	Character ghost_2; 
    Character ghost_3; 	
	Character ghost_4; 
	Character ghost_5; 	
	Character ghost_6; 
    Character ghost_7; 	
	Character ghost_8; 
	
	Character player; 
	
	Character powerUp;
	
	Character bomb_1;
	Character bomb_2;
	Character bomb_3;
	Character bomb_4;
	
	Character invincibleGhost;
	
	int loop, victoryFlag, ghostLevelDecrease, powerUpInitialCoolDown;
	while(1)
	{
		victoryFlag = 0;
		loop = 0;	
		points = 0ul;
		level = 1;

		// Set Screen Colors
		setScreenColors();			
		
		clrscr ();
					
		/* Wait for the user to press a key */
		printPressKeyToStart(XSize, YSize);
		cgetc();
		deleteCenteredMessage(XSize, YSize);
			
		do
		{
			loop = 0;
			ghostLevel = 1u;
			ghostSmartness = computeGhostSmartness();
			computePowerUp(&ghostLevelDecrease, &powerUpInitialCoolDown);
			invincibleXCountDown = computeInvincibleCountDown();
			invincibleYCountDown = computeInvincibleCountDown();
			invincibleSlowDown = computeInvincibleSlowDown(loop);
			invincibleGhostCountTrigger = computeInvincibleGhostCountTrigger();
			ghostCount = 8;
			
			/* Clear the screen, put cursor in upper left corner */
			clrscr ();

			/* Ask for the screen size */
			screensize (&XSize, &YSize);

			printLevel(XSize, YSize);
			sleep(2);
			
			/* Wait for the user to press a key */
			printPressKeyToStart(XSize, YSize);
			cgetc();
			deleteCenteredMessage(XSize, YSize);
			
			/* Draw a border around the screen */
			drawBorders(XSize, YSize);
			
			// Initialize characters
			initializeCharacters(XSize, YSize,
								 &player, &powerUp, 
								 &ghost_1, &ghost_2, &ghost_3, &ghost_4, 
								 &ghost_5, &ghost_6, &ghost_7, &ghost_8, 
								 &bomb_1, &bomb_2, &bomb_3, &bomb_4, &invincibleGhost);	
			victoryFlag = 0;
			while(player._alive && !victoryFlag)
			{
				ghostSlowDown = computeGhostSlowDown();
				microSleep(10-level);
				
				++loop;
				toggleHunters(&ghost_1, &ghost_2, &ghost_3, &ghost_4, 
							  &ghost_5, &ghost_6, &ghost_7, &ghost_8, loop);
				
				if(kbhit())
				{		
					kbInput = cgetc();
					movePlayer(&player, kbInput);
				}

				chasePlayer(&ghost_1, &ghost_2, &ghost_3, &ghost_4, 
							&ghost_5, &ghost_6, &ghost_7, &ghost_8, &player, 
							&bomb_1, &bomb_2, &bomb_3, &bomb_4);
				
				if(playerReached(&ghost_1, &ghost_2, &ghost_3, &ghost_4, 
								 &ghost_5, &ghost_6, &ghost_7, &ghost_8, &player) ||
				   playerReachedBombs(&bomb_1, &bomb_2, &bomb_3, &bomb_4, &player))
				{
					die(&player);
					defeat(XSize, YSize);
					sleep(1);
				}
			
				checkBombsVsGhosts(&bomb_1, &bomb_2, &bomb_3, &bomb_4, 
								   &ghost_1, &ghost_2, &ghost_3, &ghost_4, 
								   &ghost_5, &ghost_6, &ghost_7, &ghost_8);
				
				checkGhostsVsGhosts(&ghost_1, &ghost_2, &ghost_3, &ghost_4, 
									&ghost_5, &ghost_6, &ghost_7, &ghost_8);

				if(powerUp._status == 1)
				{
					if(powerUpReached(&player, &powerUp))
					{
						decreaseGhostLevel(ghostLevelDecrease);	
						points+=POWER_UP_BONUS;
						powerUp._status = 0;	
						powerUpCoolDown = powerUpInitialCoolDown;
					}
					else
					{
						displayCharacter(&powerUp);
					}		
				}
				else if (powerUpCoolDown == 0)
				{
					powerUp._status = 1;
					relocateCharacter(XSize, YSize, &powerUp, &bomb_1, &bomb_2, &bomb_3, &bomb_4, 
								   &ghost_1, &ghost_2, &ghost_3, &ghost_4, 
								   &ghost_5, &ghost_6, &ghost_7, &ghost_8);
				}
				else
				{
					--powerUpCoolDown;
				}
					
				if(wallReached(XSize, YSize, &player))
				{
					die(&player);
					defeat(XSize, YSize);
					sleep(1);
				}
				
				displayCharacter(&bomb_1);
				displayCharacter(&bomb_2);		
				displayCharacter(&bomb_3);
				displayCharacter(&bomb_4);
				
				displayScore(points);
				displayGhostLevel();
				
				if(!invincibleGhost._status && 
				  ((invincibleXCountDown==0)||(invincibleYCountDown==0)) || 
				   (loop>=invincibleLoopTrigger) || (ghostCount<=invincibleGhostCountTrigger))
				{
					invincibleGhost._status = 1;
					displayCharacter(&invincibleGhost);
				}
				else
				{
					--invincibleXCountDown;
					--invincibleYCountDown;
				}
				if(invincibleGhost._status)
				{
					blindChaseCharacter(&invincibleGhost, &player);
					if(areCharctersAtSamePosition(&invincibleGhost, &player))
					{
						die(&player);
						defeat(XSize, YSize);
						sleep(1);
					}
				}
				
				
				if(victoryFlag=victoryCondition(&ghost_1, &ghost_2, &ghost_3, &ghost_4, 
												&ghost_5, &ghost_6, &ghost_7, &ghost_8))
				{
					win(&player);
					victory(XSize, YSize);
					sleep(1);
				}
				
				// Add points to score
				points+=LOOP_POINTS;
				
				// Increase ghost speed
				++ghostLevel;
			}; // end inner while
			
			if(player._alive)
			{
				++level;
				points+= LEVEL_BONUS;
			}
		} while (victoryFlag && (level<FINAL_LEVEL+1)); // middle while (one match)
			
	if(level==FINAL_LEVEL+1)
	{
		gameCompleted(XSize, YSize);
		sleep(1);
	}
	finalScore(XSize, YSize);
	// GAME OVER	
	printGameOver(XSize, YSize);
	sleep(1);
	clrscr ();
	}

	return EXIT_SUCCESS;
}
