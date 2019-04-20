//
//  MGOLStructureEditorController.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGOLStructure.h"
#import "MGOLStructureView.h"

@interface MGOLStructureEditorController : NSWindowController {
    IBOutlet NSTextField       *edStructureName;
    IBOutlet NSTextField       *edStructureWidth;
    IBOutlet NSTextField       *edStructureHeight;
    IBOutlet MGOLStructureView *myView;
    IBOutlet NSArrayController *structureArray;
}

- (IBAction)addStructure:(id)sender;
- (IBAction)removeStructure:(id)sender;

@end
