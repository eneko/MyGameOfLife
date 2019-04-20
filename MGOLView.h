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
    unsigned int cellsX;
    unsigned int cellsY;    
    unsigned int pixelsPerCell;
    unsigned int cellBorder;
    unsigned int fullCellSize;
    BOOL         drawCellBorder;
    NSColor     *bgColor;
    NSColor     *cellColor;
    NSColor     *cellBorderColor;
}

- (void)loadDefaults:(NSNotification *)notification;

@end
