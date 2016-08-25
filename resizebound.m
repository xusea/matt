//
//  resizebound.m
//  easybackgroundremove
//
//  Created by xusea on 15/12/19.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "resizebound.h"

@implementation resizebound

@synthesize i;
@synthesize pointbound;
@synthesize imageboung;
@synthesize zoomfactor;
@synthesize lastpoint;
@synthesize cornersize;
@synthesize centersize;
@synthesize status;
@synthesize background;
@synthesize resizegap;
- (id)initWithFrame:(NSRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSTrackingArea *   trackingArea = [[NSTrackingArea alloc] initWithRect:frame
                                                                       options: (NSTrackingMouseEnteredAndExited  | NSTrackingActiveInKeyWindow  |NSTrackingActiveAlways)
                                                                         owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
    }
    pointbound = [self bounds];
    imagebound = [self bounds];
    lastpoint.x = lastpoint.y = 0;
    zoomfactor = 1;
    cornersize.height = cornersize.width = dragcornersize;
    centersize.height = centersize.width = dragcentersize;
    status = 0;
    background = nil;
    resizegap = 40;
    return self;
}
- (void) awakeFromNib{
    pointbound = [self bounds];
    lastpoint.x = lastpoint.y = 0;
    zoomfactor = 1;
    cornersize.height = cornersize.width = dragcornersize;
    centersize.height = centersize.width = dragcentersize;
    status = 0;
    background = nil;
    resizegap = 40;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if(i == nil)
    {
        return ;
    }
    
    //[i drawInRect:[self pointbound]];
    [i drawInRect:[self imageboung]];
    NSBezierPath * bp = [NSBezierPath bezierPathWithRect:[self pointbound]];
    [bp setLineWidth:3 / zoomfactor];
    [[NSColor blackColor] set];
    [bp stroke];
    
    NSImage * leftcorner = [NSImage imageNamed:@"leftcorner.png"];
    NSImage * rightcorner = [NSImage imageNamed:@"rightcorner.png"];
    
    NSRect lefttop, righttop, leftbuttom, rightbuttom;
    NSSize cur_cornersize = cornersize;
    cur_cornersize.width /= zoomfactor;
    cur_cornersize.height /= zoomfactor;
    lefttop.size = cur_cornersize;
    righttop.size = cur_cornersize;
    leftbuttom.size = cur_cornersize;
    rightbuttom.size = cur_cornersize;
    
    lefttop.origin.x = pointbound.origin.x;
    lefttop.origin.y = pointbound.origin.y + pointbound.size.height - cur_cornersize.height;
    
    righttop.origin.x = pointbound.origin.x + pointbound.size.width - cur_cornersize.width;
    righttop.origin.y = pointbound.origin.y + pointbound.size.height - cur_cornersize.height;

    leftbuttom.origin.x = pointbound.origin.x;
    leftbuttom.origin.y = pointbound.origin.y;
    
    rightbuttom.origin.x = pointbound.origin.x + pointbound.size.width - cur_cornersize.width;
    rightbuttom.origin.y = pointbound.origin.y;
    
    
    [leftcorner drawInRect: lefttop];
    [leftcorner drawInRect: rightbuttom];
    
    [rightcorner drawInRect:leftbuttom];
    [rightcorner drawInRect:righttop];

    NSImage * centermove = [NSImage imageNamed:@"centermove.png"];
    NSRect center;
    center.size = centersize;
    center.size.width /= zoomfactor;
    center.size.height /= zoomfactor;
    center.origin.x = pointbound.origin.x + pointbound.size.width / 2 - center.size.width / 2;
    center.origin.y = pointbound.origin.y + pointbound.size.height / 2 - center.size.height / 2;
    [centermove drawInRect:center];
    // Drawing code here.
}
- (NSSize)intrinsicContentSize
{
    return NSMakeSize(rectwidth,rectheight);
}
- (void)mouseDown:(NSEvent *)theEvent
{
    if(i == nil)
    {
        return ;
    }
    
    NSRect locat;
    locat.origin = [theEvent locationInWindow];
    NSPoint local_point = [self convertPoint:locat.origin fromView:nil];
    lastpoint = local_point;
    
    // check if in center
    NSRect center;
    center.size = centersize;
    center.size.width /= zoomfactor;
    center.size.height /= zoomfactor;
    center.origin.x = pointbound.origin.x + pointbound.size.width / 2 - center.size.width / 2;
    center.origin.y = pointbound.origin.y + pointbound.size.height / 2 - center.size.height / 2;
    status = 0;
    if(local_point.x < center.origin.x
       || local_point.x > center.origin.x + center.size.width
       || local_point.y < center.origin.y
       || local_point.y > center.origin.y + center.size.height)
    {
        
    }
    else
    {
        status = 1;
        return ;
    }
    
    // check if in corner
    NSRect lefttop, righttop, leftbuttom, rightbuttom;
    NSSize cur_cornersize = cornersize;
    cur_cornersize.width /= zoomfactor;
    cur_cornersize.height /= zoomfactor;
    lefttop.size = cur_cornersize;
    righttop.size = cur_cornersize;
    leftbuttom.size = cur_cornersize;
    rightbuttom.size = cur_cornersize;
    
    lefttop.origin.x = pointbound.origin.x;
    lefttop.origin.y = pointbound.origin.y + pointbound.size.height - cur_cornersize.height;
    
    righttop.origin.x = pointbound.origin.x + pointbound.size.width - cur_cornersize.width;
    righttop.origin.y = pointbound.origin.y + pointbound.size.height - cur_cornersize.height;
    
    leftbuttom.origin.x = pointbound.origin.x;
    leftbuttom.origin.y = pointbound.origin.y;
    
    rightbuttom.origin.x = pointbound.origin.x + pointbound.size.width - cur_cornersize.width;
    rightbuttom.origin.y = pointbound.origin.y;
    
    if(local_point.x >= lefttop.origin.x
       && local_point.x <= lefttop.origin.x + cur_cornersize.width
       && local_point.y >= lefttop.origin.y
       && local_point.y <= lefttop.origin.y + cur_cornersize.height)
    {
        NSLog(@"click in lefttop");
        status = 2;
        return;
    }
    
    if(local_point.x >= leftbuttom.origin.x
       && local_point.x <= leftbuttom.origin.x + cur_cornersize.width
       && local_point.y >= leftbuttom.origin.y
       && local_point.y <= leftbuttom.origin.y + cur_cornersize.height)
    {
        NSLog(@"click in leftbuttom");
        status = 3;
        return;
    }
    
    if(local_point.x >= righttop.origin.x
       && local_point.x <= righttop.origin.x + cur_cornersize.width
       && local_point.y >= righttop.origin.y
       && local_point.y <= righttop.origin.y + cur_cornersize.height)
    {
        NSLog(@"click in righttop");
        status = 4;
        return;
    }
    
    if(local_point.x >= rightbuttom.origin.x
       && local_point.x <= rightbuttom.origin.x + cur_cornersize.width
       && local_point.y >= rightbuttom.origin.y
       && local_point.y <= rightbuttom.origin.y + cur_cornersize.height)
    {
        NSLog(@"click in rightbuttom");
        status = 5;
        return;
    }
}
- (void)mouseDragged:(NSEvent *)theEvent
{
    if(i == nil)
    {
        return ;
    }

    
    NSRect locat;
    locat.origin = [theEvent locationInWindow];
    NSPoint local_point = [self convertPoint:locat.origin fromView:nil];
    if(status == 1)
    {
        pointbound.origin.x += local_point.x - lastpoint.x;
        pointbound.origin.y += local_point.y - lastpoint.y;
        lastpoint = local_point;
        if(background != nil)
        {
            [background setPointbound:pointbound];
        }
    }
    //lefttop
    if(status == 2
       && local_point.x + resizegap < pointbound.origin.x + pointbound.size.width
       && local_point.y > pointbound.origin.y + resizegap)
    {
        pointbound.origin.x += local_point.x - lastpoint.x;
        //pointbound.origin.y += local_point.y - lastpoint.y;
        pointbound.size.height += local_point.y - lastpoint.y;
        pointbound.size.width -= local_point.x - lastpoint.x;
        lastpoint = local_point;
        if(background != nil)
        {
            [background setPointbound:pointbound];
        }

    }
    //leftbuttom
    if(status == 3
       && local_point.x + resizegap < pointbound.origin.x + pointbound.size.width
       && local_point.y + resizegap < pointbound.origin.y + pointbound.size.height)
    {
        pointbound.origin.x += local_point.x - lastpoint.x;
        pointbound.origin.y += local_point.y - lastpoint.y;
        pointbound.size.width -= local_point.x - lastpoint.x;
        pointbound.size.height -= local_point.y - lastpoint.y;
        lastpoint = local_point;
        if(background != nil)
        {
            [background setPointbound:pointbound];
        }

    }
    //righttop
    if(status == 4
       && local_point.x - resizegap > pointbound.origin.x
       && local_point.y - resizegap > pointbound.origin.y)
    {
        pointbound.size.height += local_point.y - lastpoint.y;
        pointbound.size.width += local_point.x - lastpoint.x;
        lastpoint = local_point;
        if(background != nil)
        {
            [background setPointbound:pointbound];
        }
    }
    //rightbuttom
    if(status == 5
       && local_point.x - resizegap > pointbound.origin.x
       && local_point.y + resizegap < pointbound.origin.y + pointbound.size.height)
    {
        pointbound.origin.y += local_point.y - lastpoint.y;
        pointbound.size.height -= local_point.y - lastpoint.y;
        pointbound.size.width += local_point.x - lastpoint.x;
        lastpoint = local_point;
        if(background != nil)
        {
            [background setPointbound:pointbound];
        }
    }
    [self setNeedsDisplay:YES];
    
}

@end
