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
    cells = [NSMutableArray new];
    [self setStructureName:@"New structure"];    
    [self setStructureSize:NSMakeSize(10, 10)];
        
    /* Add some random cells
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
    }*/
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
        MGOLCell *newCell = [[MGOLCell new] retain];
        [newCell setPosition:cell];
        [cells addObject:newCell];
        [newCell release];
    }
}

- (void)clear
{
    NSLog(@"MGOLStructure clear");
    [cells removeAllObjects];
}

- (NSArray *)cellArray
{
    return cells;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    NSLog(@"MGOLStructure encodeWithCoder");
    [coder encodeObject:structureName forKey:@"MGOLStructureStructureNameKey"];
    [coder encodeSize:structureSize   forKey:@"MGOLStructureStructureSizeKey"];
    [coder encodeObject:cells         forKey:@"MGOLStructureCellsKey"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    NSLog(@"MGOLStructure initWithCoder");
    if (self = [super init])//WithCoder:coder])
    {
        cells = [NSMutableArray new];
        [self setStructureName:[coder decodeObjectForKey:@"MGOLStructureStructureNameKey"]];
        [self setStructureSize:[coder decodeSizeForKey:@"MGOLStructureStructureSizeKey"]];
        [self setCells:[coder decodeObjectForKey:@"MGOLStructureCellsKey"]];
    }
    return self;
}

- (void)setCells:(NSArray *)newCells
{
    NSLog(@"MGOLStructure setCells");
    [cells setArray:newCells];
}

- (NSString *)description
{
    NSString *desc = [NSString new];    
    desc = [desc stringByAppendingString:@"Structure:\n"];
    
    int i;
    for (i=0; i<[cells count]; i++)
    {
        desc = [desc stringByAppendingFormat:@"%@", [cells objectAtIndex:i]];
    }    
    
    desc = [desc stringByAppendingString:@"End of Structure."];
    //[desc autorelease];
    return desc;
}
@end
