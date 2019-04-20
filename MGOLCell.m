//
//  MGOLCell.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import "MGOLCell.h"

@implementation MGOLCell

-(id)init
{
    [super init];
    [self setPosition:NSMakePoint(0, 0)];
    [self setState:NO];
    return self;
}

- (NSPoint)position
{
    return position;
}

- (void)setPosition:(NSPoint)newPosition
{
    position = newPosition;
}

- (BOOL)isAlive
{
    return isAlive;
}

- (void)setState:(BOOL)newState
{
    isAlive = newState;
}

- (BOOL)flip
{
    isAlive = !isAlive;
    return isAlive;
}

@end
