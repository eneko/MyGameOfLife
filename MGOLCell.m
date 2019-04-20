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
    NSLog(@"MGOLCell init");
    [super init];
    [self setPosition:NSMakePoint(0, 0)];
    return self;
}

- (NSPoint)position
{
    return position;
}

- (void)setPosition:(NSPoint)newPosition
{
    NSLog(@"MGOLCell setPosition");
    position = newPosition;
}

@end
