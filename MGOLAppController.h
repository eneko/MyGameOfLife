//
//  MGOLAppController.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 12/23/07.
//  Copyright 2007 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGOLView.h"
#import "MGOLCellProcessor.h"

@class MGOLPreferencesController;
@class MGOLStructureEditorController;

@interface MGOLAppController : NSObject {
    // Cell Processor
    IBOutlet MGOLCellProcessor *cellProcessor;

    // Process timers
    NSTimer *timerProcessor;
    NSTimer *timerFPS;
    
    // Main view
    IBOutlet MGOLView *myView;
    
    // Panels
    MGOLPreferencesController     *preferencesPanel;
    MGOLStructureEditorController *structureEditor;
    
    // Status bar items
    IBOutlet NSTextField *lblPopulation;
    IBOutlet NSTextField *lblCycles;
    IBOutlet NSTextField *lblWorldSize; 
    IBOutlet NSTextField *lblFramesPerSecond;
    IBOutlet NSProgressIndicator *progress;   
    IBOutlet NSSlider    *slPixelsPerCell;
    IBOutlet NSTextField *lblZoom;
}

// User defaults methods
- (void)registerDefaults;

// Load defaults listener
- (void)loadDefaults:(NSNotification *)notification;

- (IBAction)setCellSize:(id)sender;
- (void)updateZoomSlider:(unsigned int)pixelsPerCell;
- (void)stepAnimation:(NSTimer *)timer;

// Toolbar buttons
- (IBAction)start:(id)sender;
- (IBAction)step:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)fillRandom:(id)sender;
- (IBAction)clearCells:(id)sender;
- (IBAction)showPreferences:(id)sender;
- (IBAction)showStructureEditor:(id)sender;

@end
