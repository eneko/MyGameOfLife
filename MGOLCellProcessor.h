//
//  MGOLCellProcessor.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>

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

@end
