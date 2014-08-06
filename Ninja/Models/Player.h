//
//  PLayer.h
//  Ninja
//
//  Created by Damien Locque on 2014-07-21.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface Player : CCSprite

- (id) init;
- (void) createAnimation;

- (void) setPosition;
- (void) addPhysics;
- (void) stopAnim;
- (void) playIdleAnim;
- (void) playShotFireAnim;

@end
