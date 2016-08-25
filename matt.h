//
//  matt.h
//  easybackgroundremove
//
//  Created by xusea on 15/11/15.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sharedmatting.h"
@interface matt : NSObject
{
    
}
+(void)buildmattimage:(NSString *)orgpic graypicname:(NSString *)graypic outputpicname:(NSString *)outputpic progressname:(int *)progress;

@end
