//
//  Chronik.m
//  Ninja
//
//  Created by Damien Locque on 2014-07-21.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "Chronik.h"

#import "CCActionInterval.h"
#import "CCAnimation.h"

@implementation Chronik
{
    CCActionAnimate *walkAnimation;
    CCActionAnimate *dieAnimation;
}

- (id) init
{
    if (self = [super init])
    {
        self.duration = 2.0;
        self.life = 3;
        self.currentLife = self.life;
        [self createAnimation];
        [self setPosition];
        [self addPhysics];
        [self addMovements];
        [self initLife];
    }
    return self;
}

- (void) createAnimation
{
    [self setSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"chronik_run0001.png"]];

    // walk anim
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i = 1 ; i <= 18; i++)
    {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chronik_run00%.2d.png",i]]];
    }
    CCAnimation *animationWalk = [CCAnimation animationWithSpriteFrames: walkAnimFrames delay:0.06f];
    walkAnimation = [CCActionAnimate actionWithAnimation:animationWalk];
    

    // die anim
    NSMutableArray *dieAnimFrames = [NSMutableArray array];
    for (int i = 1 ; i <= 45; i++)
    {
        [dieAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"chronik_fallback00%.2d.png",i]]];
    }
    CCAnimation *animationDie = [CCAnimation animationWithSpriteFrames: dieAnimFrames delay:0.03f];
    dieAnimation = [CCActionAnimate actionWithAnimation:animationDie];
    
    // Play Walk Anim
    CCActionRepeatForever *repeatingAnimation = [CCActionRepeatForever actionWithAction:walkAnimation];
    [self runAction:repeatingAnimation];
}

- (void) addMovements
{
    CCAction *actionMove = [CCActionMoveTo actionWithDuration:self.duration position:CGPointMake(-self.contentSize.width / 2, posY)];
    
    CCAction *actionRemove = [CCActionRemove action];
    [self runAction:[CCActionSequence actionWithArray:@[actionMove,actionRemove]]];
}

- (void) playDieAnim
{
    [self removePhysics];
    CCAction *die = [self runAction:dieAnimation];
    CCAction *actionRemove = [CCActionRemove action];
    [self runAction:[CCActionSequence actionWithArray:@[die ,actionRemove]]];
}

@end
