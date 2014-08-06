//
//  WorldsUtil.h
//  Ninja
//
//  Created by Damien Locque on 20/07/14.
//  Copyright (c) 2014 Damien Locque. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WorldsUtil : NSObject

@property (nonatomic, assign) int WorldWidth;
@property (nonatomic, assign) int WorldHeight;
@property (nonatomic, strong) CCPhysicsNode *physicsWorld;
@property (nonatomic, strong) CCScene *scene;
@property (nonatomic, assign) BOOL debugMode;
@property (nonatomic, assign) BOOL displayLife;


+ (id) getInstance;
- (id) init;
- (id) initWithScene:(CCScene *)sc;
- (void) toggleDebugMode;

@end
