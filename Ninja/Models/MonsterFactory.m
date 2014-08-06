//
//  MonsterFactory.m
//  Ninja
//
//  Created by Damien Locque on 20/07/14.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import "MonsterFactory.h"

#import "Cookie.h"
#import "Chronik.h"
#import "DarkCookie.h"
#import "Donut.h"
#import "Cupcake.h"

@implementation MonsterFactory
{
    NSMutableDictionary *_monsters;
}

#pragma mark Singleton Methods

+ (id)getInstance {
    static MonsterFactory *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id) init
{
    if ((self = [super init]))
    {
        _monsters = [[NSMutableDictionary alloc] init];

        [_monsters setObject:Chronik.class forKey:@"chronik"];
        [_monsters setObject:Cookie.class forKey:@"cookie"];
        [_monsters setObject:DarkCookie.class forKey:@"darkcookie"];
        [_monsters setObject:Donut.class forKey:@"donut"];
        [_monsters setObject:Cupcake.class forKey:@"cupcake"];
    }
    return self;
}

- (Monster *)monsterForKey:(NSString *)mKey {
    Monster *monster = nil;
    if ([_monsters objectForKey:mKey])
        monster = [[[_monsters objectForKey:mKey] alloc] init];
    else
        NSAssert(NO, @"No Monster found for key:'%@'", mKey);
    return monster;
}

@end
