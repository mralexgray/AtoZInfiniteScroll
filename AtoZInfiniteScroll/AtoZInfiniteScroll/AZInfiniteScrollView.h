//
//  AZInfiniteScrollView.h
//  AtoZInfiniteScroll
//
//  Created by Alex Gray on 7/12/12.
//  Copyright (c) 2012 mrgray.com, inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AZSimpleView.h"

#define BOXSIZE 100

@interface AZInfiniteScrollView : NSScrollView

@property (nonatomic, retain) NSArray *infiniteViews;

@end
