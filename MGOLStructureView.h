//
//  MGOLStructureView.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MGOLStructureView : NSView {
    
    // Settings components
    IBOutlet NSButton    *chDrawCellBorders;

    // Color components
    IBOutlet NSColorWell *coBackground;
    IBOutlet NSColorWell *coCell; 
    IBOutlet NSColorWell *coCellBorder;
    
}

@end
