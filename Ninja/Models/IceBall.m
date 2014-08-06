//
//  IceBall.m
//  Ninja
//
//  Created by Damien Locque on 2014-07-23.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "IceBall.h"

#import "cocos2d.h"
#import "WorldsUtil.h"

#import "CCActionInterval.h"
#import "CCAnimation.h"

@implementation IceBall
{
    CCActionAnimate *walkAnimation;
    CCActionAnimate *dieAnimation;
}

- (id) init
{
    if (self = [super init])
    {
        [self setSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"iceball_0001.png"]];
        [self createAnimation];
        [self addPhysics];
        [[OALSimpleAudio sharedInstance] playEffect:@"pew-pew-lei.caf"];
    }
    return self;
}

- (void) createAnimation
{
    // walk anim
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i = 1 ; i <= 6; i++)
    {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"iceball_00%.2d.png",i]]];
    }
    CCAnimation *animationWalk = [CCAnimation animationWithSpriteFrames: walkAnimFrames delay:0.025];
    walkAnimation = [CCActionAnimate actionWithAnimation:animationWalk];
    
    // die anim
    NSMutableArray *dieAnimFrames = [NSMutableArray array];
    for (int i = 1 ; i <= 9; i++)
    {
        [dieAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"iceball_hit_00%.2d.png",i]]];
    }
    CCAnimation *animationDie = [CCAnimation animationWithSpriteFrames: dieAnimFrames delay:0.06f];
    dieAnimation = [CCActionAnimate actionWithAnimation:animationDie];
    
    // Play Walk Anim
    CCActionRepeatForever *repeatingAnimation = [CCActionRepeatForever actionWithAction:walkAnimation];
    [self runAction:repeatingAnimation];
}

- (void) die
{
    [self stopAllActions];
    [self runAction:[CCActionSequence actionWithArray:@[dieAnimation, [CCActionRemove action]]]];
}

@end
