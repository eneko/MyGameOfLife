//
//  MGOLView.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 12/23/07.
//  Copyright 2007 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGOLCellProcessor.h"

@interface MGOLView : NSView 
{
    // Cell Processor
    IBOutlet MGOLCellProcessor *cellProcessor;
    
    // View properties
    unsigned int pixelsPerCell;
    unsigned int cellBorder;
    unsigned int fullCellSize;
    BOOL         drawCellBorder;
    NSColor     *bgColor;
    NSColor     *cellColor;
    NSColor     *cellBorderColor;

    unsigned int frames;
}

- (void)resetFrameCounter;
- (unsigned int)frameCounter;

- (void)updateCellSize:(unsigned int)newPixelsPerCell
        drawCellBorder:(BOOL)newDrawCellBorder;

@end
