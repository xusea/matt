//
//  SynchroScrollView.m
//  easybackgroundremove
//
//  Created by xusea on 15/12/16.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "SynchroScrollView.h"
#import <objc/objc-class.h>
#import "RFOverlayScroller.h"
@implementation SynchroScrollView

@synthesize viewname;
@synthesize zoomflag;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if([self hasVerticalScroller] && [self hasHorizontalScroller]){
        NSRect vframe = [[self verticalScroller]frame];
        NSRect hframe = [[self horizontalScroller]frame];
        NSRect corner;
        corner.origin.x = NSMaxX(hframe);
        corner.origin.y = NSMinY(hframe);
        corner.size.width = NSWidth(vframe);
        corner.size.height = NSHeight(hframe);
        
        // your custom drawing in the corner rect here
        //[[NSColor redColor] set];
        //NSRectFill(corner);
        NSImage * rightbottom = [NSImage imageNamed:@"rightbuttom.png"];
        [rightbottom drawInRect:corner];
    }
}
- (void)setSynchronizedScrollView:(NSScrollView*)scrollview
{
    NSView *synchronizedContentView;
    
    // stop an existing scroll view synchronizing
    [self stopSynchronizing];
    
    synchronizedScrollView = scrollview;
    
    // get the content view of the
    synchronizedContentView=[synchronizedScrollView contentView];
    
    [synchronizedContentView setPostsBoundsChangedNotifications:YES];
    
    // a register for those notifications on the synchronized content view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(synchronizedViewContentBoundsDidChange:)
                                                 name:NSViewBoundsDidChangeNotification
                                               object:synchronizedContentView];
}

- (void)synchronizedViewContentBoundsDidChange:(NSNotification *)notification
{
  
    NSClipView *changedContentView=[notification object];
    
    if([self zoomflag] == 0)
    {
        return ;
    }
    
    NSPoint changedBoundsOrigin = [changedContentView bounds].origin;;
    
    // get our current origin
    NSPoint curOffset = [[self contentView] bounds].origin;
    NSPoint newOffset = curOffset;
    
    // scrolling is synchronized in the vertical plane
    // so only modify the y component of the offset
    newOffset.y = changedBoundsOrigin.y;
    newOffset.x = changedBoundsOrigin.x;
    // if our synced position is different from our current
    // position, reposition our content view
    if (!NSEqualPoints(curOffset, changedBoundsOrigin))
    {
        // note that a scroll view watching this one will
        // get notified here
        [[self contentView] scrollToPoint:newOffset];
        // we have to tell the NSScrollView to update its
        // scrollers
        [self reflectScrolledClipView:[self contentView]];
      /*  if(resultview != nil)
        {
            [[resultview contentView] scrollToPoint:newOffset];
            [resultview reflectScrolledClipView:[resultview contentView]];
            
            [[bgview contentView] scrollToPoint:newOffset ];
            [bgview reflectScrolledClipView:[bgview contentView]];
        }*/
    }
}

- (void)stopSynchronizing
{
    if (synchronizedScrollView != nil) {
        NSView* synchronizedContentView = [synchronizedScrollView contentView];
        
        // remove any existing notification registration
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:NSViewBoundsDidChangeNotification
                                                      object:synchronizedContentView];
        
        // set synchronizedScrollView to nil
        synchronizedScrollView=nil;
    }
}

- (void)setSyncbrushview:(brushview *)bv
{
    syncbrush = bv;
}

- (void)setresv:(NSScrollView *)res
{
    resultview = res;
}

- (void)setbv:(NSScrollView *)bg
{
    bgview = bg;
}
/////////////////////////////////
/*static NSComparisonResult scrollerAboveSiblingViewsComparator(NSView *view1, NSView *view2, void *context)
{
    if ([view1 isKindOfClass:[RFOverlayScroller class]]) {
        return NSOrderedDescending;
    } else if ([view2 isKindOfClass:[RFOverlayScroller class]]) {
        return NSOrderedAscending;
    }
    
    return NSOrderedSame;
}

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        self.wantsLayer = YES;
        _headerOffset = [self tableHeaderOffsetFromSuperview];
    }
    return self;
}

- (void)awakeFromNib
{
    self.wantsLayer = YES;
    _headerOffset = [self tableHeaderOffsetFromSuperview];
}

- (void)tile
{
    // Fake zero scroller width so the contentView gets drawn to the edge
    method_exchangeImplementations(class_getClassMethod([RFOverlayScroller class], @selector(scrollerWidthForControlSize:scrollerStyle:)),
                                   class_getClassMethod([RFOverlayScroller class], @selector(zeroWidth)));
    [super tile];
    // Restore original scroller width
    method_exchangeImplementations(class_getClassMethod([RFOverlayScroller class], @selector(scrollerWidthForControlSize:scrollerStyle:)),
                                   class_getClassMethod([RFOverlayScroller class], @selector(zeroWidth)));
    
    // Resize vertical scroller
    CGFloat width = [RFOverlayScroller scrollerWidthForControlSize:self.verticalScroller.controlSize
                                                     scrollerStyle:self.verticalScroller.scrollerStyle];
    [self.verticalScroller setFrame:(NSRect){
        self.bounds.size.width - width,
        self.headerOffset,
        width,
        self.bounds.size.height - self.headerOffset
    }];
    
    //[self.horizontalScroller setFrame:(NSRect){0,0,self.bounds.size.height,width}];
    
    // Move scroller to front
    [self sortSubviewsUsingFunction:scrollerAboveSiblingViewsComparator
                            context:NULL];
}

- (NSInteger)tableHeaderOffsetFromSuperview
{
    for (NSView *subView in [self subviews])
    {
        if ([subView isKindOfClass:[NSClipView class]])
        {
            for (NSView *subView2 in [subView subviews])
            {
                if ([subView2 isKindOfClass:[NSTableView class]])
                {
                    return [(NSTableView *)subView2 headerView].frame.size.height;
                }
            }
        }
    }
    return 0;
}*/

@end
