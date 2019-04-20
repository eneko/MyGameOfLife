//
//  MGOLView.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 12/23/07.
//  Copyright 2007 Eneko Alonso. All rights reserved.
//

#import "MGOLView.h"
#import <math.h>

@implementation MGOLView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    NSLog(@"MGOLView initWithFrame");

    if (self) {  
        bgColor         = [[NSColor colorWithCalibratedRed: 25.0/255.0 green: 25.0/255.0 blue: 25.0/255.0 alpha:1.0] retain];
        cellColor       = [[NSColor colorWithCalibratedRed:204.0/255.0 green:255.0/255.0 blue:102.0/255.0 alpha:1.0] retain];
        cellBorderColor = [[NSColor blackColor] retain];
    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"MGOLView dealloc");
    [bgColor         release];
    [cellColor       release];
    [cellBorderColor release];
    [super dealloc];
}

- (BOOL)isFlipped             { return YES; }
- (BOOL)isOpaque              { return YES; }
- (BOOL)acceptsFirstResponder { return YES; }

- (unsigned int)frameCounter
{
    return frames;
}

- (void)resetFrameCounter
{
    frames = 0;
}

- (void)drawRect:(NSRect)rect
{
//    NSLog(@"MGOLView drawRect");

    
    
    // Initialize variables
    int x = 0;
    int y = 0;

    // Fill Background
    [bgColor set];
    NSRectFill([self bounds]);
    
    // Get world size
    int cellsX = [cellProcessor worldSize].width;
    int cellsY = [cellProcessor worldSize].height;    
    
    // Draw cell border lines
    if (drawCellBorder) 
    {
        NSRect borderRect;
        [cellBorderColor set];
        
        // Draw vertical lines
        while (x < cellsX) 
        {
            borderRect = NSMakeRect(x*fullCellSize, 0, fullCellSize+1, cellsY*fullCellSize + 1);    
            NSFrameRect(borderRect);    
            x += 2;
        }
        
        // Draw horizontal lines
        while (y < cellsY) 
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

    // Make sure cell processor is assigned
    if (cellProcessor) 
    {
        [cellColor set];
        for (y = 0; y < cellsY; y++) 
        {
            for (x = 0; x < cellsX; x++) 
            {
                if ([cellProcessor isCellAlive:NSMakePoint(x+1, y+1)])
                {
                    NSRectFill(NSMakeRect((x * fullCellSize) + cellBorder, 
                                          (y * fullCellSize) + cellBorder, 
                                          pixelsPerCell, 
                                          pixelsPerCell));
                }
            }
        } 
    }   
    frames++;  
}

- (void)updateCellSize:(unsigned int)newPixelsPerCell
        drawCellBorder:(BOOL)newDrawCellBorder
{
    NSLog(@"MGOLView updateCellSize");

    // Save new size properties
    pixelsPerCell  = newPixelsPerCell;
    drawCellBorder = newDrawCellBorder;
    cellBorder     = (int)drawCellBorder;
    fullCellSize   = pixelsPerCell + cellBorder;
    if (fullCellSize <= 0) return;

    // Resize the view to fit cellsX and cellsY
    [self setFrameSize:NSMakeSize([cellProcessor worldSize].width  * fullCellSize + 1, 
                                  [cellProcessor worldSize].height * fullCellSize + 1)];
    [self setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)theEvent 
{
    NSLog(@"MGOLView mouseDown");
    
    // determine if I handle theEvent
    // if not...
    //[super mouseDown:theEvent];

    NSPoint eventLocation = [theEvent locationInWindow];
    NSPoint center = [self convertPoint:eventLocation fromView:nil];
    int x = ((center.x-2) / fullCellSize) + 1;
    int y = ((center.y-2) / fullCellSize) + 1;
    
    [cellProcessor flipCell:NSMakePoint(x, y)];
    [self setNeedsDisplay:YES];
}


@end
