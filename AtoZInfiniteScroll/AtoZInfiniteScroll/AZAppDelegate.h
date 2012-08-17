//
//  AZAppDelegate.h
//  AtoZInfiniteScroll
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PLWeakCompatibility/PLWeakCompatibilityStubs.h>
#import <AtoZ/AtoZ.h>
//#import "ANSegmentedControl.h"


@interface AZAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>
@property (weak) IBOutlet TransparentWindow		*barWindow;
@property (weak) IBOutlet TransparentWindow 	*controlWindow;
@property (weak) IBOutlet AtoZInfinity 			*infiniteBlocks;
@property (assign) IBOutlet NSProgressIndicator 	*spinner;
@property (assign) IBOutlet NSButton 				*orientButton;
@property (assign) IBOutlet NSSlider 				*scaleSlider;

- (void) simpleHovered:(AZInfiniteCell*)sv;
@end
//#import "AZInfiniteScrollView.h"
//#import "AZSimpleView.h"
//#import <PLWeakCompatibility/PLWeakCompatibilityStubs.h>
//#import <AtoZiTunes/AtoZiTunes.h>


//@property (strong, nonatomic) NSArray *arrayOfBlocks;

//AJSiTunesAPIDelegate>

//@property (nonatomic, retain) IBOutlet ANSegmentedControl *segment;
//@property (nonatomic, retain) IBOutlet ANSegmentedControl *segmentOrienter;
//@property (strong) 			NSString			 *visiViews;
//@property (strong) 			NSString			 *viewCount;
//@property (weak) IBOutlet AZInfiniteScrollView *azScrollV;
//@property (nonatomic, retain) AtoZiTunes *z;
//@property (nonatomic, retain) AJSiTunesAPI *anApi;
//-(IBAction)reZhuzhColors:(id)sender;
//- (void) iTunesApi:(AJSiTunesAPI *)api didCompleteWithResults:(NSArray *)results;
