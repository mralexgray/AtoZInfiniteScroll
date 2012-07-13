//  AZSimpleView.m

#import "AZSimpleView.h"

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
@property (nonatomic, retain) NSAttributedString *string;
@property (nonatomic, retain) AZTextView *atv;
@end

@implementation AZSimpleView
@synthesize backgroundColor, selected, string, atv, uniqueID, image;

- (id)initWithFrame:(NSRect)frame
{
	if (self = [super initWithFrame:frame]) {
		backgroundColor = nil;
		uniqueID = nil;
		atv = nil;
		backgroundColor = [NSColor randomColor];
		self.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;
		uniqueID = [NSString newUniqueIdentifier];
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
	[self addSubview: atv];
}

- (id)initWithCoder:(NSCoder*)coder {
	if ((self = [super initWithCoder:coder])) {
	
		backgroundColor = [coder decodeObjectForKey: @"backgroundColor"];
		if	(!backgroundColor) backgroundColor = [NSColor redColor];
		uniqueID = [coder decodeObjectForKey: @"uniqueID"];
		image = [coder decodeObjectForKey: @"image"];
		atv = [coder decodeObjectForKey:@"atv"];
		[self addSubview:atv];
	
	}
	return self;
}


- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:backgroundColor forKey:@"backgroundColor"];
    [aCoder encodeObject:uniqueID forKey:@"uniqueID"];    
	[aCoder encodeObject:image forKey:@"image"];
    [aCoder encodeObject:atv forKey:@"atv"];
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
	[backgroundColor set];
    NSRectFill(rect);
	if (image) {
		NSRect r = self.bounds;
		float max = (r.size.width > r.size.height ? r.size.height : r.size.width) * .8;
		r.size = NSMakeSize(max, max);
		[image setSize:r.size];
		[image compositeToPoint:NSMakePoint(self.frame.size.width - (max*1.2), max*.1) fromRect:NSZeroRect operation:NSCompositeSourceOver];
	}
	if (!atv) [self makeTextView];
	[[atv textStorage] setAttributedString:self.string];

}

- (void) setSelected:(BOOL)isselected {
	selected = isselected;
	self.backgroundColor = backgroundColor.complement;
	[self setNeedsDisplay:YES];


}

- (void) mouseDown:(NSEvent *)theEvent {
	self.selected =! selected;
}

- (void)scrollWheel:(NSEvent *)event
{
//	NSLog(@"SCROLLTIME");
   	[[self nextResponder] scrollWheel:event];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"scrollRequested" object:self];
}

@end
