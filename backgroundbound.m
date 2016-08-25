//
//  backgroundbound.m
//  easybackgroundremove
//
//  Created by xusea on 15/12/20.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "backgroundbound.h"

@implementation backgroundbound
@synthesize i;
@synthesize pointbound;
@synthesize bgtype;
- (id)initWithFrame:(NSRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSTrackingArea *   trackingArea = [[NSTrackingArea alloc] initWithRect:frame
                                                                       options: (NSTrackingMouseEnteredAndExited  | NSTrackingActiveInKeyWindow  |NSTrackingActiveAlways)
                                                                         owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
    }
    i = nil;
    pointbound = [self bounds];
    bgtype = 1;
    return self;
}
- (void) awakeFromNib{
    i = nil;
    pointbound = [self bounds];
    bgtype = 1;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    if(i == nil)
    {
        return ;
    }
    [i drawInRect:[self pointbound]];
    //[i drawInRect:[self pointbound] fromRect:[self pointbound] operation:NSCompositeSourceOver fraction:1.0];
        // Drawing code here.
}

@end
