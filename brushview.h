//
//  brushview.h
//  easybackgroundremove
//
//  Created by xusea on 15/11/13.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "util.h"
@interface brushview : NSView
{
    NSMutableArray * a;
    NSMutableArray * b;
    int createpngflag;
    int brushsize;
    int brusht;
    NSRect croparea;
    NSSize imagesize;
    NSString * rawpath;
    NSString * rawfillblackpath;
    NSString * rawgraypath;
    NSString * croppath;
    NSString * pngfilepath;
    NSString * rawdpipath;
    NSString * hash_magic;
    int validpath;
    int allpath;
    int drawcolor;
    int candrawflag;
    float orgdpi;
    float zoomfactor;
    float offsetx;
    float offsety;
}

@property(readwrite) NSMutableArray *a;
@property(readwrite) NSMutableArray *b;
@property(readwrite) int createpngflag;
@property(readwrite) int brushsize;
@property(readwrite) int brusht;
@property(readwrite) int validpath;
@property(readwrite) int allpath;
@property(readwrite) int drawcolor;
@property(readwrite) NSRect croparea;
@property(readwrite) NSSize imagesize;
@property(readwrite) NSString * rawpath;
@property(readwrite) NSString * rawfillblackpath;
@property(readwrite) NSString * rawgraypath;
@property(readwrite) NSString * croppath;
@property(readwrite) NSString * pngfilepath;
@property(readwrite) NSString * rawdpipath;
@property(readwrite) NSString * hash_magic;
@property(readwrite) int candrawflag;
@property(readwrite) float orgdpi;
@property(readwrite) float zoomfactor;
@property(readwrite) float offsetx;
@property(readwrite) float offsety;
- (void)buildpng;
- (void)createpng;
- (void)removepath;
- (void)undo;
- (void)redo;
- (void)setOffsetX:(int) px OffsetY:(int) py;
- (void)debug;
- (bool)checkincroparea:(NSPoint) pos;
@end
