//
//  MGOLView.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 12/23/07.
//  Copyright 2007 Eneko Alonso. All rights reserved.
//

#import "MGOLView.h"
#import "MGOLGlobals.h"


@implementation MGOLView

- (id)initWithFrame:(NSRect)frame 
{
    NSLog(@"MGOLView initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {  
        // Register as an observer for LoadDefaults messages
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(loadDefaults:) name:MGOLLoadDefaultsNotification object:nil];
        NSLog(@"MGOLView registered for notifications");        
    }
    selection = NSMakeRect(0,0,0,0);
    
    return self;
}

- (void)dealloc
{
    NSLog(@"MGOLView dealloc");
    [bgColor         release];
    [cellColor       release];
    [cellBorderColor release];
    
    // Unregister from notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"MGOLView removed from notifications");        
    
    [super dealloc];
}

- (void)loadDefaults:(NSNotification *)notification
{
    NSLog(@"MGOLView loadDefaults");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Cell colors
    NSData *bgColorAsData         = [defaults objectForKey:MGOLBackgroundColorKey];
    NSData *cellColorAsData       = [defaults objectForKey:MGOLCellColorKey];
    NSData *cellBorderColorAsData = [defaults objectForKey:MGOLCellBorderColorKey];
    bgColor         = [[NSKeyedUnarchiver unarchiveObjectWithData:bgColorAsData] retain];
    cellColor       = [[NSKeyedUnarchiver unarchiveObjectWithData:cellColorAsData] retain];
    cellBorderColor = [[NSKeyedUnarchiver unarchiveObjectWithData:cellBorderColorAsData] retain];
    
    // Cell variables
    pixelsPerCell  = [defaults integerForKey:MGOLPixelsPerCellKey];
    drawCellBorder = [defaults boolForKey:MGOLDrawCellBorderKey];
    cellBorder     = (int)drawCellBorder;
    fullCellSize   = pixelsPerCell + cellBorder;

    // Get world size
    cellsX = [defaults integerForKey:MGOLWorldWidthKey];
    cellsY = [defaults integerForKey:MGOLWorldHeightKey];

    // Resize the view to fit cellsX and cellsY
    [self setFrameSize:NSMakeSize(cellsX*fullCellSize + 1, cellsY*fullCellSize + 1)];
    [self setNeedsDisplay:YES];
}

- (BOOL)isFlipped             { return YES; }
- (BOOL)isOpaque              { return YES; }
- (BOOL)acceptsFirstResponder { return YES; }

- (void)drawRect:(NSRect)rect
{
    // Initialize variables
    int x = 0;
    int y = 0;

    // Fill Background
    [bgColor set];
    NSRectFill([self bounds]);
    
    // Draw cell border lines
    if (drawCellBorder) 
    {
        NSRect borderRect;
        [cellBorderColor set];
        
        // Draw vertical lines
        while (x < cellsX) 
        {
            borderRect = NSMakeRect(x*fullCellSize, 0, fullCellSize+1, cellsY*fullCellSize + 1);    
            NSFrameRect(borderRect);    
            x += 2;
        }
        
        // Draw horizontal lines
        while (y < cellsY) 
        {
            borderRect = NSMakeRect(0, y*fullCellSize, cellsX*fullCellSize + 1, fullCellSize+1);    
            NSFrameRect(borderRect);    
            y += 2;
        }

        // Draw a border arround all cells
        //[[NSColor redColor] set];
        borderRect = NSMakeRect(0, 0, cellsX*fullCellSize + 1, cellsY*fullCellSize + 1);    
        NSFrameRect(borderRect);    
    }

    // Draw cells
    [cellColor set];
    for (y = 0; y < cellsY; y++) 
    {
        for (x = 0; x < cellsX; x++) 
        {
            if ([cellProcessor isCellAlive:NSMakePoint(x, y)])
            {
                NSRectFill([self cellRect:NSMakePoint(x, y)]);
            }
        }
    } 

    // Draw selection marker
    if ((selection.size.width > 0) && (selection.size.height > 0))
    {
        [[NSColor redColor] set];
        NSFrameRect([self cellsRect:selection]);    
    }

}

- (void)mouseDown:(NSEvent *)theEvent 
{
    //NSLog(@"MGOLView mouseDown");
    
    // determine if I handle theEvent
    // if not...
    //[super mouseDown:theEvent];
    
    NSPoint eventLocation = [theEvent locationInWindow];
    NSPoint center = [self convertPoint:eventLocation fromView:nil];
    NSPoint cell = [self convertFromViewToCell:center];
    NSLog(@"MGOLView mouseDown %f,%f", cell.x, cell.y);    

    /* This code works for flipping cells when mouse clicks
    [cellProcessor flipCell:[self convertFromViewToCell:center]]; */

    /* This code works for cell selection */
    selection.origin = cell;
    selection.size   = NSMakeSize(1,1);

    [self setNeedsDisplay:YES]; 
}

- (void)mouseDragged:(NSEvent *)theEvent 
{
    //NSLog(@"MGOLView mouseDragged");
    NSPoint eventLocation = [theEvent locationInWindow];
    NSPoint center = [self convertPoint:eventLocation fromView:nil];
    NSPoint cell = [self convertFromViewToCell:center];

    NSLog(@"MGOLView mouseDragged %f,%f", cell.x, cell.y);    
    selection.size.width  = 1 + cell.x - selection.origin.x;
    selection.size.height = 1 + cell.y - selection.origin.y;
    
    [self setNeedsDisplay:YES]; 
}

- (NSPoint)convertFromCellToView:(NSPoint)cell;
{
    return NSMakePoint(cell.x * fullCellSize, cell.y * fullCellSize);
}

- (NSPoint)convertFromViewToCell:(NSPoint)pixel
{
    int x = (pixel.x / fullCellSize);
    int y = (pixel.y / fullCellSize);
    return NSMakePoint(x, y);
}

- (NSRect)cellRect:(NSPoint)cell
{
    NSPoint origin = [self convertFromCellToView:cell];
    return NSMakeRect(origin.x + cellBorder, origin.y + cellBorder, pixelsPerCell, pixelsPerCell);
}

- (NSRect)cellsRect:(NSRect)cells
{
    NSPoint origin = [self convertFromCellToView:cells.origin];
    int width      = cells.size.width * fullCellSize  + cellBorder;
    int height     = cells.size.height * fullCellSize + cellBorder;
    return NSMakeRect(origin.x, origin.y, width, height);
}

- (NSRect)cellRectWithBorder:(NSPoint)cell
{
    NSRect cellRect = [self cellRect:cell];
    cellRect.size.width  += cellBorder;
    cellRect.size.height += cellBorder;
    return cellRect;
}


@end
