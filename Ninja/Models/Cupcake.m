//
//  Cupcake.m
//  Ninja
//
//  Created by Damien Locque on 2014-07-24.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "Cupcake.h"

#import "WorldsUtil.h"

#import "CCActionInterval.h"
#import "CCAnimation.h"

#import "GCCShapeCache.h"

@implementation Cupcake

- (id) init
{
    if (self = [super init])
    {
        self.duration = 2.5;
        self.life = 3;
        self.currentLife = self.life;
        [self createAnimation];
        [self setPosition];
        [self customPhysics];
        [self addMovements];
        // [self initLife];
    }
    return self;
}

- (void) createAnimation
{
    [self setSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"cupcake.png"]];
}

- (void) addMovements
{
    CCAction *actionMove = [CCActionMoveTo actionWithDuration:self.duration position:CGPointMake(-self.contentSize.width / 2, posY)];
    CCAction *actionRemove = [CCActionRemove action];
    [self runAction:[CCActionSequence actionWithArray:@[actionMove,actionRemove]]];
}

- (void) customPhysics
{
//    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
    self.physicsBody = [[GCCShapeCache sharedShapeCache] createBodyWithName:@"cupcake"];

  //  [[GCCShapeCache sharedShapeCache] setBodyWithName:@"cupcake" onNode:self];
//    self.sprite.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:self.sprite.contentSize.width / 2.5f andCenter:self.sprite.anchorPointInPoints];
    //self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
    self.physicsBody.collisionGroup = @"monsterGroup";
    self.physicsBody.collisionType  = @"monsterCollision";
    self.physicsBody.type = CCPhysicsBodyTypeStatic;
}

@end
