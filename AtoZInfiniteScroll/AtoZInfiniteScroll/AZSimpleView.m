//  AZSimpleView.m

#import "AZSimpleView.h"
#import "AZInfiniteScrollView.h"
#import <AtoZ/AtoZ.h>

@implementation NSColor (AZFunColores)
- (NSColor *)contrastingForegroundColor {
	NSColor *c = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	CGFloat r, g, b, a;
	[c getRed:&r green:&g blue:&b alpha:&a];
	CGFloat brite = sqrt((r * r * 0.241) + (g * g * 0.691) + (b * b * 0.068));
	if (brite > 0.57) return NSColor.blackColor; else return NSColor.whiteColor;
}
- (NSColor *)complement {
	NSColor *c = [self colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	CGFloat h,s,b,a;
	[c getHue:&h saturation:&s brightness:&b alpha:&a];
	h += 0.5;	if (h > 1) h -= 1.0;
	return [NSColor colorWithDeviceHue:h saturation:s brightness:b alpha:a];
}

+ (NSColor *)randomColor {
	int red = (arc4random() % (255));	int green = (arc4random() % (255));	int blue = (arc4random() % (255));
	return [NSColor colorWithCalibratedRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

@end

@implementation NSString (UniqueID)
+ (NSString *)newUniqueIdentifier {
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	CFStringRef identifier = CFUUIDCreateString(NULL, uuid);
	CFRelease(uuid); 	return CFBridgingRelease(identifier);
}
@end

@interface AZTextView : NSTextView
@end
@implementation AZTextView
- (void) mouseDown:(NSEvent *)theEvent {
   [[self nextResponder] mouseDown:theEvent];
}
@end

@interface AZSimpleView ()
@property (nonatomic, strong) NSAttributedString *string;
@property (nonatomic, strong) NSTrackingArea *tArea;
@property (nonatomic, strong) AZTextView *atv;
@end

@implementation AZSimpleView
@synthesize backgroundColor, selected, string, atv, uniqueID, image, hasText, tArea, file, itunesApi, itunesResults, hovered;//windy;




- (void) iTunesApi:(AJSiTunesAPI *)api didCompleteWithResults:(NSArray *)results

{
	if ([api isEqualTo: self.itunesApi]) {
		[results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			NSLog(@"extra, extra: %@", [obj propertiesPlease] );
		}];
	} else NSLog(@"Yes I delegate, but not me, this time");
	
}




- (id)initWithFrame:(NSRect)frame
{
	if (self = [super initWithFrame:frame]) {
	tArea = [[NSTrackingArea alloc] initWithRect:[self frame]
															options:(NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways | NSTrackingInVisibleRect |
																	 NSTrackingMouseMoved
																	 )
															  owner:self
														   userInfo:nil];
		[self addTrackingArea:tArea];
		
		file = nil;
		backgroundColor = nil;
		uniqueID = nil;
		atv = nil;
		hasText = NO;
//		backgroundColor = [NSColor randomColor];
		self.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
		uniqueID = [NSString newUniqueIdentifier];
//		self.itunesApi = [[AJSiTunesAPI alloc] init];
//		self.itunesApi.delegate = self;

	}
	return self;
}

- (void) makeTextView {

	NSMutableParagraphStyle *theStyle =[[NSMutableParagraphStyle alloc] init];
	[theStyle setLineSpacing:12];
	atv = [[AZTextView alloc]initWithFrame:NSInsetRect([self bounds],3,3)];
	[atv setSelectable:NO];
	[atv setDefaultParagraphStyle:theStyle];
	[atv setBackgroundColor:[NSColor clearColor]];
	[[atv textStorage] setForegroundColor:[NSColor blackColor]];
//	[self addSubview: atv];
}

- (id)initWithCoder:(NSCoder*)coder {
	if ((self = [super initWithCoder:coder])) {
	
		backgroundColor = [coder decodeObjectForKey: @"backgroundColor"];
		if	(!backgroundColor) backgroundColor = [NSColor redColor];
		uniqueID = [coder decodeObjectForKey: @"uniqueID"];
		image = [coder decodeObjectForKey: @"image"];
		atv = [coder decodeObjectForKey:@"atv"];
		file = [coder decodeObjectForKey:@"file"];
		hasText = [coder decodeBoolForKey:@"hasText"];
//		if (atv)
//			[self addSubview:atv];

	}
	return self;
}


- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:backgroundColor forKey:@"backgroundColor"];
    [aCoder encodeObject:uniqueID forKey:@"uniqueID"];    
    [aCoder encodeObject:file forKey:@"file"];
	[aCoder encodeObject:image forKey:@"image"];
    [aCoder encodeObject:atv forKey:@"atv"];
	[aCoder encodeBool:hasText forKey:@"hasText"];
}

- (NSAttributedString *) string {
	string = nil;
	string = [[NSAttributedString alloc] initWithString:
		[NSString stringWithFormat:@"NOT SO UNIQUE ID:\n%@\n\nSELECTED: %@ ", uniqueID,									StringFromBOOL(selected)]
		attributes:[NSDictionary dictionaryWithObjectsAndKeys:	
				[NSFont fontWithName:@"Ubuntu Mono Bold" size:15],
				NSFontAttributeName, backgroundColor.contrastingForegroundColor, NSForegroundColorAttributeName,nil]];
	return string;
}


- (void)drawRect:(NSRect)rect {


//	[backgroundColor set];//÷
//	NSGradient *rrr = [[NSGradient alloc]initWithStartingColor:backgroundColor.darker.darker e/ndingColor:backgroundColor.brighter.brighter ];
//	initWithColorsAndLocations:
/*
	backgroundColor.darker.darker,  	 0,
	backgroundColor, 					.1,
	backgroundColor, 					.9,
	backgroundColor.darker.darker,		 1,nil]; */
//	NSBezierPath *p =[NSBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:5 inCorners:OSBottomRightCorner];
	NSBezierPath *p =[NSBezierPath bezierPathWithRect: [self bounds]];// cornerRadius:0];
	[p fillGradientFrom:backgroundColor.darker.darker.darker to:backgroundColor.brighter.brighter angle:270];
	//angle:270];
//    NSRectFill(rect);
/*	if (image) {
		NSRect r = self.bounds;
		float max = (r.size.width > r.size.height ? r.size.height : r.size.width) * .8;
		r.size = NSMakeSize(max, max);
		[image setSize:r.size];
		[image drawAtPoint:NSMakePoint(self.frame.size.width - (max*1.2), max*.1) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
	}
	if (hasText) {
		if (!atv) [self makeTextView];
		[self addSubview:atv];
		[[atv textStorage] setAttributedString:self.string];
	}*/
}

/*
- (void) setSelected:(BOOL)isselected {

	selected = isselected;
	NSRect now = [self frame];
	now.size.height += 100;
	now.size.width += 100;
	now.origin.y -= 100;
	now.origin.x -= 100;
	[[self animator] setFrame:now];
	[self.itunesApi searchMediaWithType:kAJSiTunesAPIMediaTypeSoftware searchTerm:self.file.name countryCode:@"US" limit:1];

//	self.backgroundColor = backgroundColor.complement;
//	NSRect temp = [self frame];
//	temp = AZScaleRect( temp, (isselected ? 15 : 1/15));
//	[[self animator] setFrame:temp];
//	[self setNeedsDisplay:YES];
}*/

- (void) mouseEntered:(NSEvent *)theEvent {
	self.hovered = YES;
	[[NSApp delegate] performSelector:@selector(simpleHovered:) withObject:self];
//	id aView = self.superview;
//	while (! [ aView isKindOfClass:[AZInfiniteScrollView class]])
//		aView = [aView superview];
//	[(AZInfiniteScrollView*)aView popItForView:self];
//
//	[self performSelector:@selector(makeThatWindowGirl) afterDelay:1];
//}
//- (void)makeThatWindowGirl {
//
//	if (!self.hovered) { self.selected = NO; return; }
//	NSLog(@"makin windy for: %@", self.file.name);
//	self.selected = YES;
//
////	self.windy = nil;
////	[self.windy makeKeyAndOrderFront:self];
////	AZTalker *f = [[AZTalker alloc]init];
////	[f say:$(@"%@", self.file.name)];
}


- (void) mouseExited:(NSEvent *)theEvent {
	self.hovered = NO;
	//	AZTalker *f = [[AZTalker alloc]init];
	//	[f say:$(@"%@", self.file.name)];
	
//	id aView = self.superview;
//	while (! [ aView isKindOfClass:[AZInfiniteScrollView class]])
//		aView = [aView superview];
//	[(AZInfiniteScrollView*)aView stack];

//	self.windy = nil;

}



- (void) mouseDown:(NSEvent *)theEvent {
	self.selected =! selected;
}

@end
