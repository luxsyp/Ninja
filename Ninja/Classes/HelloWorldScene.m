//
//  HelloWorldScene.m
//  Ninja
//
//  Created by Damien Locque on 20/07/14.
//  Copyright Damien Locque 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"

#import "WorldsUtil.h"

#import "Player.h"
#import "Projectile.h"
#import "MonsterFactory.h"

#import "FireBall.h"
#import "IceBall.h"

#import <CoreMotion/CoreMotion.h>

// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    // variables
    int             _monsterKilled;
    int             _monsterSpawned;
    
    int             _projectileFired;
    int             _projectileAccurate;
    
    Player          *_player;
    
    // graphics
    MonsterFactory  *_mFactory;

    // move accelerometer
    CMMotionManager *_motionManager;
    float _shipPointsPerSecY;
}


// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (void) initGui
{
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f]];
    [self addChild:background];
    
    // Back To Menu Button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    // Debug Mode
    CCButton *debugButton = [CCButton buttonWithTitle:@"[ Debug ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    debugButton.positionType = CCPositionTypeNormalized;
    debugButton.position = ccp(0.15f, 0.95f); // Top Right of screen
    [debugButton setTarget:self selector:@selector(onDebugClicked:)];
    [self addChild:debugButton];
}



- (id)init
{
    self = [super init];
    if (!self)
        return(nil);
    
    self.userInteractionEnabled = YES;
    
    [self initGui];
    
    // Util init
    (void)[[WorldsUtil getInstance] initWithScene:self];
    [[WorldsUtil getInstance] physicsWorld].collisionDelegate = self;
    
    // Add Stars
    
    
    // Create hero
    _player = [[Player alloc] init];
    [_player playIdleAnim];
    [[[WorldsUtil getInstance] physicsWorld] addChild:_player];
    
    // autofire mode one
    [self schedule:@selector(autoFire:) interval:0.25];

    // Play epic music all game long
    [[OALSimpleAudio sharedInstance] playBg:@"background-music-aac.caf" loop:YES];
    
    // accelerometer
    _motionManager = [[CMMotionManager alloc] init];
    
    return self;
}


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
#define kFilteringFactor 0.1
#define kRestAccelX -0.6
#define kShipMaxPointsPerSec (self.contentSize.height*0.5)
#define kMaxDiffX 0.2
    
    NSLog(@"accel");
    
    UIAccelerationValue rollingX, rollingY, rollingZ;
    
    rollingX = (acceleration.x * kFilteringFactor) + (rollingX * (1.0 - kFilteringFactor));
    rollingY = (acceleration.y * kFilteringFactor) + (rollingY * (1.0 - kFilteringFactor));
    rollingZ = (acceleration.z * kFilteringFactor) + (rollingZ * (1.0 - kFilteringFactor));
    
    float accelX = acceleration.x - rollingX;
    float accelDiff = accelX - kRestAccelX;
    float accelFraction = accelDiff / kMaxDiffX;
    float pointsPerSec = kShipMaxPointsPerSec * accelFraction;
    
    _shipPointsPerSecY = pointsPerSec;
}


// -----------------------------------------------------------------------

- (void)addMonster:(CCTime)dt {
    Monster *monster = nil;
    NSArray *monsterList = [NSArray arrayWithObjects:
                            @"cookie",
                            @"darkcookie",
                            @"donut",
                            @"cupcake",
//                            @"chronik",
                            nil];

    int rd = arc4random() % [monsterList count];
    monster  = [[MonsterFactory getInstance] monsterForKey:[monsterList objectAtIndex:rd]];
    [[[WorldsUtil getInstance] physicsWorld] addChild:monster];
    _monsterSpawned++;
}

#pragma mark - Enter & Exit

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    [self schedule:@selector(addMonster:) interval:0.5];
    [_motionManager startAccelerometerUpdates];
}

- (void) update:(CCTime)delta {
   // [super update:delta];
    
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
    CGFloat newYPosition = _player.position.y + (0.5 - acceleration.x) * 1300 * delta;
    newYPosition = clampf(0, newYPosition, self.contentSize.height);
    if (((newYPosition + (_player.contentSize.height / 2.0)) <= self.contentSize.height)
        && (newYPosition - (_player.contentSize.height / 2.0) >= 0.0))
        _player.position = CGPointMake(_player.position.x, newYPosition);
}

- (void)onExit
{
    // always call super onExit last
    [super onExit];
    [_motionManager stopAccelerometerUpdates];
}

#pragma mark - Touch Handler


- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [touch locationInNode:self];

    // create triangle
    CGPoint offset = ccpSub(touchLocation, _player.position);
    int factor = self.contentSize.width/offset.x + 1; //see how much does fit in the screen and add one to make sure it is out of sight
    int     targetX   = offset.x * factor + _player.position.x;
    int     targetY   = offset.y * factor + _player.position.y;
    CGPoint targetPosition = ccp(targetX,targetY);
    
    Projectile *projectile = (_projectileFired % 2 == 0) ? [[FireBall alloc] init] : [[IceBall alloc] init] ;
    [projectile setPosition:ccp(_player.position.x + (_player.contentSize.width / 2.0), _player.position.y)];
  
    [[[WorldsUtil getInstance] physicsWorld] addChild:projectile];

    [projectile moveTo:targetPosition];
    
    // stats
    _projectileFired++;
}

 
- (void)autoFire:(CCTime)dt
{
    CGPoint targetPosition = ccp(self.contentSize.width + 20, _player.position.y);
    
    Projectile *projectile = (_projectileFired % 2 == 0) ? [[FireBall alloc] init] : [[IceBall alloc] init] ;
    [projectile setPosition:ccp(_player.position.x + (_player.contentSize.width / 2.0), _player.position.y)];
    [[[WorldsUtil getInstance] physicsWorld] addChild:projectile];
    
    [projectile moveTo:targetPosition];
  
    // stats
    _projectileFired++;
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [_player playIdleAnim];
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair monsterCollision:(CCNode *)monster projectileCollision:(CCNode *)projectile {
    
    if ([monster isKindOfClass:Monster.class])
    {
        Monster *m = (Monster *)monster;
        
        [m takeDamages:1];
        if ([m isDead])
        {
            _monsterKilled++;
            [m die];
        }
    }
    
    if ([projectile isKindOfClass:Projectile.class])
    {
        _projectileAccurate++;
        [(Projectile *)projectile die];
    }

    return YES;
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair monsterCollision:(CCNode *)monster playerCollision:(CCNode *)player
{
    if ([monster isKindOfClass:Monster.class])
    {
        _monsterKilled++;
        [(Monster *)monster die];
    }
    return YES;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

- (void)onDebugClicked:(id)sender
{
    [[WorldsUtil getInstance] toggleDebugMode];
}

// -----------------------------------------------------------------------
@end
