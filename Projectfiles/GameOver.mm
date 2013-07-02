//
//  GameOver.m
//  Moon Landing
//
//  Created by Gautam Mittal on 6/20/13.
//
//

#import "GameOver.h"

@implementation GameOver

-(id) init
{
	if ((self = [super init]))
	{
        glClearColor(0, 0, 0, 0);
        [self unscheduleAllSelectors];
        
        // have everything stop
        CCNode* node;
        CCARRAY_FOREACH([self children], node)
        {
            [node pauseSchedulerAndActions];
        }
        
        
        // add the labels shown during game over
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF* gameOver = [CCLabelTTF labelWithString:@"MISSION FAILED" fontName:@"SpaceraLT-Regular" fontSize:25];
        gameOver.position = CGPointMake(screenSize.width / 2, screenSize.height - 215);
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
        CCRotateTo* rotate1 = [CCRotateTo actionWithDuration:2 angle:3];
        CCEaseBounceInOut* bounce1 = [CCEaseBounceInOut actionWithAction:rotate1];
        CCRotateTo* rotate2 = [CCRotateTo actionWithDuration:2 angle:-3];
        CCEaseBounceInOut* bounce2 = [CCEaseBounceInOut actionWithAction:rotate2];
        CCSequence* rotateSequence = [CCSequence actions:bounce1, bounce2, nil];
        CCRepeatForever* repeatBounce = [CCRepeatForever actionWithAction:rotateSequence];
        [gameOver runAction:repeatBounce];
        
        // 3) jumping
        CCJumpBy* jump = [CCJumpBy actionWithDuration:3 position:CGPointZero height:screenSize.height / 3 jumps:1];
        CCRepeatForever* repeatJump = [CCRepeatForever actionWithAction:jump];
        [gameOver runAction:repeatJump];
        
        NSNumber *endingScoreNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"sharedScore"];
        int endingScore = [endingScoreNumber intValue];
        NSString *endScoreString = [[NSString alloc] initWithFormat:@"Final Score: %i", endingScore];
        CCLabelBMFont *endScore = [CCLabelTTF labelWithString:endScoreString fontName:@"Roboto-Light" fontSize:20];
        endScore.position = ccp(screenSize.width/2, 100);
        [self addChild:endScore];
        
        NSNumber *endingHighScoreNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"sharedHighScore"];
//        NSNumber *endingHighScoreNumber = [MGWU objectForKey:@"sharedHighScore"];
        int endingHighScore = [endingHighScoreNumber intValue];
        NSString *endHighScoreString = [[NSString alloc] initWithFormat:@"High Score: %i", endingHighScore];
        CCLabelBMFont *endHighScore = [CCLabelTTF labelWithString:endHighScoreString fontName:@"Roboto-Light" fontSize:20];
        endHighScore.position = ccp(screenSize.width/2, 60);
        [self addChild:endHighScore];
        
        NSNumber *endingCoinNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"sharedCoins"];
        //        NSNumber *endingHighScoreNumber = [MGWU objectForKey:@"sharedHighScore"];
        int endingCoins = [endingCoinNumber intValue];
        NSString *endCoinString = [[NSString alloc] initWithFormat:@"Coins: %i", endingCoins];
        CCLabelBMFont *endCoins = [CCLabelTTF labelWithString:endCoinString fontName:@"Roboto-Light" fontSize:20];
        endCoins.position = ccp(screenSize.width/2, 20);
        [self addChild:endCoins];

        
        
        CCMenuItemFont *playAgain = [CCMenuItemFont itemFromString: @"Play Again" target:self selector:@selector(playAgain)];
        CCMenuItemFont *quit = [CCMenuItemFont itemFromString: @"Quit" target:self selector:@selector(quitGame)];
        [playAgain setFontName:@"Roboto-Light"];
        [quit setFontName:@"Roboto-Light"];
        CCMenu *gameOverMenu = [CCMenu menuWithItems:playAgain, quit, nil];
        [gameOverMenu alignItemsVertically];
        gameOverMenu.position = ccp(screenSize.width/2, screenSize.height/2 - 60);
        [self addChild:gameOverMenu];
        
        nameField = [[UITextField alloc] initWithFrame:CGRectMake(35, 220, 250, 25)];
        [[[CCDirector sharedDirector] view] addSubview:nameField];
        nameField.delegate = self;
        nameField.placeholder = @"Tap to Enter Username";
        nameField.borderStyle = UITextBorderStyleRoundedRect;
        [nameField setReturnKeyType:UIReturnKeyDone];
        [nameField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [nameField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
//        textField.visible = true;
//        [glView addSubview:textField];
//        [self addChild:textField];

    }
    return self;
}

- (void)textFieldDidEndEditing:(UITextField*)textField
{
    if (textField == nameField && ![nameField.text isEqualToString:@""])
    {
		
        [nameField endEditing:YES];
        [nameField removeFromSuperview];
        // here is where you should do something with the data they entered
        NSString *result = nameField.text;
        
//        username = result;
        [[NSUserDefaults standardUserDefaults] setObject:result forKey:@"username"];
        
    }
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
	if (![nameField.text isEqualToString:@""])
	{
		//Hide keyboard when "done" clicked
		[textField resignFirstResponder];
		[nameField removeFromSuperview];
		return YES;
	}
}



-(void) quitGame
{
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionCrossFade transitionWithDuration:0.5f scene:[StartMenuLayer node]]];
    //Hide keyboard when "done" clicked
  //  [textField resignFirstResponder];
    [nameField removeFromSuperview];
    //return YES;
}

-(void) playAgain
{
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionCrossFade transitionWithDuration:0.5f scene:[HelloWorldLayer node]]];
//        [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer node]];
    [nameField removeFromSuperview];
}

@end
