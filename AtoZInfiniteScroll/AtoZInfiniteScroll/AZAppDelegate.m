//
//  AZAppDelegate.m
//  AtoZInfiniteScroll
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import "AZAppDelegate.h"
#import "AZSimpleView.h"

@implementation AZAppDelegate  			{ NSMutableArray *arrayOfViews; }
@synthesize 	azScrollV;
@synthesize 	viewCount;
@synthesize  	visiViews;

- (void) awakeFromNib	{
										arrayOfViews = [NSMutableArray array];
	for ( int i = 0; i < 5; i++ ) {
		AZSimpleView *e = [AZSimpleView new];
		e.image = [NSImage imageNamed:[NSString stringWithFormat:@"%i.pdf", i+1]];
		[arrayOfViews addObject:e];
	}
	azScrollV.infiniteViews = arrayOfViews;

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollNotification:) name:@"scrollRequested" object:nil]; 

}

/**  this updates the view count indicator, right here from appdeleagte.  could go anyywhere (its triggered by a notification coming all the way from the colored box, before its passed onto the parent scrollview. **/

- (void) scrollNotification: (NSNotification*) note {
	NSLog(@"%@  of tot: %@", NSStringFromRect([[azScrollV documentView]visibleRect]), NSStringFromRect([[azScrollV documentView]frame]));
	self.viewCount  = [NSString stringWithFormat: @"%ld",[[azScrollV documentView]subviews].count];
	int start, stop;
	NSRect visiV  	= [[azScrollV documentView]visibleRect];
	NSRect visiF = [[azScrollV documentView]frame];
	if ( visiV.origin.y <= 10 ) {
		stop = [[azScrollV documentView]subviews].count;
		start = stop - floor(visiV.size.height / BOXSIZE);
	}
//	float visiViewH = [[[[azScrollV documentView]subviews]objectAtIndex:5]frame].size.height;
//	int start 	= ceil ( visiOri   / BOXSIZE );
//	int top	 	= ceil  ( visiHigh  / BOXSIZE ) - bottom;
	self.visiViews = [NSString stringWithFormat: @"Start:%i End:%i",start, stop];
}

- (void)noteToAppDelegate:(NSNotification*) note {
	NSLog(@"Rec'd note. object: %@", note.object);
}

-(IBAction)reZhuzhColors:(id)sender {
	NSLog(@"%@", [azScrollV.infiniteViews valueForKeyPath:@"uniqueID"]);
	[[azScrollV.infiniteViews valueForKeyPath:@"uniqueID"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) { 
		__block NSString 	*idString 	 = obj;
		__block NSColor 	*randoColore = [NSColor randomColor];
		[[[azScrollV documentView]subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {   
			if ( [obj isKindOfClass:[AZSimpleView class]] ) {
				AZSimpleView* sv = obj;   NSLog(@"sv props: %@", sv.uniqueID);
				if ( [sv.uniqueID isEqualToString:idString] ) {	
					 sv.backgroundColor = randoColore;
				  ( (sv.frame.origin.y  + sv.frame.size.height) > [azScrollV.documentView visibleRect].size.height ?
					 				[sv setNeedsDisplay:NO] : [sv setNeedsDisplay:YES]);
				}
			}
		}];
	}];
}


@end
