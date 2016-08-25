//
//  SynchroScrollView.h
//  easybackgroundremove
//
//  Created by xusea on 15/12/16.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RFOverlayScroller.h"
#import "brushview.h"
#import "TCScroller.h"
@interface SynchroScrollView : NSScrollView{
    // SynchroScrollView* synchronizedScrollView; // not retained
    NSScrollView* synchronizedScrollView; // not retained
    NSString * viewname;
    brushview * syncbrush;
    int zoomflag;
    NSScrollView * resultview;
    NSScrollView * bgview;
}
@property (nonatomic, assign) NSInteger headerOffset;
@property (readwrite) NSString * viewname;
@property (readwrite) int zoomflag;

//@property (readwrite) brushview * syncbrush;
- (void)setSynchronizedScrollView:(NSScrollView*)scrollview;
- (void)stopSynchronizing;
- (void)synchronizedViewContentBoundsDidChange:(NSNotification *)notification;
- (void)setSyncbrushview:(brushview *)bv;
- (void)setresv:(NSScrollView *)res;
- (void)setbv:(NSScrollView *)bg;

@end
