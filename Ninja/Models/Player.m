//
//  PLayer.m
//  Ninja
//
//  Created by Damien Locque on 2014-07-21.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "Player.h"

#import "WorldsUtil.h"

#import "CCActionInterval.h"
#import "CCAnimation.h"

@implementation Player
{
    CCActionAnimate     *idleAnimation;
    CCActionAnimate     *shotAnimation;
}

- (id) init
{
    if (self = [super init])
    {
        [self createAnimation];
        [self setPosition];
        [self addPhysics];
    }
    return self;
}

- (void) createAnimation
{
   [self setSpriteFrame: [CCSpriteFrame frameWithImageNamed:@"spaceship.png"]];
}

- (void) setPosition
{
    self.position  = ccp([[WorldsUtil getInstance] scene].contentSize.width / 10,
                           [[WorldsUtil getInstance] scene].contentSize.height / 2);
}

- (void) addPhysics
{
    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
    self.physicsBody.collisionGroup = @"playerGroup";
    self.physicsBody.collisionType = @"playerCollision";
    self.physicsBody.type = CCPhysicsBodyTypeStatic;
}

- (void) stopAnim
{
    [self stopAllActions];
}

- (void) playIdleAnim
{
    CCParticleSystem *emitter = [[CCParticleFire alloc] init];

    emitter = [[CCParticleFire alloc] init];
    emitter.scale = 0.2;
    emitter.position = ccp(self.contentSize.width / 3, self.contentSize.height / 2);
    emitter.rotation = -90;
    emitter.startColor = [CCColor colorWithRed:0.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f];
    
    [self addChild:emitter z:-1];
}

- (void) playShotFireAnim
{
}

@end
