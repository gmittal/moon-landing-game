//
//  PauseLayer.m
//  Moon Landing
//
//  Created by Gautam Mittal on 6/24/13.
//
//

#import "PauseLayer.h"

@implementation PauseLayer

-(id) init
{
	if ((self = [super init]))
	{
        glClearColor(0.0, 0.75, 1.0, 1.0);
        [self unscheduleAllSelectors];
        
        // have everything stop
        CCNode* node;
        CCARRAY_FOREACH([self children], node)
        {
            [node pauseSchedulerAndActions];
        }
        
        
        // add the labels shown during game over
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint screenCenter = ccp(screenSize.width/2, screenSize.height/2);
        
        CCLabelTTF* gameOver = [CCLabelTTF labelWithString:@"PAUSED" fontName:@"NexaBold" fontSize:50];
        gameOver.position = CGPointMake(screenSize.width / 2, screenSize.height / 2 + 100);
        [self addChild:gameOver z:100 tag:100];
        
        // game over label runs 3 different actions at the same time to create the combined effect
        // 1) color tinting
        CCTintTo* tint1 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:0];
        CCTintTo* tint2 = [CCTintTo actionWithDuration:2 red:255 green:255 blue:0];
        CCTintTo* tint3 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:0];
        CCTintTo* tint4 = [CCTintTo actionWithDuration:2 red:0 green:255 blue:255];
        CCTintTo* tint5 = [CCTintTo actionWithDuration:2 red:0 green:0 blue:255];
        CCTintTo* tint6 = [CCTintTo actionWithDuration:2 red:255 green:0 blue:255];
        CCSequence* tintSequence = [CCSequence actions:tint1, tint2, tint3, tint4, tint5, tint6, nil];
        CCRepeatForever* repeatTint = [CCRepeatForever actionWithAction:tintSequence];
        [gameOver runAction:repeatTint];
        
        // 2) rotation with ease
//        CCRotateTo* rotate1 = [CCRotateTo actionWithDuration:2 angle:3];
//        CCEaseBounceInOut* bounce1 = [CCEaseBounceInOut actionWithAction:rotate1];
//        CCRotateTo* rotate2 = [CCRotateTo actionWithDuration:2 angle:-3];
//        CCEaseBounceInOut* bounce2 = [CCEaseBounceInOut actionWithAction:rotate2];
//        CCSequence* rotateSequence = [CCSequence actions:bounce1, bounce2, nil];
//        CCRepeatForever* repeatBounce = [CCRepeatForever actionWithAction:rotateSequence];
//        [gameOver runAction:repeatBounce];
        
        // 3) jumping
//        CCJumpBy* jump = [CCJumpBy actionWithDuration:3 position:CGPointZero height:screenSize.height / 3 jumps:1];
//        CCRepeatForever* repeatJump = [CCRepeatForever actionWithAction:jump];
//        [gameOver runAction:repeatJump];
        
        CCLabelTTF *playAgainLabel = [CCLabelTTF labelWithString:@"Resume" fontName:@"NexaBold" fontSize:22];
        playAgainLabel.position = ccp(screenSize.width/2, screenSize.height/2 - 30);
        [self addChild:playAgainLabel z:7];
        
        CCLabelTTF *restartLabel = [CCLabelTTF labelWithString:@"Restart" fontName:@"NexaBold" fontSize:22];
        restartLabel.position = ccp(screenSize.width/2, screenSize.height/2 - 80);
        [self addChild:restartLabel z:7];
        
        CCLabelTTF *quitLabel = [CCLabelTTF labelWithString:@"Quit" fontName:@"NexaBold" fontSize:22];
        quitLabel.position = ccp(screenSize.width/2, screenSize.height/2 - 130);
        [self addChild:quitLabel z:7];
        
        
        CCMenuItemImage *playAgain = [CCMenuItemImage itemWithNormalImage:@"flatButton.png" selectedImage:@"flatButtonSel.png" target:self selector:@selector(unPause)];
        playAgain.scale = 1.5f;
        CCMenuItemImage *restart = [CCMenuItemImage itemWithNormalImage:@"flatButton.png" selectedImage:@"flatButtonSel.png" target:self selector:@selector(restartGame)];
        restart.scale = 1.5f;
        CCMenuItemImage *quit = [CCMenuItemImage itemWithNormalImage:@"flatButton.png" selectedImage:@"flatButtonSel.png" target:self selector:@selector(quitGame)];
        quit.scale = 1.5f;
//        [playAgain setFontName:@"Roboto-Light"];
//        [restart setFontName:@"Roboto-Light"];
//        [quit setFontName:@"Roboto-Light"];
        CCMenu *gameOverMenu = [CCMenu menuWithItems:playAgain, restart, quit, nil];
        [gameOverMenu alignItemsVertically];
        gameOverMenu.position = ccp(screenSize.width/2, screenSize.height/2 - 80);
        [self addChild:gameOverMenu];
        
        CCSprite *background;
        
        if ([[CCDirector sharedDirector] winSizeInPixels].height == 1024) {
            background = [CCSprite spriteWithFile:@"skybgipad.png"];
        } else if ([[CCDirector sharedDirector] winSizeInPixels].height == 2048) {
            background = [CCSprite spriteWithFile:@"skybgipad-hd.png"];
        } else {
            background = [CCSprite spriteWithFile:@"skybgip5.png"];
        }
        
        background.position = screenCenter;
        [self addChild:background z:-100];
        
    }
    return self;
}

-(void) quitGame
{
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFadeTR transitionWithDuration:0.5f scene:[StartMenuLayer node]]];
}

-(void) restartGame
{
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
}

-(void) unPause
{
//    [[CCDirector sharedDirector] popSceneWithTransition:
//	 [CCTransitionCrossFade transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
    [[CCDirector sharedDirector] popScene];
}


@end
