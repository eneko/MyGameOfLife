//
//  MGOLCellProcessor.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGOLStructure.h"

@interface MGOLCellProcessor : NSObject {
    // Cell arrays
    char **cellArray1; // Actual array 1
    char **cellArray2; // Actual array 2

    // Array pointers
    char **cellsNow;   // Points to cells to draw
    char **cellsNext;  // Points to next step
    char **cellsPrev;  // For pointer swaping
    
    // Cell behavior settings
    char cellGrowsIf[9];      // 0..8 neightbors
    char cellStaysAliveIf[9]; // 0..8 neightbors
    
    unsigned long int cycleCounter;
    unsigned int population;
    unsigned int cellsX;
    unsigned int cellsY;
}

- (void)initCellArrays;
- (void)freeCellArrays;
- (void)fillRandom;
- (void)clearCells;
- (void)flipCell:(NSPoint)cell;
- (void)setCell:(NSPoint)cell alive:(BOOL)state;

- (void)processCells;
- (void)replicateBorderCells;

- (NSSize)worldSize;
- (void)setWorldSize:(NSSize)newSize;

- (unsigned int) cycleCounter;
- (unsigned int) population;
- (BOOL)isCellAlive:(NSPoint)cell;

- (void)setCellBehavior:(id)sender
              cellBorn0:(BOOL)cb0
              cellBorn1:(BOOL)cb1
              cellBorn2:(BOOL)cb2
              cellBorn3:(BOOL)cb3
              cellBorn4:(BOOL)cb4
              cellBorn5:(BOOL)cb5
              cellBorn6:(BOOL)cb6
              cellBorn7:(BOOL)cb7
              cellBorn8:(BOOL)cb8
        cellStaysAlive0:(BOOL)cs0
        cellStaysAlive1:(BOOL)cs1
        cellStaysAlive2:(BOOL)cs2
        cellStaysAlive3:(BOOL)cs3
        cellStaysAlive4:(BOOL)cs4
        cellStaysAlive5:(BOOL)cs5
        cellStaysAlive6:(BOOL)cs6
        cellStaysAlive7:(BOOL)cs7
        cellStaysAlive8:(BOOL)cs8;

- (MGOLStructure *)structureFromRect:(NSRect)rect;
- (void)placeStructure:(MGOLStructure *)structure At:(NSPoint)point;


@end
