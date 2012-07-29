//
//  AZInfiniteScrollView.m
//  AtoZInfiniteScroll
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.

/*
@implementation NSArray (NamedAccessors)
- (id)objectOrNilAtIndex:(NSUInteger)index {
	return (self.count <= index ?  nil : [self objectAtIndex:index]);
}
- (id)first {	return [self objectOrNilAtIndex:0]; }
@end

@implementation NSMutableArray (CardStack)
- (void) firstToLast {
	if ( self.count == 0) return; //there is no object to move, return
	int toIndex = self.count - 1; //toIndex too large, assume a move to end
	[self moveObjectAtIndex:0 toIndex:toIndex];

}
- (void) moveObjectAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) return;
    if (fromIndex >= self.count) return; //there is no object to move, return
    if (toIndex >= self.count) toIndex = self.count - 1; //toIndex too large, assume a move to end
    id movingObject = [self objectAtIndex:fromIndex];
    if (fromIndex < toIndex){
        for (int i = fromIndex; i <= toIndex; i++){
            [self replaceObjectAtIndex:i withObject:(i == toIndex) ? movingObject : [self objectAtIndex:i + 1]];
        }
    } else {        id cObject;		id prevObject;
        for (int i = toIndex; i <= fromIndex; i++){
            cObject = [self objectAtIndex:i];
            [self replaceObjectAtIndex:i withObject:(i == toIndex) ? movingObject : prevObject];
            prevObject = cObject;
        }
    }
}
@end

*/
#import "AZInfiniteScrollView.h"

@implementation AZInfiniteScrollView
{
	float offset;
	BOOL scrollUp;
}
@synthesize 	infiniteViews = _infiniteViews, unit, scale, orientation;

- (void) awakeFromNib {
	offset = 0;
	orientation = AZOrientHorizontal;
	scale = AZInfiteScale1X;
//	NSUserDefaults *uDs = [NSUserDefaults standardUserDefaults];
	[self 				setPostsFrameChangedNotifications:	YES];
	[[self contentView] setPostsBoundsChangedNotifications:	YES];

//	[[NSNotificationCenter defaultCenter] 	addObserver: self 			selector:@selector(scrollDown:) name:@"scrollRequested" 	object:nil];

//	self.anApi = [[AJSiTunesAPI alloc] init];
//	self.anApi.delegate = self;
}
- (void) setInfiniteViews:(NSArray *)infiniteViews {
	_infiniteViews = infiniteViews.mutableCopy;
	NSLog(@"Views set.  number of views to use and reuse: %ld", _infiniteViews.count);
	for (id sv in _infiniteViews ) {
		[self.documentView addSubview: sv];	//	[self setNeedsDisplay:NO];
	}
	[self stack];
}

/*
- (void) popItForView:(AZSimpleView*)vv {

	///[vv frame].size.width];

	//		NSRect wind = windy.frame;
	//		wind.size.width = 1;
	//		[windy setFrame:wind display:YES animate:YES];
	//		[windy fadeOut];
	//		[windy orderOut:self];
	//		self.windy = nil;
	//	}
	NSImageView *f = [[NSImageView alloc]initWithFrame:AZMakeSquare(NSZeroPoint, 30)];

	//	NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:[self frame]
	//														options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways | NSTrackingInVisibleRect |
	//																 NSTrackingMouseMoved
	//																 )
	//														  owner:self
	//													   userInfo:nil];
	//	[f addTrackingArea:area];

	f.image = vv.file.image;
	//	[f.image setCacheMode:NSImageCacheNever];
	//	f.autoresizesSubviews = YES;
	//	initWithView:f attachedToPoint:[self center] inWindow:[self window] onSide:AZPositionBottomLeft atDistance:0];
	//	a.delegate = self;
	*/
/*	if (!self.windy) {
		self.windy = [[AZAttachedWindow alloc] initWithView:nil  attachedToPoint:NSMakePoint(NSMaxX([vv frame]),NSMidY([vv frame])) inWindow:[self window] onSide:AZPositionRight atDistance:-60];
	} else {
		self.windy.view = vv;
	}
	self.windy.backgroundColor = vv.file.color;
	//	[a fadeIn];
	[self.windy makeKeyAndOrderFront:self.windy];
	//	self.windy = a;
*/
//}


//	[self scroll:NSMakeSize(event.deltaX, event.deltaY)];
	// < 0 ? TRUE : FALSE)];
//	[self scrollDown:(event.deltaY < 0 ? TRUE : FALSE)];
//	[[NSNotificationCenter defaultCenter] postNotificationName:@"scrollRequested" object:[NSNumber numberWithFloat: event.deltaY]];
//	__block float scooc /h = self.documentVisibleRect.size.height / _infiniteViews.count;
//	if (scooch < 20) scooch = scooch * 5;
//	[_infiniteViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//	int idx = 0;

- (void)setScale:(AZInfiteScale)aScale {
	scale = aScale;
	[self stack];
}

- (void)setOrientation:(AZOrient)anOrientation{
	orientation = anOrientation;
	[self stack];
}

- (NSRect) unit {
	NSSize 	cSize = [self frame].size;
	switch (orientation) {
		case AZOrientHorizontal:
			cSize.width = cSize.width / _infiniteViews.count ;
			cSize.width = cSize.width * scale;
		break;
		case AZOrientVertical:
			cSize.height = cSize.height / _infiniteViews.count;
			cSize.height = cSize.height * scale;

			break;
	}

	unit = AZMakeRect(NSZeroPoint, cSize);
	return unit;
}

- (void) scrollWheel:(NSEvent *)event {

//	if ([self inLiveResize]) return;
//	if ( MAX(abs(event.deltaX), abs(event.deltaY)) < 10 ) return;
//	else
//	[self simulateScrollWithOffset:0 orEvent:event];

//}

//- (void) simulateScrollWithOffset:(float)f orEvent:(NSEvent*)event {
//	__block	float offset = 0;
//	offset = f;


	NSLog(@"offset: %f   raw event x:%f  y:%f", offset, event.deltaX, event.deltaY);
	[_infiniteViews enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//		id simple = obj;
		NSRect globalShift = self.unit;//  [obj frame];
		switch (orientation) {
			case AZOrientHorizontal:
				offset = event.deltaX;
				//globalShift.size.width;
				scrollUp = (event.deltaX > 0 ? NO : YES );
//				NSLog(@"horizontal.. scrollup: %@", StringFromBOOL(scrollUp));

				globalShift.origin.x += ( scrollUp ? offset * 5 : - offset * 5);
				break;
			case AZOrientVertical:
				offset = self.unit.size.height;
				scrollUp = (event.deltaY > 0 ? NO : YES );
				NSLog(@"vertical.. scrollup: %@", StringFromBOOL(scrollUp));

				globalShift.origin.y += (scrollUp ? offset : - offset);
				break;
		}
//		[self setNeedsDisplay:NO];
		[obj setFrame:globalShift];
		[obj setNeedsDisplay:NO];
	}];

	NSRect flexUnit = self.unit;
	if ( scrollUp ) {
		[_infiniteViews moveObjectAtIndex:_infiniteViews.count-1 toIndex:0];
		switch (orientation) {
			case AZOrientHorizontal:
				flexUnit.origin = NSZeroPoint;
				flexUnit.origin.x -= flexUnit.size.width;
				[[_infiniteViews objectAtIndex:0] setFrame:flexUnit];
				flexUnit.origin.x += flexUnit.size.width;
				[[_infiniteViews objectAtIndex:0] setFrame:flexUnit];
			break;
			case AZOrientVertical:
				flexUnit.origin = NSZeroPoint;
				flexUnit.origin.y -= flexUnit.size.height;
				[[_infiniteViews objectAtIndex:0] setFrame:flexUnit];
				flexUnit.origin.y += flexUnit.size.height;
				[[_infiniteViews objectAtIndex:0] setFrame:flexUnit];
			break;
		}
	} else  {

		id c = [_infiniteViews objectAtIndex:0];
		[_infiniteViews removeObjectAtIndex:0];

		switch (orientation) {
			case AZOrientHorizontal:
				flexUnit.origin = NSMakePoint(0, NSMaxX([self bounds]));
				[c setFrame:flexUnit];
				flexUnit.origin.x -= flexUnit.size.width;
				[c setFrame:flexUnit];
				[_infiniteViews addObject:c];
				break;
			case AZOrientVertical:
				flexUnit.origin = NSMakePoint(0, NSMaxY([self bounds]));
				[c setFrame:flexUnit];
				flexUnit.origin.y -= flexUnit.size.height;
				[c setFrame:flexUnit];
				[_infiniteViews addObject:c];
				break;
		}
//		moved.origin = NSMakePoint(0, NSMaxY([self frame]));
//		[c setFrame:moved];
//		moved.origin.y -= scooch;
//		[c setFrame:moved];
//		[_infiniteViews addObject:c];
	}
	[self stack];
}

- (void) viewDidEndLiveResize {
	[self stack];
}
- (void) stack {
//	if ([self inLiveResize]) return;
	__block NSRect localunit = self.unit;// = [[self contentView]frame];
//	chopped.size.height = chopped.size.height / _infiniteViews.count;
//	chopped.origin = NSZeroPoint;

	[_infiniteViews enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

//		AZInfiniteCell *s = obj;
		NSRect pile = localunit;
		if (orientation == AZOrientHorizontal)
			pile.origin.x = idx * localunit.size.width;
		else
			pile.origin.y = idx * localunit.size.height;
		[obj setFrame: pile];
	}];
//	NSRect sliv =[ self frame];
//	sliv.origin.x = sliv.size.width - 20;
//	sliv.size.width = 20;
//	NSImageView *vvv = [[NSImageView alloc]initWithFrame:sliv];
//	NSImage *bar = [[NSImage alloc]initWithSize:sliv.size];
//	[bar lockFocus];
////	NSGraphicsContext *ctx = [NSGraphicsContext currentContext];
////	[ctx saveGraphicsState];
//	[RED set];
//	NSRectFill(sliv);
//
////	NSBezierPath *b = [NSBezierPath bezierPathWithRect:sliv];
////	NSGradient *backgroundGradient = [[NSGradient alloc] initWithStartingColor:BLACK endingColor:RED];
////	[backgroundGradient drawInBezierPath:b angle:270];
//	[bar unlockFocus];
//	[vvv setImage:bar];
//	[self addSubview:vvv];
//	[ctx restoreGraphicsState];

//	[self reflectScrolledClipView:[self contentView]];
	[self setNeedsDisplay:YES];

}

/*
- (void) featuring: (AZSimpleView*)vv {
	__block BOOL found;
	[_infiniteViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSRect now = [obj bounds];
		if ( [obj isEqualTo:vv]) {
			found = YES;
			now.size.height = now.size.height *4;
		}
		else now.origin.y += (found ? now.size.height *2 : - now.size.height *2);

		[obj setFrame:AZCenterRectOnPoint(now, [self center])];
	}];
}
*/
@end
	 //- (void) selfFrameDidChange:(NSNotification*)note {
	 //
	 //	NSRect	docVVisRect	= [self.documentView visibleRect];
	 //	self.unitSize = NSMakeSize(
	 //		docVVisRect.size.width,
	 //		docVVisRect.size.height / self.visiViews);
	 //	[self updateScrollStuff];
	 //}

	 //	NSUInteger 	numtoadd 	= [self.documentView subviews].count;
	 //	self.unitSize =  docVVisRect.size.height / self.visiViews;
	 //	if (docVVisRect.origin.y < 60) [self ensureTotal:numtoadd];
	 //- (void) setIndex:(NSUInteger)desiredIndex {
	 //
	 //	NSUInteger currentIndex = _index;
	 //	_index = desiredIndex;
	 //	while ( desiredIndex > _infiniteMutatableViews.count) {
	 //		NSData * archivedView = [NSKeyedArchiver archivedDataWithRootObject:[_infiniteViews first]];
	 //		AZSimpleView *sv = [NSKeyedUnarchiver unarchiveObjectWithData:archivedView];
	 //		[_infiniteMutatableViews addObject:sv];
	 //	}
	 //
	 //
	 //	if (desiredIndex > currentIndex ) {
	 //		[self.]
	 //	}
	 //
	 //
	 //
	 //}
	 //
	 //-(void) addExactly:(NSUInteger)views {
	 //
	 //	for (int i =0; i < views; i++) {
	 //
	 //		NSRect nowRect = [[self contentView]frame];
	 //		nowRect.size.height += self.unitSize.height;
	 //		nowRect.size.width = [self.documentView visibleRect].size.width;
	 //		nowRect.origin = NSZeroPoint;
	 //		nowRect.origin.y += self.unitSize.height;
	 //		[[self documentView]setFrame:nowRect];
	 //		[self setNeedsDisplay:NO];
	 //
	 //
	 //		NSRect newbox;
	 //		newbox.size = self.unitSize;
	 //		newbox.origin = NSZeroPoint;
	 //		[sv setFrame:newbox];
	 //		[[self documentView]addSubview:sv];
	 //		[_infiniteMutatableViews firstToLast];
	 //	}
	 //	[self setNeedsDisplay:YES];
	 //
	 //}
	 //
	 //- (void) updateScrollStuff {
	 //
	 //	self.unitSize = NSMakeSize(
	 //		[[self contentView]frame].size.width,
	 //		[[self contentView]frame].size.height / self.visiViews);
	 //
	 //	NSUInteger viewsNow = [[[self documentView]subviews]count];
	 //	if ( viewsNow < self.visiViews )
	 //		[self addExactly:self.visiViews - viewsNow];
	 //	if ( (startingIndex + self.visiViews ) < viewsNow)
	 //		[self addExactly:viewsNow - (startingIndex + self.visiViews)];
	 ////
	 ////			doc.size.height += self.unitSize;
	 ////			[[self documentView]setFrame:doc];
	 ////
	 ////			[[[self documentView]subviews]  enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
	 ////				NSRect p = [obj frame];
	 ////				p.origin.y += self.unitSize;
	 ////				[obj setFrame:p];
	 ////				//			( (p.origin.y + self.unitSize) > [self.documentView visibleRect].size.height ?
	 ////				//			 [obj setNeedsDisplay:NO] : [obj setNeedsDisplay:YES]);
	 ////			}];
	 ////
	 ////	doc.size.height = subVsHave * self.unitSize;
	 ////	[[self documentView] setFrame:doc];
	 ////
	 ////	//	NSPoint scrollto = NSMakePoint(0,self.contentView.frame.size.height);
	 ////	//	[[self contentView] scrollToPoint:scrollto];
	 ////	int 	numtoadd 	 = 	0;
	 ////	float 	frameheight  = 	self.contentSize.height;
	 ////	while (	frameheight  > 	self.unitSize.height )
	 ////	{
	 ////			numtoadd++;
	 ////			frameheight  -= 	self.unitSize.height;
	 ////	}
	 ////	if (numtoadd) [self ensureTotal:numtoadd];

	 /*	//make sure all views remain tidy
	  __block	float wide = [[self contentView]frame].size.width;
	  [[[self documentView] subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
	  NSRect curfr = [obj frame];
	  if (curfr.size.width != wide){
	  curfr.size.width = wide;
	  [obj setFrame:curfr];
	  ( (curfr.origin.y + self.unitSize) > [[self documentView]visibleRect].size.height ?
	  [obj setNeedsDisplay:NO] : [obj setNeedsDisplay:YES]);
	  }
	  }];
	  */

	 //}

	 //- (void) boundsDidChangeNotification: (NSNotification *) notification
	 //{
	 //    [self setNeedsDisplay: YES];
	 //    // or whatever work you need to do
	 //
	 //} // boundsDidChangeNotification

	 //- (void)selfBoundsDidChange:(NSNotification*)note {
	 //
	 //	NSRect	docVVisRect	= [self.documentView visibleRect];
	 //	NSUInteger 	numtoadd 	= [self.documentView subviews].count;
	 //
	 //
	 //	if (docVVisRect.origin.y < 60) [self ensureTotal:numtoadd];
	 //	[self reflectScrolledClipView:[self contentView]];
	 //	[self setNeedsDisplay:YES];
	 //}

	 //- (void) ensureTotal:(NSUInteger)views {

//	NSImageView *f = [[NSImageView alloc]initWithFrame:AZMakeSquare(NSZeroPoint, 100)];
//	f.autoresizesSubviews = YES;
//	initWithView:f attachedToPoint:[self center] inWindow:[self window] onSide:AZPositionBottomLeft atDistance:0];
//	self.windy = [[AZAttachedWindow alloc] initWithView:f attachedToPoint:NSMakePoint(NSMaxX([self frame]),NSMidY([self frame])) onSide:AZPositionRight atDistance:[self frame].size.width];
//	[center addObserver: [NSApp delegate] 			selector:@selector(noteToAppDelegate:)
//			name:NSViewBoundsDidChangeNotification 	object:[self contentView]];
//	[center addObserver:self selector:@selector(scrollDown:) name:NSViewFrameDidChangeNotification object:[self contentView]];
//	[center addObserver:self selector:@selector(scrollDown:) name:NSViewBoundsDidChangeNotification object: [self contentView]];
////	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfBoundsDidChange:) name:@"scrollRequested" object:nil];


