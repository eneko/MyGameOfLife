//
//  MGOLCellProcessor.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import "MGOLCellProcessor.h"
#import "MGOLGlobals.h"

@implementation MGOLCellProcessor

- (id)init {    
    [super init];
    NSLog(@"MGOLCellProcessor init");
    if (self) {
        [self initCellArrays];
        [self clearCells];
    }
    population   = 0;
    cycleCounter = 0;
    
    cellsX = 200;
    cellsY = 100;
    
    memset(cellGrowsIf, 0, sizeof(cellGrowsIf));
    cellGrowsIf[3] = 1;
    memset(cellStaysAliveIf, 0, sizeof(cellStaysAliveIf));
    cellStaysAliveIf[2] = 1;
    cellStaysAliveIf[3] = 1;

    return self;
}

-(void) dealloc
{
    NSLog(@"MGOLCellProcessor dealloc");
    [self freeCellArrays];    
    [super dealloc];
}

- (void)initCellArrays
{
    NSLog(@"MGOLCellProcessor initCellArrays");

    // Initialize arrays
    int i;
    
    cellArray1 = malloc(maxX * sizeof(char *));
    for(i = 0; i < maxX; i++)
        cellArray1[i] = malloc(maxY * sizeof(char));
    
    cellArray2 = malloc(maxX * sizeof(char *));
    for(i = 0; i < maxX; i++)
        cellArray2[i] = malloc(maxY * sizeof(char));
    
    // Initialize array pointers
    cellsNow  = cellArray1;
    cellsNext = cellArray2;
    cellsPrev = cellsNext;            
}

- (void)freeCellArrays
{
    NSLog(@"MGOLCellProcessor freeCellArrays");

    // Free arrays
    int i;

    for(i = 0; i < maxX; i++)
		free((char *)cellArray1[i]);
	free((char *)cellArray1); 
    
    for(i = 0; i < maxX; i++)
		free((char *)cellArray2[i]);
	free((char *)cellArray2);
}

- (void)fillRandom
{
    NSLog(@"MGOLCellProcessor fillRandom");
    int i;
    for (i = 0; i < (cellsX * cellsY / 10); i++) 
        cellsNow[random() % (cellsX+1)][random() % (cellsY+1)] = 1;
}

- (void)clearCells
{
    NSLog(@"MGOLCellProcessor clearCells");
    // Here we actually want to clear the whole array
    //    memset(cellsNow, 0, sizeof(cellsNow)); This does not work, since arrays are not contiguous
    int x;
    for (x=0; x < maxX; x++) 
        memset(cellsNow[x], 0, maxY * sizeof(char));
    population = 0;
}

- (void)processCells 
{
    int x, y, neighbors;
    
    // CellsNext will be the oldest cell array.
    // Currently the oldest one is Prev (only 2 arrays or steps)
    cellsNext = cellsPrev;
    
    population = 0;
    for (y=1; y <= cellsY; y++) 
    {
        for (x=1; x <= cellsX; x++) 
        {            
            neighbors = cellsNow[x-1][y-1] + (cellsNow[ x ][y-1]) + (cellsNow[x+1][y-1]) +
                        cellsNow[x-1][y  ] +                        (cellsNow[x+1][y  ]) +
                        cellsNow[x-1][y+1] + (cellsNow[ x ][y+1]) + (cellsNow[x+1][y+1]);
            
            cellsNext[x][y] = (cellsNow[x][y] == 0)? cellGrowsIf[neighbors] :
                                                     cellStaysAliveIf[neighbors];
            population += cellsNext[x][y];
        } 
    }
    
    // CellsNow becomes CellsPrev (previous step)
    // CellsNext becomes CellsNow (current step) so the view will draw it.
    cellsPrev = cellsNow;
    cellsNow  = cellsNext;
    
    [self replicateBorderCells];
    
    cycleCounter++;
}

- (void)replicateBorderCells
{
    int x,y;    
    // Copy boundary cells to make a donut world :)
    for (x=1; x <= cellsX; x++) {
        cellsNow[x][       0] = cellsNow[x][cellsY];
        cellsNow[x][cellsY+1] = cellsNow[x][     1];
    }
    for (y=1; y <= cellsY; y++) {
        cellsNow[       0][y] = cellsNow[cellsX][y];
        cellsNow[cellsX+1][y] = cellsNow[     1][y];
    }
    // Copy corner cells
    cellsNow[       0][       0] = cellsNow[cellsX][cellsY];
    cellsNow[cellsX+1][       0] = cellsNow[     1][cellsY];
    cellsNow[       0][cellsY+1] = cellsNow[cellsX][     1];
    cellsNow[cellsX+1][cellsY+1] = cellsNow[     1][     1];
}

- (void)flipCell:(NSPoint)cell
{
     // Add 1 for border buffer
    cellsNow[(int)cell.x+1][(int)cell.y+1] = !cellsNow[(int)cell.x+1][(int)cell.y+1];
    [self replicateBorderCells];
}

- (void)setCell:(NSPoint)cell alive:(BOOL)state
{
    cellsNow[(int)cell.x+1][(int)cell.y+1] = (state)? 1:0;  // Add 1 for border buffer
    [self replicateBorderCells];
}

- (BOOL)isCellAlive:(NSPoint)cell
{
    return cellsNow[(int)cell.x+1][(int)cell.y+1]; // Add 1 for border buffer
}

- (NSSize)worldSize
{
    return NSMakeSize(cellsX, cellsY);
}

- (void)setWorldSize:(NSSize)newSize
{
    NSLog(@"MGOLCellProcessor setWorldSize");
    cellsX = newSize.width;
    cellsY = newSize.height;
}

- (unsigned int) population
{
    return population;
}

- (unsigned int) cycleCounter
{
    return cycleCounter;
}

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
        cellStaysAlive8:(BOOL)cs8
{
    cellGrowsIf[0] = cb0;  
    cellGrowsIf[1] = cb1;  
    cellGrowsIf[2] = cb2;  
    cellGrowsIf[3] = cb3;  
    cellGrowsIf[4] = cb4;  
    cellGrowsIf[5] = cb5;  
    cellGrowsIf[6] = cb6;  
    cellGrowsIf[7] = cb7;  
    cellGrowsIf[8] = cb8;  
    cellStaysAliveIf[0] = cs0;  
    cellStaysAliveIf[1] = cs1;  
    cellStaysAliveIf[2] = cs2;  
    cellStaysAliveIf[3] = cs3;  
    cellStaysAliveIf[4] = cs4;  
    cellStaysAliveIf[5] = cs5;  
    cellStaysAliveIf[6] = cs6;  
    cellStaysAliveIf[7] = cs7;  
    cellStaysAliveIf[8] = cs8;  
}


@end
