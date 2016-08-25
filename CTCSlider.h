//
//  CTCSlider.h
//  easybackgroundremove
//
//  Created by xusea on 15/12/2.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CTCSliderCell.h"

@interface CTCSlider : NSSlider
- (id)initWithKnobImage:(NSImage *)knob;

/*
 Return LADSlider with custom knob and tack
 isProgressType == NO
 If the one of the followings arguments is nil
 the method will return nil
 */
- (id)initWithKnobImage:(NSImage *)knob barFillImage:(NSImage *)barFill
        barLeftAgeImage:(NSImage *)barLeftAge andbarRightAgeImage:(NSImage *)barRightAge;

/*
 Return LADSlider with custom knob and bar
 isProgressType == YES
 If the one of the followings arguments is nil
 the method will return nil
 */
- (id)initWithKnobImage:(NSImage *)knob barFillImage:(NSImage *)barFill
 barFillBeforeKnobImage:(NSImage *)barFillBeforeKnob
        barLeftAgeImage:(NSImage *)barLeftAge barRightAgeImage:(NSImage *)barRightAge;


/*
 LADSliderCell properties
 you may find the description in
 LADSliderCell.h
 */

- (NSImage *)knobImage;
- (void)setKnobImage:(NSImage *)image;

- (NSImage *)barFillImage;
- (void)setBarFillImage:(NSImage *)image;

- (NSImage *)barFillBeforeKnobImage;
- (void)setBarFillBeforeKnobImage:(NSImage *)image;

- (NSImage *)barLeftAgeImage;
- (void)setBarLeftAgeImage:(NSImage *)image;

- (NSImage *)barRightAgeImage;
- (void)setBarRightAgeImage:(NSImage *)image;
@end
