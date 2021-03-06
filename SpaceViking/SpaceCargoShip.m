//
//  SpaceCargoShip.m
//  SpaceViking
//
//  Created by Piotr Dudzicz on 7/10/12.
//  Copyright (c) 2012 PolSource Sp. z o.o. All rights reserved.
//

#import "SpaceCargoShip.h"

@implementation SpaceCargoShip


@synthesize delegate;

-(void) dropCargo
{
    CGPoint cargoDropPosition = ccp(screenSize.width / 2, screenSize.height);
    
    if (hasDroppedMallet == NO) {
        CCLOG(@"SpaceCargoShip --> Mallet Powerup was created!");
        hasDroppedMallet = YES;
        [delegate createObjectOfType:kPowerUpTypeMallet 
                          withHealth:0.0f 
                          atLocation:cargoDropPosition 
                          withZValue:50];
    }
    else {
        CCLOG(@"SpaceCargoShip --> Health Powerup was created!");
        [delegate createObjectOfType:kPowerUpTypeHealth 
                          withHealth:100.0f 
                          atLocation:cargoDropPosition 
                          withZValue:50];
    }
}

-(id) init
{
    if ( (self = [super init]) ) {
        CCLOG(@"SpaceCargoShip init");
        hasDroppedMallet = NO;
        soundNumberToPlay = 0;
        float shipHeight = screenSize.height * 0.71f;
        
        CGPoint position1 = ccp(screenSize.width * -0.48f, shipHeight);
        CGPoint position2 = ccp(screenSize.width * 2.0f, shipHeight);
        CGPoint position3 = ccp(position2.x *  -1.0f, shipHeight);
        CGPoint offScreen = ccp(screenSize.width * -1.0f, screenSize.height * -1.0f);
        
        id action = [CCRepeatForever actionWithAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.0f], 
                                                       [CCMoveTo actionWithDuration:0.01f position:position1],
                                                       [CCScaleTo actionWithDuration:0.01f scale:0.5f],
                                                       [CCFlipX actionWithFlipX:YES],
                                                       [CCCallFunc actionWithTarget:self selector:@selector(playSpaceCargoShipSound)],
                                                       [CCMoveTo actionWithDuration:8.5f
                                                                           position:position2],
                                                       [CCScaleTo actionWithDuration:0.1f scale:1.0f],
                                                       [CCFlipX actionWithFlipX:NO],
                                                       [CCCallFunc actionWithTarget:self selector:@selector(playSpaceCargoShipSound)],
                                                       [CCMoveTo actionWithDuration:7.5
                                                                           position:position3],
                                                       [CCScaleTo actionWithDuration:0.1f scale:2.0f],
                                                       [CCFlipX actionWithFlipX:YES],
                                                       [CCCallFunc actionWithTarget:self selector:@selector(playSpaceCargoShipSound)],
                                                       [CCMoveTo actionWithDuration:6.5f
                                                                           position:position2],
                                                       [CCFlipX actionWithFlipX:NO],
                                                       [CCScaleTo actionWithDuration:0.1f scale:2.0f],
                                                       [CCCallFunc actionWithTarget:self selector:@selector(playSpaceCargoShipSound)],
                                                       [CCMoveTo actionWithDuration:5.5
                                                                           position:position3],
                                                       [CCFlipX actionWithFlipX:YES],
                                                       [CCScaleTo actionWithDuration:0.1f scale:4.0f],
                                                       [CCCallFunc actionWithTarget:self selector:@selector(playSpaceCargoShipSound)],
                                                       [CCMoveTo actionWithDuration:4.5f
                                                                           position:position2],
                                                       [CCCallFunc actionWithTarget:self selector:@selector(dropCargo)],
                                                       [CCMoveTo actionWithDuration:0.0f position:offScreen],
                                                       nil]];
                     
        [self runAction:action];
    }
    
    return self;
}

#pragma mark -
#pragma mark SoundMethods

-(void) playSpaceCargoShipSound {
    if (soundNumberToPlay < 2) {
        PLAYSOUNDEFFECT(SPACECARGOSHIP_FAR);
    } else if (soundNumberToPlay == 2) {
        PLAYSOUNDEFFECT(SPACECARGOSHIP_CLOSE_1);
    } else if (soundNumberToPlay == 3) {
        PLAYSOUNDEFFECT(SPACECARGOSHIP_CLOSE_2);
    } else if (soundNumberToPlay == 4) {
        PLAYSOUNDEFFECT(SPACECARGOSHIP_CLOSE_3);
    }
    
    soundNumberToPlay += 1;
    if (soundNumberToPlay > 4) {
        soundNumberToPlay = 0;
    }
}

@end





