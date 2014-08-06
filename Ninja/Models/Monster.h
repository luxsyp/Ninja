//
//  Monster.h
//  Ninja
//
//  Created by Damien Locque on 20/07/14.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCAnimation.h"

@interface Monster : CCSprite
{
    int                 duration;
    int                 life;
    int                 currentLife;
    
    int                 posX;
    int                 posY;
}

@property (nonatomic, assign) int duration;
@property (nonatomic, assign) int life;
@property (nonatomic, assign) int currentLife;
@property (nonatomic, assign) int posX;
@property (nonatomic, assign) int posY;
@property (nonatomic, strong) CCSprite  *spriteSheet;
@property (nonatomic, strong) CCProgressNode *lifebar;

- (id) init;
- (void) setPosition;
- (void) addPhysics;
- (void) removePhysics;
- (void) addMovements;
- (void) createAnimation;
- (void) takeDamages:(int)damages;
- (BOOL) isDead;
- (void) initLife;

- (void) stopAnim;
- (void) die;

@end
