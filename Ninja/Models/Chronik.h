//
//  Chronik.h
//  Ninja
//
//  Created by Damien Locque on 2014-07-21.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "Monster.h"

@interface Chronik : Monster

- (id) init;
- (void) createAnimation;
- (void) addMovements;
- (void) playDieAnim;

@end
