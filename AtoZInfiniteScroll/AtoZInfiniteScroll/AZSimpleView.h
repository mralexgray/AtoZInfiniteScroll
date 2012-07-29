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
#import <AtoZ/AtoZ.h>
#import <AtoZiTunes/AtoZiTunes.h>

@interface AZSimpleView : NSView //<NSWindowDelegate, AJSiTunesAPIDelegate>

@property (assign) 			  BOOL 		selected;
@property (assign) 			  BOOL 		hovered;
@property (assign) 			  BOOL 		hasText;
@property (nonatomic, strong) NSColor 	*backgroundColor;
@property (nonatomic, strong) NSString 	*uniqueID;
@property (nonatomic, strong) NSImage 	*image;
@property (nonatomic, strong) AZFile	*file;

@property (nonatomic, strong) AJSiTunesAPI *itunesApi;
@property (nonatomic, strong) NSArray *itunesResults;

@end
