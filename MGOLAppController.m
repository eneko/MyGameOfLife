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
#import "MGOLGlobals.h"

@implementation MGOLAppController

- (id)init {    
    [super init];
    NSLog(@"MGOLAppController init");
    
    if (self) {
        [self registerDefaults];
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

- (void)registerDefaults
{
    NSLog(@"MGOLAppController registerDefaults");

    // Default values dictionary
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];

    // Initialize default colors
    NSColor *bgColor         = [NSColor colorWithCalibratedRed: 25.0/255.0 green: 25.0/255.0 blue: 25.0/255.0 alpha:1.0];
    NSColor *cellColor       = [NSColor colorWithCalibratedRed:204.0/255.0 green:255.0/255.0 blue:102.0/255.0 alpha:1.0];
    NSColor *cellBorderColor = [NSColor blackColor];
    NSData *bgColorAsData         = [NSKeyedArchiver archivedDataWithRootObject:bgColor];
    NSData *cellColorAsData       = [NSKeyedArchiver archivedDataWithRootObject:cellColor];
    NSData *cellBorderColorAsData = [NSKeyedArchiver archivedDataWithRootObject:cellBorderColor];
    [defaultValues setObject:bgColorAsData         forKey:MGOLBackgroundColorKey];
    [defaultValues setObject:cellColorAsData       forKey:MGOLCellColorKey];
    [defaultValues setObject:cellBorderColorAsData forKey:MGOLCellBorderColorKey];
    
    // World variables
    [defaultValues setObject:[NSNumber numberWithInt:4]    forKey:MGOLPixelsPerCellKey];
    [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:MGOLDrawCellBorderKey];
    [defaultValues setObject:[NSNumber numberWithInt:200]  forKey:MGOLWorldWidthKey];
    [defaultValues setObject:[NSNumber numberWithInt:100]  forKey:MGOLWorldHeightKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

- (void)windowDidLoad
{
    NSLog(@"MGOLAppController windowDidLoad");
}

-(void)awakeFromNib 
{
    NSLog(@"MGOLAppController awakeFromNib");
    timerFPS = [NSTimer scheduledTimerWithTimeInterval:1/10.0 // 10 times per second 
                                                target:self 
                                              selector:@selector(updateFPS:) 
                                              userInfo:nil 
                                               repeats:YES];
    // Post notification for loading defaults
    NSLog(@"MGOLAppController posting notification...");
    [[NSNotificationCenter defaultCenter] postNotificationName:MGOLLoadDefaultsNotification object:self];
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
    [lblFramesPerSecond setStringValue:[NSString stringWithFormat:@"Cycles/s: %0.0f", (1/[timer timeInterval]) ]];
    
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

- (IBAction)setCellSize:(id)sender
{
    NSLog(@"MGOLAppController setCellSize");
    
    unsigned int pixelsPerCell = [sender intValue];
    [slPixelsPerCell setIntValue:pixelsPerCell];
    [lblZoom setStringValue:[NSString stringWithFormat:@"x%d", pixelsPerCell]];
//    [myView updateCellSize:pixelsPerCell drawCellBorder:[myView drawCellBorder]];

    // Save user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:pixelsPerCell forKey:@"pixelsPerCell"];
}




@end
