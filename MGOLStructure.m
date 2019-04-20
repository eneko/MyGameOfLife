//
//  MGOLStructure.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import "MGOLStructure.h"
#import "MGOLCell.h"

@implementation MGOLStructure

- (id) init
{
    NSLog(@"MGOLStructure init");
    [super init];
    [self setStructureName:@"New structure"];    
    [self setStructureSize:NSMakeSize(10, 10)];
        
    // Add some random cells
    cells = [NSMutableArray new];
    int i;
    for (i=0; i<10; i++)
    {
        MGOLCell *cell = [MGOLCell new];
        NSPoint newPoint;
        do {
            newPoint = NSMakePoint(random() % 10, random() % 10);
        } while ([self indexOfCellAt:newPoint] > -1);
        [cell setPosition:newPoint];
        [cells addObject:cell];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"MGOLStructure dealloc");
    [structureName release];
    [cells release];
    [super dealloc];
}

- (NSString *)structureName
{
    return structureName;
}

- (void)setStructureName:(NSString *)newName
{
    NSLog(@"MGOLStructure setStructureName");
    newName = [newName copy];
    [structureName release];
    structureName = newName;
}

- (NSSize)structureSize
{
    return structureSize;
}

- (NSString *)structureSizeAsString
{
    return [NSString stringWithFormat:@"%0.0fx%0.0f", structureSize.width, structureSize.height];
}

- (void)setStructureSize:(NSSize)newSize
{
    NSLog(@"MGOLStructure setStructureSize");
    structureSize = newSize;
}

- (unsigned int)structureWidth
{
    return structureSize.width;
}

- (void)setStructureWidth:(unsigned int)newWidth
{
    NSLog(@"MGOLStructure setStructureWidth");
    structureSize.width = newWidth;
}

- (unsigned int)structureHeight
{
    return structureSize.height;
}

- (void)setStructureHeight:(unsigned int)newHeight
{
    NSLog(@"MGOLStructure setStructureHeight");
    structureSize.height = newHeight;
}

- (BOOL)isCellAlive:(NSPoint)cell
{
    return ([self indexOfCellAt:cell] > -1);
}

- (int)indexOfCellAt:(NSPoint)cell
{
    int i;
    for (i=0; i<[cells count]; i++)
    {
        MGOLCell *aCell = [cells objectAtIndex:i];
        if (NSEqualPoints([aCell position], cell))
            return i;
    }
    return -1;
}

- (void)flipCell:(NSPoint)cell
{
    NSLog(@"MGOLStructure flipCell");
    int index = [self indexOfCellAt:cell];
    if (index > -1)
    {
        [cells removeObjectAtIndex:index];
    }
    else
    {
        MGOLCell *newCell = [MGOLCell new];
        [newCell setPosition:cell];
        [cells addObject:newCell];
//        [newCell release];
    }
}


@end
