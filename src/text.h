/* --------------------------------------------------------------------------------------- */ 
// 
// CROSS CHASE by Fabrizio Caruso
//
// Fabrizio_Caruso@hotmail.com
//
// This software is provided 'as-is', without any express or implied warranty.
// In no event will the authors be held liable for any damages arising from
// the use of this software.

// Permission is granted to anyone to use this software for non-commercial applications, 
// subject to the following restrictions:

// 1. The origin of this software must not be misrepresented; you must not
// claim that you wrote the original software. If you use this software in
// a product, an acknowledgment in the product documentation would be
// appreciated but is not required.

// 2. Altered source versions must be plainly marked as such, and must not
// be misrepresented as being the original software.

// 3. This notice may not be removed or altered from any source distribution.
/* --------------------------------------------------------------------------------------- */ 
 
#ifndef _DISPLAY
#define _DISPLAY

#include <stdlib.h>
#include <string.h>

#include <stdio.h>



void displayStats(void);

#if !defined(TINY_GAME)
void displayStatsTitles(void);

void printGunsStats(void);
	
void printLevel(void);

void printVictoryMessage(void);

void printExtraLife(void);

#endif

void printLevelStats(void);

void printGhostCountStats(void);

void printLivesStats(void);

void setScreenColors(void);

void printCenteredMessageOnRow(unsigned char row, char *Text);

#if defined(COLOR)
	void printCenteredMessageOnRowWithCol(unsigned char row, unsigned char col, char *Text);
#endif


void printPressKeyToStart(void);

void deleteCenteredMessage(void);

void printGameOver(void);



void printDefeatMessage(void);

void printStartMessage(void);

void gameCompleted(void);


void _printScore(char * text, unsigned int score);

void printKillTheSkull(void);


#if defined(TINY_GAME)
	#define printLevelBonus(bonus) _printScore("bonus: %u0", bonus);

	#define finalScore() _printScore("%05u0", points);

	#define highScoreScreen() _printScore("best: %05u0", highScore);	
#elif !defined(__C64__)
	#define printLevelBonus(bonus) _printScore("BONUS: %u0", bonus);

	#define finalScore() _printScore("SCORE: %05u0", points);

	#define highScoreScreen() _printScore("HIGH SCORE: %05u0", highScore);
#else
	#define printLevelBonus(bonus) _printScore("bonus: %u0", bonus);

	#define finalScore() _printScore("score: %05u0", points);

	#define highScoreScreen() _printScore("high score: %05u0", highScore);	
#endif

void printHints(void);

#endif // _DISPLAY

