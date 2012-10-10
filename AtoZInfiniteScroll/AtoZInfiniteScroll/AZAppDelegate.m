////
////  AZAppDelegate.m
////  AtoZInfiniteScroll
////
////  Created by Alex Gray on 7/12/12.
////  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
////

#import "AZAppDelegate.h"


@implementation AZAppDelegate

- (void) awakeFromNib	{

//	_controlWindow.level = NSScreenSaverWindowLevel;
	_controlWindow.position =  AZOrientTop;
	[_controlWindow slideIn];
//	[_controlWindow setFrame: AZMakeRectMaxXUnderMenuBarY(40) display:YES];

	////	AZMakeRect(NSMakePoint(
	////					ScreenWidess() - [_controlWindow frame].size.width,
	////					ScreenHighness() - 22 - [_controlWindow frame].size.height),
	////					[_controlWindow frame].size ) display:NO];
//	[_controlWindow slideDown];
	[_spinner startAnimation:_spinner];
	[_scaleSlider setAction:@selector(switchViewScale:)];
	[_orientButton setAction:@selector(swapOrient:)];
	//	[winwin setDelegate:self];	[winwin setDefaultFirstResponder];
	[NSApp setDelegate:self];
	//	[self swapOrient:@0];
	[NSApp activateIgnoringOtherApps:YES];
}
-(void) applicationDidFinishLaunching:(NSNotification *)notification {
	[_spinner startAnimation:_spinner];
	//	[NSThread performBlockInBackground:^{
	//	[_inf
	//		//		NSString *results = PerformMyTimeConsumingOperation(token);
	////	[[AtoZ dockSorted] arrayUsingIndexedBlock:^id(AZFile *obj, NSUInteger idx) {
}
- (IBAction)switchViewScale:(id)sender {
	//    static int  selectedSegment = -1;
	switch  ([sender intValue])		{
		case 1: // Left
			[_infiniteBlocks setScale : AZInfiteScale1X];
			break;
		case 2: // Day
			[_infiniteBlocks setScale : AZInfiteScale2X];
			break;
		case 3:	[_infiniteBlocks setScale : AZInfiteScale3X ]; break;
		case 4:	[_infiniteBlocks setScale : AZInfiteScale10X ]; break;
	}
	////		[viewControl setSelected:NO forSegment:0];
	////		[viewControl setSelected:NO forSegment:4];
	////		if(selectedSegment >= 0)
	////			[viewControl setSelected:(1 == selectedSegment) ? YES : NO forSegment:1];
	////			[viewControl setSelected:(2 == selectedSegment) ? YES : NO forSegment:2];
	////			[viewControl setSelected:(3 == selectedSegment) ? YES : NO forSegment:3];
	////		}
}

- (IBAction)swapOrient:(id)sender {
}

- (IBAction) peruseApps:(id)sender {
//	[_spinner startAnimation:pIndi];
	[NSThread performBlockInBackground:^{

//		_arrayOfBlocks =
//	[self setInfi:[AtoZ dockSorted]];
//		 [arrayUsingIndexedBlock:^id(id obj, NSUInteger idx) {
//			AZFile *block = obj;
//			AZInfiniteCell *e = [AZInfiniteCell new];
//			e.file = block;
//			e.backgroundColor = block.color;
//			return e;
//		}];
//		_infiniteBlocks.infiniteViews  = arrayOfBlocks;
//		[[NSThread mainThread] performBlock:^{
//			[_infiniteBlocks setInfiniteViews:arrayOfBlocks];
//			[_spinner stopAnimation:pIndi];
//		}];
	}];
}

@end
