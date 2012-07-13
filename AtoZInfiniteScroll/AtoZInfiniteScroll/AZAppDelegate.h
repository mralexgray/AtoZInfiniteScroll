//
//  AZAppDelegate.h
//  AtoZInfiniteScroll
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AZInfiniteScrollView.h"
#import "AZSimpleView.h"

@interface AZAppDelegate : NSObject <NSApplicationDelegate>

@property (retain) 			NSString			 *visiViews;
@property (retain) 			NSString			 *viewCount;
@property (assign) IBOutlet AZInfiniteScrollView *azScrollV;

-(IBAction)reZhuzhColors:(id)sender;

@end
