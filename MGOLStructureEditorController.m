//
//  MGOLStructureEditorController.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import "MGOLStructureEditorController.h"


@implementation MGOLStructureEditorController

- (id)init
{
    NSLog(@"MGOLStructureEditorController init");
    self = [super initWithWindowNibName:@"StructureEditor"];
    return self;
}

- (void)windowDidLoad
{
    NSLog(@"MGOLStructureEditorController windowDidLoad");
}

- (IBAction)addStructure:(id)sender
{
    NSLog(@"MGOLStructureEditorController addStructure");
}

- (IBAction)removeStructure:(id)sender
{
    NSLog(@"MGOLStructureEditorController removeStructure");
}

@end
