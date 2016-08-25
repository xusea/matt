//
//  shellview.m
//  easybackgroundremove
//
//  Created by xusea on 15/12/24.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "shellview.h"

@implementation shellview

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
   /* NSBezierPath * bp = [NSBezierPath bezierPathWithRect:[self bounds]];
    [[NSColor greenColor] set];
    [bp setLineWidth:2];
    [bp stroke];*/
    // Drawing code here.
}
- (NSSize)intrinsicContentSize
{
    return NSMakeSize(rectwidth,rectheight);
}
@end
