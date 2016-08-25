//
//  progresswindow.m
//  easybackgroundremove
//
//  Created by xusea on 15/11/21.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "progresswindow.h"

@implementation progresswindow
@synthesize pg =_pg ;
@synthesize window =_window;

- (id)initWithWindowNibName:(NSString *)windowNibName {
    self = [super init];
    if (self) {
        if (!_window)
        {
            [[NSBundle mainBundle] loadNibNamed:windowNibName owner:self topLevelObjects:nil];
        }
    }
    NSPoint p ;
    p.x = 0;
    p.y = 0;
    // [_window setFrameOrigin:p];
    return self;
}

- (id)init
{
    return [self initWithWindowNibName:@"progresswindow"];
}

-(NSInteger)runModal
{
    return [NSApp runModalForWindow:self.window];
}

@end
