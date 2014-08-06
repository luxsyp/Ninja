//
//  IntroScene.m
//  Ninja
//
//  Created by Damien Locque on 20/07/14.
//  Copyright Damien Locque 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "HelloWorldScene.h"
#import "WorldsUtil.h"

#import "GCCShapeCache.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey) - and image
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Play button
    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"[ Start ]" fontName:@"Verdana-Bold" fontSize:40.0f];
    helloWorldButton.positionType = CCPositionTypeNormalized;
    helloWorldButton.position = ccp(0.5f, 0.2f);
    [helloWorldButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:helloWorldButton];     
    
    
    // Load Extras Ressources
    NSMutableArray *ressourceObjects = [[NSMutableArray alloc] init];
    // monsters
    [ressourceObjects addObject:@"chronik.plist"];
    [ressourceObjects addObject:@"chronik-die.plist"];

    // projectiles
    [ressourceObjects addObject:@"fireball.plist"];
    [ressourceObjects addObject:@"fireball_die.plist"];
    [ressourceObjects addObject:@"iceball.plist"];
    [ressourceObjects addObject:@"iceball_die.plist"];
    
    // enemies
    [ressourceObjects addObject:@"space_enemies.plist"];
    
    // Load Physics items
    [[GCCShapeCache sharedShapeCache] addShapesWithFile:@"cupcake_physics.plist"];

    // load them all
    for (int i = 0 ; i < [ressourceObjects count] ; i++)
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[ressourceObjects objectAtIndex:i]];
    
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[HelloWorldScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
