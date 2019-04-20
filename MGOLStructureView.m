//
//  MGOLStructureView.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import "MGOLStructureView.h"


@implementation MGOLStructureView

- (id)initWithFrame:(NSRect)frame {
    NSLog(@"MGOLStructureView initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (BOOL)isFlipped             { return YES; }
- (BOOL)isOpaque              { return YES; }
- (BOOL)acceptsFirstResponder { return YES; }

- (void)drawRect:(NSRect)rect {
    // Draw background
    [[coBackground color] set];
    NSRectFill([self bounds]);
/*    
    // Draw cell border lines
    if ([chDrawCellBorders state]) 
    {
        NSRect borderRect;
        [[coCellBorder color] set];
        
        // Draw vertical lines
        while (x < worldSize.width) 
        {
            borderRect = NSMakeRect(x*fullCellSize, 0, fullCellSize+1, cellsY*fullCellSize + 1);    
            NSFrameRect(borderRect);    
            x += 2;
        }
        
        // Draw horizontal lines
        while (y < worldSize.height) 
        {
            borderRect = NSMakeRect(0, y*fullCellSize, cellsX*fullCellSize + 1, fullCellSize+1);    
            NSFrameRect(borderRect);    
            y += 2;
        }
        
        // Draw a border arround all cells
        //[[NSColor redColor] set];
        borderRect = NSMakeRect(0, 0, cellsX*fullCellSize + 1, cellsY*fullCellSize + 1);    
        NSFrameRect(borderRect);    
    }
  */  
}

@end
