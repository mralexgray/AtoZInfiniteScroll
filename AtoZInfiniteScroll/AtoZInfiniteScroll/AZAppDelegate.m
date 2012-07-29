//
//  AZAppDelegate.m
//  AtoZInfiniteScroll
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import "AZAppDelegate.h"
//s#import "AZInfiniteCell.h"
#import <AtoZ/AtoZ.h>

@implementation AZAppDelegate  			{ NSMutableArray *arrayOfViews;
										  TransparentWindow *cs;	}

//@synthesize 	azScrollV;
//@synthesize 	viewCount;
//@synthesize  	visiViews;
@synthesize  	winwin;
@synthesize infiniteBlocks;//, z, anApi;segment, segmentOrienter,
@synthesize controls;
@synthesize scaleSlider, orientButton, pIndi, arrayOfBlocks;

- (IBAction)switchViewScale:(id)sender {

//    static int  selectedSegment = -1;
 	switch  ([sender intValue])		{
				case 1: // Left
				[infiniteBlocks setScale : AZInfiteScale1X];
				break;
				case 2: // Day
				[infiniteBlocks setScale : AZInfiteScale2X];
				break;
				case 3:	[infiniteBlocks setScale : AZInfiteScale3X ]; break;
				case 4:	[infiniteBlocks setScale : AZInfiteScale10X ]; break;
			}
//		[viewControl setSelected:NO forSegment:0];
//		[viewControl setSelected:NO forSegment:4];
//		if(selectedSegment >= 0)
//			[viewControl setSelected:(1 == selectedSegment) ? YES : NO forSegment:1];
//			[viewControl setSelected:(2 == selectedSegment) ? YES : NO forSegment:2];
//			[viewControl setSelected:(3 == selectedSegment) ? YES : NO forSegment:3];
//		}
}
- (IBAction)swapOrient:(id)sender {

//	if ([sender isEqualTo:segmentOrienter])		{
//		switch ([segmentOrienter selectedSegment])// [segmentOrienter selectedSegment])
//		{
//			case 0: { // Left
//			NSLog(@"resettubg oriuentr");
//			[winwin performSelectorOnMainThread:@selector(slideUp) withObject:nil waitUntilDone:YES];
//			[winwin slideUp];
//			[winwin setAlphaValue:0];
//			NSRect win = AZMakeRectMaxXUnderMenuBarY(200);
			// ([[NSScreen mainScreen]frame].size.width, 200);
	if (infiniteBlocks.orientation == AZOrientVertical ) {
			[winwin setFrame:AZMakeRectMaxXUnderMenuBarY(100) display:YES animate:YES];//  display:NO];// animate:YES];
//			[winwin slideDown];
			[infiniteBlocks setOrientation: AZOrientHorizontal];

			} else {
			[winwin setFrame:NSMakeRect(0,0, 100, [[NSScreen mainScreen]frame].size.height-22)  display:YES animate:YES];

//			[controls rotateByAngle:-90];
//			[[winwin contentView]  setNeedsDisplay:YES];
//			NSRect x = AZRightEdge([winwin frame], [controls frame].size.width);
//			[controls setFrame:x];
			[infiniteBlocks setOrientation : AZOrientVertical];

			}
//		}
//	}
//	[infiniteBlocks stack];
	//simulateScrollWithOffset:0 orEvent:nil];
}

- (IBAction) peruseApps:(id)sender {

	self.arrayOfBlocks = [[AtoZ appFolderSorted] arrayUsingIndexedBlock:^id(id obj, NSUInteger idx) {
		AZFile *block = obj;
		AZInfiniteCell *e = [AZInfiniteCell new];
		e.file = block;
		e.backgroundColor = block.color;
		return e;
	}];
	infiniteBlocks.infiniteViews  = arrayOfBlocks;

}

- (void) simpleHovered:(AZInfiniteCell*)sv {
	NSLog(@"jovered: %@", sv.file.name);
}


//+ (void)initialize {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    // initialize the dictionary with default values
//    [defaults setValue:@"horizontal" forKey:@"orientation"];
//	[defaults setBool:YES forKey:@"extendedInfo"];
//
//    // and set them appropriately
////    [defaults registerDefaults:appDefaults];
//}

- (void) awakeFromNib	{

	controls.level = NSScreenSaverWindowLevel;
	[controls setFrame:
		AZMakeRect( NSMakePoint([[NSScreen mainScreen]frame].size.width - [controls frame].size.width,
		[[NSScreen mainScreen]frame].size.height -22 - [controls frame].size.height),[controls frame].size) display:YES];
	[pIndi setUsesThreadedAnimation:YES];
	[pIndi startAnimation:pIndi];
	[scaleSlider setAction:@selector(switchViewScale:)];
	[orientButton setAction:@selector(swapOrient:)];
//	[winwin setDelegate:self];
//	[winwin setDefaultFirstResponder];
	[NSApp setDelegate:self];
	[NSApp activateIgnoringOtherApps:YES];
	//	[winwin setMaxSize:NSMakeSize(NSIntegerMax, 150)];
	//	[winwin setFrame:AZUpperEdge([[NSScreen mainScreen]frame], 200) display:NO animate:NO];
	//	[winwin orderFront:self];
	//	[winwin fadeIn];

	//	self.anApi = [[AJSiTunesAPI alloc] init];
	//	self.anApi.delegate = self;
	//	NSRect leftover = AZLeftEdge([[winwin contentView]frame], [[winwin contentView]frame].size.width-10);
	//	infiniteBlocks.frame = leftover;

/*	[winwin setOpaque:NO];
	[winwin setStyleMask:NSBorderlessWindowMask ]; */
//	[winwin setStyleMask:NSResizableWindowMask];
//	[winwin setMovableByWindowBackground:YES];
//	[winwin setShowsResizeIndicator:YES];
//	[winwin setBackgroundColor:CLEAR];
	//	__block __typeof(self) blockSelf = self;
/*	[[winwin contentView] addSubview:
	 [AZBlockView viewWithFrame:[[winwin contentView]frame]  opaque:NO drawnUsingBlock:
	  ^(AZBlockView *view, NSRect dirtyRect) {
		  //[[blockSelf roundedRectFillColor] set]; [[NSBezierPath bezierPathWithRoundedRect:[view bounds] xRadius:5 yRadius:5] fill]; }]]; }
		  view.autoresizingMask = NSViewHeightSizable| NSViewWidthSizable;

		  [[BLACK colorWithAlphaComponent:.97] set];
		  [[NSBezierPath bezierPathWithRoundedRect:[view bounds] xRadius:20 yRadius:20] fill];
	  }] positioned:NSWindowBelow relativeTo:infiniteBlocks];
*/

	//list view
/*	arrayOfViews = [NSMutableArray array];
	for ( int i = 0; i < 5; i++ ) {
		AZInfiniteCell *e = [AZInfiniteCell new];
		e.image = [NSImage imageNamed:[NSString stringWithFormat:@"%i.pdf", i+1]];
		[arrayOfViews addObject:e];
	}
	azScrollV.infiniteViews = arrayOfViews;
*/
//
//	NSUInteger max = [AtoZ dockSorted].count;
//	NSRect blocksBounds = [infiniteBlocks bounds];
//	infiniteBlocks.unitSize = blocksBounds.size.height/max;
}
//-(void) dockIsSorted {
////	NSLog(@"dorted %@", [AtoZ sharedInstance].dockSorted);
//	arrayOfBlocks = [[AtoZ dockSorted] arrayUsingIndexedBlock:^id(id obj, NSUInteger idx) {
//		AZFile *block = obj;
//		AZInfiniteCell *e = [AZInfiniteCell new];
//		e.file = block;
//		e.backgroundColor = block.color;
//		return e;
//	}];
//	[infiniteBlocks performSelectorOnMainThread:@selector(setInfiniteViews:) withObject:arrayOfBlocks waitUntilDone:YES];// infiniteViews = arrayOfBlocks;
//}
//
//	NSMutableArray *littleVs = [NSMutableArray array];
//	[[AtoZ sharedInstance].dockSorted enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//
//		AZFile *block = obj;
//		AZInfiniteCell *e = [AZInfiniteCell new];
//		e.file = block;
//		e.backgroundColor = block.color;
//		[littleVs addObject: e];
//	}];
//	[pIndi stopAnimation:pIndi];
//	[infiniteBlocks setInfiniteViews: littleVs];

//	infiniteBlocks.horizontalLineScroll = 200;
//}

-(void) applicationDidFinishLaunching:(NSNotification *)notification {
	// where you would set up a delegate (e.g. [Singleton instance].delegate = self)
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dockIsSorted) name:AtoZDockSortedUpdated object:nil];///[AtoZ sharedInstance]];

//	[[AtoZ sharedInstance] performSelectorInBackground:@selector(dockSorted) withObject:nil];
//	[NSThread performAZBlockInBackground:^{

//	}

//	[statusLabel setStringValue:@"Processing..."];
	[NSThread performBlockInBackground:^{

//		NSString *results = PerformMyTimeConsumingOperation(token);
		arrayOfBlocks = [[AtoZ dockSorted] arrayUsingIndexedBlock:^id(id obj, NSUInteger idx) {
			AZFile *block = obj;
			AZInfiniteCell *e = [AZInfiniteCell new];
			e.file = block;
			e.backgroundColor = block.color;
			return e;
		}];

		[[NSThread mainThread] performBlock:^{
			[infiniteBlocks setInfiniteViews:arrayOfBlocks];
			[pIndi stopAnimation:pIndi];
		}];
		
	}];
			//	 detachNewThreadSelector:@selector(dockSorted) toTarget:[AtoZ sharedInstance] withObject:nil];


//			[statusLabel setStringValue:@"Processing completed!"];
//			[resultsView setResults:results];

//	}];

//	[AtoZ sortDockWitheBlock:(void (^)())block{
//		arrayOfBlocks = [[AtoZ dockSorted] arrayUsingIndexedBlock:^id(id obj, NSUInteger idx) {
//			AZFile *block = obj;
//			AZInfiniteCell *e = [AZInfiniteCell new];
//			e.file = block;
//			e.backgroundColor = block.color;
//			return e;
//		}];
//	}]
	//	 detachNewThreadSelector:@selector(dockSorted) toTarget:[AtoZ sharedInstance] withObject:nil];

//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollNotification:) name:@"scrollRequested" object:nil];


//	NSLog(/Volumes/2T/ServiceData/AtoZ.framework/AtoZ/Categories/NSString+AtoZ.m:247:59: Format specifies type 'int' but the argument has type 'NSUInteger' (aka 'unsigned long')@"Surprise: %@", [AtoZiTunes resultsForName:[[AtoZ dockSorted].randomElement valueForKey:@"name"]] );
	//Simple search, for all types and limited to 50 / US country code
//	[api searchMediaWithSearchTerm:@"Jack Johnson"];
	//More refined search, passing media types, limit and country
//	[self.anApi searchMediaWithType:kAJSiTunesAPIMediaTypeSoftware searchTerm:@"Jack Johnson" countryCode:@"US" limit:10];
}

- (void) applicationDidResignActive:(NSNotification *)notification{
//	[winwin fadeOut];
}

-(void)applicationWillBecomeActive:(NSNotification *)notification{
//	if (![winwin isVisible]) [winwin fadeIn];
}

- (void) iTunesApi:(AJSiTunesAPI *)api didCompleteWithResults:(NSArray *)results

{	[results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

	NSLog(@"extra, extra: %@", [obj propertiesPlease] );

	}];
}
/**  this updates the view count indicator, right here from appdeleagte.  could go anyywhere (its triggered by a notification coming all the way from the colored box, before its passed onto the parent scrollview. **/

- (void) scrollNotification: (NSNotification*) note {

//	NSLog(@"obj:  %@   note: %@", note.object, note);
	//lets see if its a request in the list view;
//	id aView = note.object;
//	while (! [ aView isKindOfClass:[AZInfiniteScrollView class]])
//		aView = [aView superview];
//	NSLog(@"aviewprops.... %@", [aView propertiesPlease] );
//	if ([aView isEqualTo:azScrollV] )
//
//	 {
//		NSLog(@" scrolling big nasty klist.  %@  of tot: %@",
//			NSStringFromRect([[azScrollV documentView]visibleRect]),
//			NSStringFromRect([[azScrollV documentView]frame]));

/*		self.viewCount  = [NSString stringWithFormat: @"%ld",[[azScrollV documentView]subviews].count];
		NSUInteger start, stop;
		NSRect visiV  	= [[azScrollV documentView]visibleRect];
//		NSRect visiF = [[azScrollV documentView]frame];
		if ( visiV.origin.y <= 10 ) {
			stop = [[azScrollV documentView]subviews].count;
			start = stop - floor(visiV.size.height / azScrollV.unitSize);
		}
	//	float visiViewH = [[[[azScrollV documentView]subviews]objectAtIndex:5]frame].size.height;
	//	int start 	= ceil ( visiOri   / BOXSIZE );
	//	int top	 	= ceil  ( visiHigh  / BOXSIZE ) - bottom;
		self.visiViews = [NSString stringWithFormat: @"Start:%ld End:%ld",start, stop];
	*/
//	}
}

- (void)noteToAppDelegate:(NSNotification*) note {
//	NSLog(@"Rec'd note. object: %@", note.object);
}

/*
-(IBAction)reZhuzhColors:(id)sender {
	NSLog(@"%@", [azScrollV.infiniteViews valueForKeyPath:@"uniqueID"]);
	[[azScrollV.infiniteViews valueForKeyPath:@"uniqueID"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) { 
		__weak NSString 	*idString 	 = obj;
		__block NSColor 	*randoColore = [NSColor randomColor];
		[[[azScrollV documentView]subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {   
			if ( [obj isKindOfClass:[AZInfiniteCell class]] ) {
				AZInfiniteCell* sv = obj;   NSLog(@"sv props: %@", sv.uniqueID);
				if ( [sv.uniqueID isEqualToString:idString] ) {	
					 sv.backgroundColor = randoColore;
				  ( (sv.frame.origin.y  + sv.frame.size.height) > [azScrollV.documentView visibleRect].size.height ?
					 				[sv setNeedsDisplay:NO] : [sv setNeedsDisplay:YES]);
				}
			}
		}];
	}];
}

*/
@end
