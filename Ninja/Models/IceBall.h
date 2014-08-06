//
//  IceBall.h
//  Ninja
//
//  Created by Damien Locque on 2014-07-23.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "Projectile.h"

@interface IceBall : Projectile

- (id) init;

- (void) createAnimation;
- (void) die;

@end
