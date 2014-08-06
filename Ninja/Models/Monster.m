//
//  Monster.m
//  Ninja
//
//  Created by Damien Locque on 20/07/14.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "Monster.h"
#import "WorldsUtil.h"

#import "CCActionInterval.h"

@implementation Monster

@synthesize duration;
@synthesize life;
@synthesize currentLife;
@synthesize posY;
@synthesize posX;
@synthesize lifebar;

- (id) init
{
    if ((self = [super init]))
    {
        duration = 5.0;
        life = 1;
        currentLife = life;
    }
    return self;
}

- (void) initLife
{
    CCSprite *lspr = [CCSprite spriteWithImageNamed:@"lifebar.png"];
    lifebar = [CCProgressNode progressWithSprite:lspr];
    lifebar.type = CCProgressNodeTypeBar;
    lifebar.midpoint = ccp(0.0f, 0.0f);
    lifebar.barChangeRate = ccp(1.0f, 0.0f);
    lifebar.percentage = 100.0f;
    lifebar.position = ccp(self.boundingBox.size.width / 2.0f, self.boundingBox.size.height + (lifebar.boundingBox.size.height / 2.0));
    [self addChild:lifebar];
}

- (void) updateLifeBar
{
    float percent = roundf((float)currentLife * 100.0 / (float)life);
    lifebar.percentage = percent;
}

- (void) takeDamages:(int)damages
{
    currentLife -= damages;
    [self updateLifeBar];
}

-(BOOL) isDead
{
    return (currentLife <= 0) ? YES : NO;
}

- (void) createAnimation { }
- (void) addMovements { }

- (void) setPosition
{
    int minY = self.contentSize.height / 2;
    int maxY = [[WorldsUtil getInstance] WorldHeight] - self.contentSize.height / 2;
    int rangeY = maxY - minY;

    posY = (arc4random() % rangeY) + minY;
    posX = [[WorldsUtil getInstance] WorldWidth] + self.contentSize.width / 2;
    self.position = CGPointMake(posX, posY);
}

- (void) addPhysics
{
    self.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, self.contentSize} cornerRadius:0];
    self.physicsBody.collisionGroup = @"monsterGroup";
    self.physicsBody.collisionType  = @"monsterCollision";
    self.physicsBody.type = CCPhysicsBodyTypeStatic;
}

- (void) removePhysics
{
//    sprite.physicsBody.collisionGroup = @"none";
    self.physicsBody.collisionType = @"none";
}

- (void) stopAnim { [self stopAllActions]; }

- (void) die
{
    [self stopAllActions];
    [self runAction:[CCActionSequence actionWithArray:@[[CCActionRemove action]]]];
}

@end
