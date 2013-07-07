/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim.
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "kobold2d.h"
#import "GameOver.h"
#import "PauseLayer.h"

@interface HelloWorldLayer : CCLayer
{
    CCDirector *director;
    CCSprite *player;
    CGPoint screenCenter;
    CGSize size;
    int playerWidth;
    int shipRandX;
    int shipRandY;
    id shipMove;
    int shipSpeed;
    
    NSMutableArray *section1Ships;
    NSMutableArray *section2Ships;
    NSMutableArray *section3Ships;
    
    CCSprite *ship1;
    CCSprite *ship2;
    CCSprite *ship3;
    
    CCSprite *section1;
    CCSprite *section2;
    CCSprite *section3;
    CCProgressTimer* progressBar1;
    CCProgressTimer* progressBar2;
    CCProgressTimer* progressBar3;
    CCProgressTo *progressTo1;
    CCProgressTo *progressTo2;
    CCProgressTo *progressTo3;
    
    float section1StartAngle;
    float section1EndAngle;
    float section2StartAngle;
    float section2EndAngle;
    float section3StartAngle;
    float section3EndAngle;
    
    int playerScore;
    CCLabelBMFont *scoreLabel;
    NSString* score;
    CCLabelBMFont *liveLabel;
    NSString* lives;
    int playerLives;
    
    int shipColor; // 1 = red, 2 = blue, 3 = yellow
    
    int framesPassed;
    float secondsPassed;
    
    CCAction *explode;
    NSMutableArray *explodingFrames;
    CCAnimation *explosion;
    
    float distance;
    float radii;
    int numCollisions;
    
    CCLabelBMFont *warningLabel;
    bool warning;
    
    NSMutableArray *powerUpType1;
    NSMutableArray *powerUpType2;
    NSMutableArray *powerUpType3;
    CCSprite *powerUp1;
    CCSprite *powerUp2;
    CCSprite *powerUp3;
    
    CCMenuItemImage *powerUpCreator1;
    CCMenuItemImage *powerUpCreator2;
    CCMenuItemImage *powerUpCreator3;
    
    bool gameOver;
    
    bool collisionDidHappen;
    
    int livesSubtract;
    int scoreAdd;
    
    CCSprite *pauseButton;
    float lastTouchAngle;
    
    int numPower1Left;
    int numPower2Left;
    int numPower3Left;
    NSString *power1Num;
    NSString *power2Num;
    NSString *power3Num;
    CCLabelBMFont *power1Left;
    CCLabelBMFont *power2Left;
    CCLabelBMFont *power3Left;
    
    CCMenu *powerUpCreatorsMenu;
    
    CCSprite *infiniteBorderPowerUp1;
    
    NSNumber *sharedScore;
    
    int startLives;
    
    CCMenuItemImage *powerUpBorder1;
    CCMenuItemImage *powerUpBorder2;
    CCMenuItemImage *powerUpBorder3;
    
    CCLabelBMFont *screenflashLabel;
    
    CCSprite *enemyShip1;
    CCSprite *enemyShip2;
    CCSprite *enemyShip3;
    
    int spriteTagNum;
    
    float rotation;
    float circle_rotation;// = 0.0f;
    
    
    int playerHighScore;
    
    NSNumber *sharedHighScore;
    
    int numSpritesCollided;
    
    int shipShape;
    
    int playerCoins;
    NSNumber *sharedCoins;
    
    CCSprite *lifeBarSprite;
    CCProgressTimer *lifeBar;
    CCProgressTo *lifeUpdater;
    
    CCSprite *lifeBarBorder;
    
    int topBottomVariable;
    
    int numSpritesPerArray;
    int numSpritesCollidedWithShield;
    
    int shipArray;
    
    int pointMultiplier;
    
    NSString *multiplierString;
    CCLabelBMFont *multiplierLabel;
    
    int numHitsUntilNextMultiplier;

}

-(void) scoreCheck:(int) angle withColor: (int) color;
-(void) circleCollisionWithSprite:(CCSprite *) circle1 andThis:(CCSprite *) circle2;
-(void) createShipCoord:(CCSprite *)shipForCoord;
-(void) moveShip:(CCSprite *) shipToMove;
-(void) initShips;
-(void) handleUserInput;
-(void) divideAngularSections;
-(void) pickColor;
-(void) initSect1Ships;
-(void) initSect2Ships;
-(void) initSect3Ships;
-(void) updateScore;
-(void)update:(ccTime)dt;
-(void) normalizeAngle:(float) angleInput;
-(void) initChallenges;
-(void) gameOver;
-(void) addPowerup1;
-(void) addPowerup2;
-(void) addPowerup3;
-(void) transferToGameOverScene;

@end
