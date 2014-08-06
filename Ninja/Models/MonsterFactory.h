//
//  MonsterFactory.h
//  Ninja
//
//  Created by Damien Locque on 20/07/14.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Monster.h"

@interface MonsterFactory : NSObject

+ (id) getInstance; // singleton

- (id) init;
- (Monster *)monsterForKey:(NSString *)mKey;

@end
