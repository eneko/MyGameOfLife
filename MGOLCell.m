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

- (NSString *)description
{
    return [NSString stringWithFormat:@"cell: %0f, %0f\n", position.x, position.y];
}    

- (void)encodeWithCoder:(NSCoder *)coder
{
    NSLog(@"MGOLCell encodeWithCoder");
    [coder encodePoint:position forKey:@"MGOLCellPositionKey"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    NSLog(@"MGOLCell initWithCoder");
    if (self = [super init])
    {
        [self setPosition:[coder decodePointForKey:@"MGOLCellPositionKey"]];
    }
    return self;
}


@end
