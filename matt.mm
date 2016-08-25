//
//  matt.m
//  easybackgroundremove
//
//  Created by xusea on 15/11/15.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "matt.h"
extern void buildmattimage(const char * orgpic , const char * graypic ,const char * outputpic, int * progress);
@implementation matt

+(void)buildmattimage:(NSString *)orgpic graypicname:(NSString *)graypic outputpicname:(NSString *)outputpic progressname:(int *)progress
{
    buildmattimage([orgpic UTF8String], [graypic UTF8String], [outputpic UTF8String], progress);
    
    return ;
}
@end
