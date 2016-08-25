//
//  progresswindow.h
//  easybackgroundremove
//
//  Created by xusea on 15/11/21.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
@interface progresswindow : NSObject
{
    NSProgressIndicator __unsafe_unretained * _pg;
    NSWindow __unsafe_unretained    * _window;
}
//@property(assign) NSWindow *_window
//@property(readwrite) NSProgressIndicator * pg;
//@property(readwrite) NSWindow * window;
//@property(assign) IBOutlet NSProgressIndicator *pg;
@property (assign) IBOutlet  NSWindow *window;
@property(assign) IBOutlet NSProgressIndicator *pg;

-(NSInteger)runModal;
@end
