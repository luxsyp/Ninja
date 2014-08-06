//
//  WorldsUtil.m
//  Ninja
//
//  Created by Damien Locque on 20/07/14.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "WorldsUtil.h"

@implementation WorldsUtil

@synthesize WorldWidth;
@synthesize WorldHeight;
@synthesize physicsWorld;
@synthesize scene;
@synthesize debugMode;
@synthesize displayLife;

#pragma mark Singleton Methods

+ (id)getInstance {
    static WorldsUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (id) init
{
    if ((self = [super init]))
    {
        NSLog(@"Init WorldsUtil");
        debugMode = true;
        displayLife = true;
    }
    return self;
}

- (id) initWithScene:(CCScene *)sc
{
    if ((self = [self init]))
    {
        scene = sc;
        WorldWidth = scene.contentSize.width;
        WorldHeight = scene.contentSize.height;
        
        physicsWorld = [CCPhysicsNode node];
        physicsWorld.gravity = ccp(0,0);
        physicsWorld.debugDraw = NO;
        [scene addChild:physicsWorld];
    }
    return self;
}

- (void) toggleDebugMode
{
    debugMode = !debugMode;
    physicsWorld.debugDraw = debugMode;
}

- (void) toggleLifeBar
{
    displayLife = !displayLife;
}

@end
