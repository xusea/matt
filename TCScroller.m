//
//  TCScroller.m
//  easybackgroundremove
//
//  Created by xusea on 15/12/31.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "TCScroller.h"

@implementation TCScroller

- (void)drawRect:(NSRect)dirtyRect {
   // [super drawRect:dirtyRect];
    //[[NSColor clearColor] set];
   // NSRectFill(dirtyRect);
    
   /* NSBezierPath * bp = [NSBezierPath bezierPathWithRect:[self bounds]];
    [[NSColor greenColor] set];
    [bp setLineWidth:2];
    [bp fill];*/
    NSImage * rightbuttom = [NSImage imageNamed:@"rightbuttom.png"];
    [rightbuttom drawInRect:dirtyRect];
    [self drawKnob];

    
    // Drawing code here.
}

@end
