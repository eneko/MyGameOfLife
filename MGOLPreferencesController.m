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
    [self loadDefaults];
}

- (void)loadDefaults
{
    NSLog(@"MGOLPreferencesController loadDefaults");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Cell colors
    NSData *bgColorAsData         = [defaults objectForKey:MGOLBackgroundColorKey];
    NSData *cellColorAsData       = [defaults objectForKey:MGOLCellColorKey];
    NSData *cellBorderColorAsData = [defaults objectForKey:MGOLCellBorderColorKey];
    [coBackground setColor:[NSKeyedUnarchiver unarchiveObjectWithData:bgColorAsData]];
    [coCell       setColor:[NSKeyedUnarchiver unarchiveObjectWithData:cellColorAsData]];
    [coCellBorder setColor:[NSKeyedUnarchiver unarchiveObjectWithData:cellBorderColorAsData]];
    
    // Cell variables
    [chDrawCellBorders setState:[defaults boolForKey:MGOLDrawCellBorderKey]];
    
    // Get world size
    [edWorldSizeX setIntValue:[defaults integerForKey:MGOLWorldWidthKey]];
    [stWorldSizeX setIntValue:[edWorldSizeX intValue]];
    [edWorldSizeY setIntValue:[defaults integerForKey:MGOLWorldHeightKey]];
    [stWorldSizeY setIntValue:[edWorldSizeY intValue]];
}

- (IBAction)setWorldSizeX:(id)sender
{
    NSLog(@"MGOLPreferencesController setWorldSizeX");
    int newWidth = abs(MIN([sender intValue], maxX-2));
    [edWorldSizeX setIntValue:newWidth];    
    [stWorldSizeX setIntValue:newWidth];
    // Save preferences
    [[NSUserDefaults standardUserDefaults] setInteger:newWidth forKey:MGOLWorldWidthKey];
    // Post notification for loading defaults
    [[NSNotificationCenter defaultCenter] postNotificationName:MGOLLoadDefaultsNotification object:self];
}

- (IBAction)setWorldSizeY:(id)sender
{
    NSLog(@"MGOLPreferencesController setWorldSizeY");
    int newHeight = abs(MIN([sender intValue], maxY-2));
    [edWorldSizeY setIntValue:newHeight];    
    [stWorldSizeY setIntValue:newHeight];
    // Save preferences
    [[NSUserDefaults standardUserDefaults] setInteger:newHeight forKey:MGOLWorldHeightKey];
    // Post notification for loading defaults
    [[NSNotificationCenter defaultCenter] postNotificationName:MGOLLoadDefaultsNotification object:self];
}

- (IBAction)setDrawCellBorder:(id)sender
{
    NSLog(@"MGOLPreferencesController setCellBorder");        
    // Save preferences
    [[NSUserDefaults standardUserDefaults] setBool:[sender state] forKey:MGOLDrawCellBorderKey];
    // Post notification for loading defaults
    [[NSNotificationCenter defaultCenter] postNotificationName:MGOLLoadDefaultsNotification object:self];
}

- (IBAction)setBackgroundColor:(id)sender
{
    NSLog(@"MGOLPreferencesController setBackgroundColor");        
    // Save preferences
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[sender color]];
    [[NSUserDefaults standardUserDefaults] setObject:colorAsData forKey:MGOLBackgroundColorKey];
    // Post notification for loading defaults
    [[NSNotificationCenter defaultCenter] postNotificationName:MGOLLoadDefaultsNotification object:self];
}

- (IBAction)setCellColor:(id)sender
{
    NSLog(@"MGOLPreferencesController setBackgroundColor");        
    // Save preferences
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[sender color]];
    [[NSUserDefaults standardUserDefaults] setObject:colorAsData forKey:MGOLCellColorKey];
    // Post notification for loading defaults
    [[NSNotificationCenter defaultCenter] postNotificationName:MGOLLoadDefaultsNotification object:self];
}

- (IBAction)setCellBorderColor:(id)sender
{
    NSLog(@"MGOLPreferencesController setBackgroundColor");        
    // Save preferences
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[sender color]];
    [[NSUserDefaults standardUserDefaults] setObject:colorAsData forKey:MGOLCellBorderColorKey];
    // Post notification for loading defaults
    [[NSNotificationCenter defaultCenter] postNotificationName:MGOLLoadDefaultsNotification object:self];
}

@end
