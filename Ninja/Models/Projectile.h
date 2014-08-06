//
//  Projectile.h
//  Ninja
//
//  Created by Damien Locque on 2014-07-21.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface Projectile : CCSprite

- (id) init;

- (void) createAnimation;
- (void) addPhysics;

- (void) stopAnim;

- (void) die;
- (void) moveTo:(CGPoint)pos;

@end
