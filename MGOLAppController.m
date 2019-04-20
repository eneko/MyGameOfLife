//
//  MGOLAppController.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 12/23/07.
//  Copyright 2007 Eneko Alonso. All rights reserved.
//

#import "MGOLAppController.h"
#import "MGOLPreferencesController.h"
#import "MGOLStructureEditorController.h"

@implementation MGOLAppController

- (id)init {    
    [super init];
    NSLog(@"MGOLAppController init");
    
    if (self) {
        timerFPS = [NSTimer scheduledTimerWithTimeInterval:1/10.0 // 10 times per second 
                                                    target:self 
                                                  selector:@selector(updateFPS:) 
                                                  userInfo:nil 
                                                   repeats:YES];
    }
    
    preferencesPanel = nil;
    structureEditor  = nil;
    
    return self;
}

-(void) dealloc
{
    NSLog(@"MGOLAppController dealloc");
    [preferencesPanel release];
    [structureEditor  release];
    [super dealloc];
}

- (void)windowDidLoad
{
    NSLog(@"MGOLAppController windowDidLoad");
}

-(void)awakeFromNib {
    NSLog(@"MGOLAppController awakeFromNib");
    [myView updateCellSize:4 drawCellBorder:YES];
}


- (IBAction)start:(id)sender {
    NSLog(@"MGOLAppController start");
    if (timerProcessor == nil) 
    {
        timerProcessor = [NSTimer scheduledTimerWithTimeInterval:0.001//1.0/25.0 // 25 times per second 
                                                          target:self 
                                                        selector:@selector(stepAnimation:) 
                                                        userInfo:nil 
                                                         repeats:YES];
        [progress startAnimation:self];
    }
}

- (IBAction)step:(id)sender {
    NSLog(@"MGOLAppController step");
    [self stepAnimation:nil];
}

- (IBAction)stop:(id)sender {
    NSLog(@"MGOLAppController pause");
    if (timerProcessor != nil) {
        [timerProcessor invalidate];
        //[timer release]; This blows up if called multiple times!
        timerProcessor = nil;
        [progress stopAnimation:self];
    }
}

- (void)stepAnimation:(NSTimer *)timer 
{
    [cellProcessor processCells];
    [myView setNeedsDisplay:YES];
}

- (IBAction)clearCells:(id)sender {
    NSLog(@"MGOLAppController stop/clear");
    [self stop:nil]; // Stop timer
    [cellProcessor clearCells];
    [myView setNeedsDisplay:YES];
}

- (IBAction)fillRandom:(id)sender {
    NSLog(@"MGOLAppController Fill Random");
    [cellProcessor fillRandom];
    [myView setNeedsDisplay:YES];
}

- (void)windowDidResize:(NSNotification *)notification
{
    NSLog(@"MGOLAppController Window did resize");
}

- (void)updateFPS:(NSTimer *)timer 
{
//    NSLog(@"MGOLAppController updateFPS");
    [lblFramesPerSecond setStringValue:[NSString stringWithFormat:@"Cycles/s: %0.0f", [myView frameCounter] * (1/[timer timeInterval]) ]];
    [myView resetFrameCounter];
    
    [lblPopulation setStringValue:[NSString stringWithFormat:@"Population: %d", [cellProcessor population]]];
    [lblCycles     setStringValue:[NSString stringWithFormat:@"Cycles: %d",     [cellProcessor cycleCounter]]];
    NSSize worldSize = [cellProcessor worldSize];
    [lblWorldSize setStringValue:[NSString stringWithFormat:@"World: %0.0fx%0.0f", worldSize.width, worldSize.height]];
    //    [lblPopulation setIntValue:cellCounter];
    //    [lblCycles     setIntValue:cycleCounter];
}

- (IBAction)showPreferences:(id)sender
{
    NSLog(@"MGOLAppController showPreferences");
    // Is already created?
    if (!preferencesPanel) {
        preferencesPanel = [MGOLPreferencesController new];
    }
    [preferencesPanel showWindow:self];
}

- (IBAction)showStructureEditor:(id)sender
{
    NSLog(@"MGOLAppController showStructureEditor");
    // Is already created?
    if (!structureEditor) {
        structureEditor = [MGOLStructureEditorController new];
    }
    [structureEditor showWindow:self];
}




@end
