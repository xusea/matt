//
//  backgroundbound.h
//  easybackgroundremove
//
//  Created by xusea on 15/12/20.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface backgroundbound : NSView
{
    NSImage * i;
    NSRect pointbound;
    int bgtype;
}
@property(readwrite) NSImage * i;
@property(readwrite) NSRect pointbound;
@property(readwrite) int bgtype;
@end
