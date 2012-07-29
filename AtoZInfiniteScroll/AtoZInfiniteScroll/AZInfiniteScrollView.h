//
//  AZInfiniteScrollView.h
//  AtoZInfiniteScroll
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AtoZ/AtoZ.h>


typedef enum {
	AZOrientHorizontal,
	AZOrientVertical
}	AZOrient;

typedef enum {
	AZInfiteScale0X  = 0,
	AZInfiteScale1X  = 1,
	AZInfiteScale2X  = 2,
	AZInfiteScale3X  = 3,
	AZInfiteScale10X = 10
} 	AZInfiteScale;

@interface AZInfiniteScrollView : NSScrollView // <NSWindowDelegate, AJSiTunesAPIDelegate>

@property (readonly) NSRect unit;
@property (assign, nonatomic) AZInfiteScale scale;
@property (assign, nonatomic) AZOrient orientation;
@property (nonatomic, strong) NSMutableArray *infiniteViews;
//- (void) stack;
//- (void) popItForView:(AZSimpleView*)vv;
//- (void) simulateScrollWithOffset:(float)f orEvent:(NSEvent*)event;
@end
