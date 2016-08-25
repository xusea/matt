//
//  resizebound.h
//  easybackgroundremove
//
//  Created by xusea on 15/12/19.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "backgroundbound.h"
#import "util.h"
@interface resizebound : NSView
{
    NSImage * i;
    NSRect pointbound;
    NSRect imagebound;
    NSPoint lastpoint;
    float zoomfactor;
    NSSize cornersize;
    NSSize centersize;
    int status;
    backgroundbound * background;
    int resizegap;
}
@property(readwrite) NSImage * i;
@property(readwrite) NSRect pointbound;
@property(readwrite) NSRect imageboung;
@property(readwrite) NSPoint lastpoint;
@property(readwrite) float zoomfactor;
@property(readwrite) NSSize cornersize;
@property(readwrite) NSSize centersize;
@property(readwrite) int status;
@property(readwrite) backgroundbound * background;
@property(readwrite) int resizegap;
@end
