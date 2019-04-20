//
//  MGOLStructureView.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGOLStructure.h"

@interface MGOLStructureView : NSView 
{
    // Cell Structure
    IBOutlet MGOLStructure *cellStructure;
    
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

// Load defaults listener
- (void)loadDefaults:(NSNotification *)notification;

- (void)setStructure:(MGOLStructure *)structure;

@end
