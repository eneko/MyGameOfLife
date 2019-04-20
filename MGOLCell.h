//
//  MGOLCell.h
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MGOLCell : NSObject {
    BOOL    isAlive;
    NSPoint position;
}

- (NSPoint)position;
- (void) setPosition:(NSPoint) newPosition;
- (BOOL)isAlive;
- (void) setState:(BOOL)newState;
- (BOOL) flip;

@end
