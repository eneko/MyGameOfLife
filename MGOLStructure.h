//
//  MGOLStructure.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGOLCell.h"

@interface MGOLStructure : NSObject {
    NSString       *structureName;
    NSSize          structureSize;
    NSMutableArray *cells;
}

- (NSString *)structureName;
- (unsigned int)structureWidth;
- (unsigned int)structureHeight;
- (NSSize)structureSize;
- (NSString *)structureSizeAsString;
- (void)setStructureName:(NSString *)newName;
- (void)setStructureSize:(NSSize)newSize;
- (void)setStructureWidth:(unsigned int)newWidth;
- (void)setStructureHeight:(unsigned int)newHeight;

- (BOOL)isCellAlive:(NSPoint)cell;
- (void)flipCell:(NSPoint)cell;
- (int)indexOfCellAt:(NSPoint)cell;


@end
