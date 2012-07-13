//
//  AZInfiniteScrollView.m
//  AtoZInfiniteScroll
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.


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

#import "AZInfiniteScrollView.h"


@implementation AZInfiniteScrollView	{	NSMutableArray *_infiniteMutatableViews; }
@synthesize 	infiniteViews;

- (void) awakeFromNib {
	
	[self setPostsFrameChangedNotifications:YES];
	[[self contentView] setPostsBoundsChangedNotifications:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfFrameDidChange:) name:NSViewFrameDidChangeNotification object:[self contentView]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfBoundsDidChange:) name:NSViewBoundsDidChangeNotification object:[self contentView]]; 
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfBoundsDidChange:) name:@"scrollRequested" object:nil]; 

	[[NSNotificationCenter defaultCenter] addObserver:[NSApp delegate] selector:@selector(noteToAppDelegate:) name:NSViewBoundsDidChangeNotification object:[self contentView]]; 

}


- (void) setInfiniteViews:(NSArray *)someInfiniteViews {
	infiniteViews = someInfiniteViews;
	_infiniteMutatableViews = [NSMutableArray arrayWithArray:someInfiniteViews];
	NSLog(@"Views set.  number of views to use and reuse: %ld", _infiniteMutatableViews.count);
	[self selfBoundsDidChange:nil];
}

- (void) selfFrameDidChange:(NSNotification*)note {
	int 	numtoadd 	 = 	0;
	float 	frameheight  = 	[[self contentView]frame].size.height;
	while (	frameheight  > 	BOXSIZE) 
	{ 
			numtoadd++; 
			frameheight  -= 	BOXSIZE;
	}
	if (numtoadd) [self ensureTotal:numtoadd];
	
	//make sure all views remain tidy
	__block	float wide = [[self contentView]frame].size.width;
	[[[self documentView]subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		NSRect curfr = [obj frame];
		curfr.size.width = wide;
		[obj setFrame:curfr];
		( (curfr.origin.y + BOXSIZE) > [[self documentView]visibleRect].size.height ?
			[obj setNeedsDisplay:NO] : [obj setNeedsDisplay:YES]);
	}];
	
	
}

- (void)selfBoundsDidChange:(NSNotification*)note {

	NSRect	docVVisRect	= [self.documentView visibleRect];
	int 	numtoadd 	= [[[self documentView]subviews]count] ;
	
	if (docVVisRect.origin.y < 50) [self ensureTotal:numtoadd];
	[self reflectScrolledClipView:[self contentView]];
	
}

- (void) ensureTotal:(NSUInteger)views {
	
	int 	subVsHave	= [[self documentView] subviews].count - 1;
	int		subVsWant	= views;
	int		subVsNeed	= subVsWant - subVsHave;
//	NSLog(@"ensuring %i views.  Need to add: %i", subVsWant, subVsNeed);
	
	NSRect doc = [[self documentView] frame];
	doc.size.height = subVsHave *BOXSIZE;
	[[self documentView] setFrame:doc];
	
	for (int i = 0; i < subVsNeed; i++) {
		doc.size.height += BOXSIZE;
		[[self documentView]setFrame:doc];
		
		[[[self documentView]subviews]  enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			NSRect p = [obj frame];
			p.origin.y += BOXSIZE;
			[obj setFrame:p];
			( (p.origin.y + BOXSIZE) > [self.documentView visibleRect].size.height ?
			 [obj setNeedsDisplay:NO] : [obj setNeedsDisplay:YES]);
		}];
		NSData * archivedView = [NSKeyedArchiver archivedDataWithRootObject:[_infiniteMutatableViews first]];
		AZSimpleView *sv = [NSKeyedUnarchiver unarchiveObjectWithData:archivedView];
		
		NSRect newbox;
		newbox.size.height = BOXSIZE;
		newbox.size.width = doc.size.width;
		newbox.origin.x = 0;
		newbox.origin.y = 0;//BOXSIZE * ([[self documentView] subviews].count - 1);
		[sv setFrame:newbox];
		[[self documentView]addSubview:sv];
		[_infiniteMutatableViews firstToLast];
	}
	//	NSPoint scrollto = NSMakePoint(0,self.contentView.frame.size.height);
	//	[[self contentView] scrollToPoint:scrollto];
	
}

@end


