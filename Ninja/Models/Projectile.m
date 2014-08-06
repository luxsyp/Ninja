//
//  Projectile.m
//  Ninja
//
//  Created by Damien Locque on 2014-07-21.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "Projectile.h"

#import "cocos2d.h"
#import "WorldsUtil.h"

#import "CCActionInterval.h"
#import "CCAnimation.h"

@implementation Projectile

- (id) init
{
    return (self = [super init]);
}
   
- (void) createAnimation {}

- (void) addPhysics
{
    self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:self.contentSize.width/2.0f andCenter:self.anchorPointInPoints];
    self.physicsBody.collisionGroup = @"playerGroup";
    self.physicsBody.collisionType  = @"projectileCollision";
    self.physicsBody.type = CCPhysicsBodyTypeStatic;
}

- (void) stopAnim {}

- (void) die {}
- (void) moveTo:(CGPoint)pos
{
    CCActionMoveTo *actionMove   = [CCActionMoveTo actionWithDuration:1.5f position:pos];
    CCActionRemove *actionRemove = [CCActionRemove action];
    [self runAction:[CCActionSequence actionWithArray:@[actionMove,actionRemove]]];
}

@end
