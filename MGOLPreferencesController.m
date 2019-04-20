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

    // Cell behavior
    [chCellBorn0 setState:[defaults boolForKey:@"MGOLCellBorn0"]];    
    [chCellBorn1 setState:[defaults boolForKey:@"MGOLCellBorn1"]];    
    [chCellBorn2 setState:[defaults boolForKey:@"MGOLCellBorn2"]];    
    [chCellBorn3 setState:[defaults boolForKey:@"MGOLCellBorn3"]];    
    [chCellBorn4 setState:[defaults boolForKey:@"MGOLCellBorn4"]];    
    [chCellBorn5 setState:[defaults boolForKey:@"MGOLCellBorn5"]];    
    [chCellBorn6 setState:[defaults boolForKey:@"MGOLCellBorn6"]];    
    [chCellBorn7 setState:[defaults boolForKey:@"MGOLCellBorn7"]];    
    [chCellBorn8 setState:[defaults boolForKey:@"MGOLCellBorn8"]];    
    [chCellStayAlive0 setState:[defaults boolForKey:@"MGOLCellStayAlive0"]];    
    [chCellStayAlive1 setState:[defaults boolForKey:@"MGOLCellStayAlive1"]];    
    [chCellStayAlive2 setState:[defaults boolForKey:@"MGOLCellStayAlive2"]];    
    [chCellStayAlive3 setState:[defaults boolForKey:@"MGOLCellStayAlive3"]];    
    [chCellStayAlive4 setState:[defaults boolForKey:@"MGOLCellStayAlive4"]];    
    [chCellStayAlive5 setState:[defaults boolForKey:@"MGOLCellStayAlive5"]];    
    [chCellStayAlive6 setState:[defaults boolForKey:@"MGOLCellStayAlive6"]];    
    [chCellStayAlive7 setState:[defaults boolForKey:@"MGOLCellStayAlive7"]];    
    [chCellStayAlive8 setState:[defaults boolForKey:@"MGOLCellStayAlive8"]];    
    
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

- (IBAction)setCellBehavior:(id)sender
{
    NSLog(@"MGOLPreferencesController setCellBehavior");
    // Save preferences
    [[NSUserDefaults standardUserDefaults] setBool:[chCellBorn0 state] forKey:@"MGOLCellBorn0"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellBorn1 state] forKey:@"MGOLCellBorn1"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellBorn2 state] forKey:@"MGOLCellBorn2"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellBorn3 state] forKey:@"MGOLCellBorn3"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellBorn4 state] forKey:@"MGOLCellBorn4"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellBorn5 state] forKey:@"MGOLCellBorn5"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellBorn6 state] forKey:@"MGOLCellBorn6"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellBorn7 state] forKey:@"MGOLCellBorn7"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellBorn8 state] forKey:@"MGOLCellBorn8"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellStayAlive0 state] forKey:@"MGOLCellStayAlive0"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellStayAlive1 state] forKey:@"MGOLCellStayAlive1"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellStayAlive2 state] forKey:@"MGOLCellStayAlive2"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellStayAlive3 state] forKey:@"MGOLCellStayAlive3"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellStayAlive4 state] forKey:@"MGOLCellStayAlive4"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellStayAlive5 state] forKey:@"MGOLCellStayAlive5"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellStayAlive6 state] forKey:@"MGOLCellStayAlive6"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellStayAlive7 state] forKey:@"MGOLCellStayAlive7"];
    [[NSUserDefaults standardUserDefaults] setBool:[chCellStayAlive8 state] forKey:@"MGOLCellStayAlive8"];
    // Post notification for loading defaults
    [[NSNotificationCenter defaultCenter] postNotificationName:MGOLLoadDefaultsNotification object:self];    
}

@end
