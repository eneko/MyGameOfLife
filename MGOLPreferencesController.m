//
//  MGOLPreferencesController.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import "MGOLPreferencesController.h"
#import "MGOLGlobals.h"

@implementation MGOLPreferencesController

- (id)init
{
    NSLog(@"MGOLPreferencesController init");
    self = [super initWithWindowNibName:@"Preferences"];
    return self;
}

- (void)windowDidLoad
{
    NSLog(@"MGOLPreferencesController windowDidLoad");
}

- (IBAction)setCellSize:(id)sender
{
    NSLog(@"MGOLPreferencesController setCellSize");

    [edPixelsPerCell takeIntValueFrom:sender];
    [stPixelsPerCell setIntValue:[edPixelsPerCell intValue]];
    [slPixelsPerCell setIntValue:[edPixelsPerCell intValue]];
    
//    [self updateSize:nil];
}

- (IBAction)setWorldSizeX:(id)sender
{
    NSLog(@"MGOLPreferencesController setWorldSizeX");
    
    int newWidth = abs(MIN([sender intValue], maxX-2));
    [edWorldSizeX setIntValue:newWidth];    
    [stWorldSizeX setIntValue:newWidth];

//    [self updateSize:nil];
}

- (IBAction)setWorldSizeY:(id)sender
{
    NSLog(@"MGOLPreferencesController setworldSizeY");
    
    int newHeight = abs(MIN([sender intValue], maxY-2));
    [edWorldSizeY setIntValue:newHeight];    
    [stWorldSizeY setIntValue:newHeight];

//    [self updateSize:nil];
}



@end
