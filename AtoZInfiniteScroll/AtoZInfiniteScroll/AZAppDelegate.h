//
//  AZAppDelegate.h
//  AtoZInfiniteScroll
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AZInfiniteScrollView.h"
//#import "AZSimpleView.h"
#import <PLWeakCompatibility/PLWeakCompatibilityStubs.h>
#import <AtoZiTunes/AtoZiTunes.h>
#import "ANSegmentedControl.h"

@interface AZAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate, AJSiTunesAPIDelegate>


@property (unsafe_unretained) IBOutlet NSProgressIndicator *pIndi;

@property (weak) IBOutlet	TransparentWindow	*winwin;
//@property (nonatomic, retain) IBOutlet ANSegmentedControl *segment;
//@property (nonatomic, retain) IBOutlet ANSegmentedControl *segmentOrienter;
@property (weak) IBOutlet TransparentWindow *controls;


//@property (strong) 			NSString			 *visiViews;
//@property (strong) 			NSString			 *viewCount;
//@property (weak) IBOutlet AZInfiniteScrollView *azScrollV;
//@property (nonatomic, retain) AtoZiTunes *z;
//@property (nonatomic, retain) AJSiTunesAPI *anApi;

//-(IBAction)reZhuzhColors:(id)sender;

//- (void) iTunesApi:(AJSiTunesAPI *)api didCompleteWithResults:(NSArray *)results;

@property (strong) IBOutlet AZInfiniteScrollView *infiniteBlocks;
@property (weak) IBOutlet NSButton *orientButton;
@property (weak) IBOutlet NSSlider *scaleSlider;
@property (strong, nonatomic) NSArray *arrayOfBlocks;


- (void) simpleHovered:(AZInfiniteCell*)sv;
@end
