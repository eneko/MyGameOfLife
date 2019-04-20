//
//  MGOLStructure.m
//  MyGameOfLife
//
//  Created by Eneko Alonso on 1/6/08.
//  Copyright 2008 Eneko Alonso. All rights reserved.
//

#import "MGOLStructure.h"


@implementation MGOLStructure

- (id) init
{
    NSLog(@"MGOLStructure init");
    [super init];
    [self setStructureName:@"New structure"];
    return self;
}

- (void)dealloc
{
    NSLog(@"MGOLStructure dealloc");
    [structureName release];
    [super dealloc];
}

- (NSString *)structureName
{
    return structureName;
}

- (void)setStructureName:(NSString *)newName
{
    NSLog(@"MGOLStructure setStructureName");
    newName = [newName copy];
    [structureName release];
    structureName = newName;
}

- (NSSize)structureSize
{
    return structureSize;
}

- (NSString *)structureSizeAsString
{
    return [NSString stringWithFormat:@"%0.0fx%0.0f", structureSize.width, structureSize.height];
}

- (void)setStructureSize:(NSSize)newSize
{
    NSLog(@"MGOLStructure setStructureSize");
    structureSize = newSize;
}

- (unsigned int)structureWidth
{
    return structureSize.width;
}

- (void)setStructureWidth:(unsigned int)newWidth
{
    NSLog(@"MGOLStructure setStructureWidth");
    structureSize.width = newWidth;
}

- (unsigned int)structureHeight
{
    return structureSize.height;
}

- (void)setStructureHeight:(unsigned int)newHeight
{
    NSLog(@"MGOLStructure setStructureHeight");
    structureSize.height = newHeight;
}

@end
