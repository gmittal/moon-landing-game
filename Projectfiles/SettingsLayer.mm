//
//  SettingsLayer.m
//  Moon Landing
//
//  Created by Gautam Mittal on 7/8/13.
//
//

#import "SettingsLayer.h"

@implementation SettingsLayer

-(id) init
{
	if ((self = [super init]))
	{
        glClearColor(0.0, 0.75, 1.0, 1.0);
        screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint screenCenter = [[CCDirector sharedDirector] screenCenter];
        CCLabelBMFont *gameTitle = [CCLabelTTF labelWithString:@"SETTINGS" fontName:@"NexaBold" fontSize:36];
        gameTitle.color = ccc3(0,0,0);
        gameTitle.position = ccp(screenCenter.x, screenSize.height-30);
        [self addChild:gameTitle];
        
        
        
        NSNumber *savedHighScore = [MGWU objectForKey:@"sharedHighScore"]; //[[NSUserDefaults standardUserDefaults] objectForKey:@"sharedHighScore"];
        int highScore = [savedHighScore intValue];
        NSString *highScoreString = [[NSString alloc] initWithFormat:@"High Score: %i", highScore];
        CCLabelBMFont *highScoreLabel = [CCLabelTTF labelWithString:highScoreString fontName:@"Roboto-Light" fontSize:20];
        highScoreLabel.position = ccp(screenSize.width/2, screenSize.height/2);
        highScoreLabel.color = ccc3(0, 0, 0);
        //        [self addChild:highScoreLabel];
        
        
        NSNumber *lastRoundScore = [MGWU objectForKey:@"sharedScore"]; //[[NSUserDefaults standardUserDefaults] objectForKey:@"sharedScore"];
        int lastRoundPlayedScore = [lastRoundScore intValue];
        NSString *lastRoundString = [[NSString alloc]initWithFormat:@"Last Round: %i", lastRoundPlayedScore];
        CCLabelBMFont *lastRoundPlayed = [CCLabelTTF labelWithString:lastRoundString fontName:@"Roboto-Light" fontSize:20];
        lastRoundPlayed.position = ccp(screenSize.width/2, screenSize.height/2 - 40);
        lastRoundPlayed.color = ccc3(0, 0, 0);
        //        [self addChild:lastRoundPlayed];
        
        //        [MGWU submitHighScore:highScore byPlayer:@"gmittal" forLeaderboard:@"defaultLeaderboard"];
        
        //        NSString *savedUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        //        [MGWU submitHighScore:highScore byPlayer:savedUser forLeaderboard:@"defaultLeaderboard"];
        
        //        [MGWU getHighScoresForLeaderboard:@"defaultLeaderboard" withCallback:@selector(receivedScores:)
        //                                 onTarget:self];
    
        
        
        CCMenuItemImage *resetButton = [CCMenuItemImage itemWithNormalImage:@"reset.png" selectedImage:@"reset.png" target:self selector:@selector(resetGameData)];
        CCMenu *resetMenu = [CCMenu menuWithItems:resetButton, nil];
        [resetMenu alignItemsVertically];
        resetMenu.position = ccp(screenCenter.x, screenCenter.y + 80);
        [self addChild:resetMenu z:1000];
        
        CCLabelBMFont *resetLabel = [CCLabelTTF labelWithString:@"Reset Game Data" fontName:@"Roboto-Light" fontSize:20];
        resetLabel.position = ccp(screenCenter.x, resetMenu.position.y - 70);
        resetLabel.color = ccc3(0, 0, 0);
        [self addChild:resetLabel];
        
        
        CCLabelTTF *goBackToHomeLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"NexaBold" fontSize:22];
        goBackToHomeLabel.position = ccp(screenSize.width/2, 40);
        [self addChild:goBackToHomeLabel z:7];
        CCMenuItemImage *goBackToHome = [CCMenuItemImage itemWithNormalImage:@"flatButton.png" selectedImage:@"flatButtonSel.png" target:self selector:@selector(goHome)];
        goBackToHome.scale = 1.5f;
//        [goBackToHome setFontName:@"Roboto-Light"];
//        [goBackToHome setFontSize:25];
//        goBackToHome.color = ccc3(0, 0, 0);
        
        CCMenu *goHomeMenu = [CCMenu menuWithItems:goBackToHome, nil];
        [goHomeMenu alignItemsVertically];
        goHomeMenu.position = ccp(screenSize.width/2, 40);
        [self addChild:goHomeMenu];
        
        CCMenuItemImage *fbLogin = [CCMenuItemImage itemWithNormalImage:@"fblogin.png" selectedImage:@"fbloginSel.png" target:self selector:@selector(loginWithFacebook)];
        CCMenu *facebookLogin = [CCMenu menuWithItems:fbLogin, nil];
        [facebookLogin alignItemsVertically];
        facebookLogin.position = ccp(screenCenter.x, screenCenter.y - 100);
        [self addChild:facebookLogin z:1000];
        
        CCSprite *background;
        
        if ([[CCDirector sharedDirector] winSizeInPixels].height == 1024) {
            background = [CCSprite spriteWithFile:@"skybgip5.png"];
        } else {
            background = [CCSprite spriteWithFile:@"skybgip5.png"];
        }
        
        background.position = screenCenter;
        [self addChild:background z:-100];
        
        
    }
    return self;
}

-(void) goHome
{
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFadeTR transitionWithDuration:0.5f scene:[StartMenuLayer node]]];
}

-(void) loginWithFacebook
{
    if ([MGWU isFacebookActive] == false) {
        [MGWU loginToFacebook];
    } else {
        [self openFBPrompt];
    }
}

- (void)openFBPrompt
{
    FBalert = [[UIAlertView alloc] init];
    [FBalert setTitle:@"Logged into Facebook"];
    [FBalert setMessage:@"You are already logged into Facebook!"];
    [FBalert setDelegate:self];
    [FBalert addButtonWithTitle:@"OK"];
    [FBalert show];
    //    [alert removeFromSuperview];
}


-(void) selfDestruct
{
    // Reset all game data
    
    
    [MGWU removeObjectForKey:@"sharedCoins"]; // reset coins
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"power1Status"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"power2Status"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"power3Status"]; // reset powerups
    [MGWU removeObjectForKey:@"sharedHighScore"]; // reset high score, but not leaderboard
    [MGWU removeObjectForKey:@"sharedScore"]; // reset last played score
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tutorialStatus"];
    
    [MGWU showMessage:@"All game data has been reset." withImage:nil];
}

- (void)resetGameData
{
    alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Reset Game Data"];
    [alert setMessage:@"Are you sure you would like to reset all of the game data? This action cannot be reversed."];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"Yes"];
    [alert addButtonWithTitle:@"No"];
    [alert show];
//    [alert removeFromSuperview];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == (UIAlertView *)alert) {
        if (buttonIndex == 0)
        {
            [self selfDestruct];
        }
        else if (buttonIndex == 1)
        {
            [MGWU showMessage:@"Game data reset was cancelled." withImage:nil];
        }
    }
    
    if (alertView == (UIAlertView *)FBalert) {
        if (buttonIndex == 0)
        {
//            [self selfDestruct];
        }
    }
}


@end
