//
//  MGOLPreferencesController.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MGOLPreferencesController : NSWindowController {
    // Settings components
    IBOutlet NSButton    *chDrawCellBorders;
    
    // World size components
    IBOutlet NSTextField *edWorldSizeX;
    IBOutlet NSTextField *edWorldSizeY;
    IBOutlet NSStepper   *stWorldSizeX;
    IBOutlet NSStepper   *stWorldSizeY;
    
    // Color components
    IBOutlet NSColorWell *coBackground;
    IBOutlet NSColorWell *coCell; 
    IBOutlet NSColorWell *coCellBorder;    

    // Cell behaviour checkboxes - Born
    IBOutlet NSButton *chCellBorn0;
    IBOutlet NSButton *chCellBorn1;
    IBOutlet NSButton *chCellBorn2;
    IBOutlet NSButton *chCellBorn3;
    IBOutlet NSButton *chCellBorn4;
    IBOutlet NSButton *chCellBorn5;
    IBOutlet NSButton *chCellBorn6;
    IBOutlet NSButton *chCellBorn7;
    IBOutlet NSButton *chCellBorn8;
    
    // Cell behaviour checkboxes - Stay Alive
    IBOutlet NSButton *chCellStayAlive0;
    IBOutlet NSButton *chCellStayAlive1;
    IBOutlet NSButton *chCellStayAlive2;
    IBOutlet NSButton *chCellStayAlive3;
    IBOutlet NSButton *chCellStayAlive4;
    IBOutlet NSButton *chCellStayAlive5;
    IBOutlet NSButton *chCellStayAlive6;
    IBOutlet NSButton *chCellStayAlive7;
    IBOutlet NSButton *chCellStayAlive8;
}

- (void)loadDefaults;

// Preference Panel 
- (IBAction)setWorldSizeX:(id)sender;
- (IBAction)setWorldSizeY:(id)sender;
- (IBAction)setDrawCellBorder:(id)sender;
- (IBAction)setBackgroundColor:(id)sender;
- (IBAction)setCellColor:(id)sender;
- (IBAction)setCellBorderColor:(id)sender;

@end
