//
//  AZSimpleView.h
//  AtoZ
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define StringFromBOOL(b) ((b) ? @"YES" : @"NO")

@interface NSColor (AZFunColores)
+ (NSColor*) randomColor;
@end

@interface AZSimpleView : NSView

@property (assign) 			  BOOL 		selected;
@property (nonatomic, retain) NSColor 	*backgroundColor;
@property (nonatomic, retain) NSString 	*uniqueID;
@property (nonatomic, retain) NSImage 	*image;

@end
