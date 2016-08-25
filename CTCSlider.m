//
//  CTCSlider.m
//  easybackgroundremove
//
//  Created by xusea on 15/12/2.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "CTCSlider.h"

@implementation CTCSlider

/*- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}*/
- (void)setNeedsDisplayInRect:(NSRect)invalidRect {
    [super setNeedsDisplayInRect:[self bounds]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if( ![self.cell isKindOfClass:[CTCSliderCell class]] ) {
        //Set our LADSlider.cell to CTCSliderCell
        CTCSliderCell *cell = [[CTCSliderCell alloc] init];
        [self setCell:cell];
    }
}

- (id)initWithKnobImage:(NSImage *)knob {
    self = [super init];
    
    if( self ) {
        [self setCell:[[CTCSliderCell alloc] initWithKnobImage:knob]];
        
        //      If the cell is nil we return nil
        return nil == self.cell ? nil : self;
    }
    
    return self;
}

- (id)initWithKnobImage:(NSImage *)knob barFillImage:(NSImage *)barFill
        barLeftAgeImage:(NSImage *)barLeftAge andbarRightAgeImage:(NSImage *)barRightAge {
    self = [super init];
    
    if( self ) {
        [self setCell:[[CTCSliderCell alloc] initWithKnobImage:knob barFillImage:barFill
                                               barLeftAgeImage:barLeftAge andbarRightAgeImage:barRightAge]];
        
        //      If the cell is nil we return nil
        return nil == self.cell ? nil : self;
    }
    
    return self;
}

- (id)initWithKnobImage:(NSImage *)knob barFillImage:(NSImage *)barFill
 barFillBeforeKnobImage:(NSImage *)barFillBeforeKnob
        barLeftAgeImage:(NSImage *)barLeftAge barRightAgeImage:(NSImage *)barRightAge {
    self = [super init];
    
    if( self ) {
        [self setCell:[[CTCSliderCell alloc] initWithKnobImage:knob barFillImage:barFill
                                        barFillBeforeKnobImage:barFillBeforeKnob
                                               barLeftAgeImage:barLeftAge barRightAgeImage:barRightAge]];
        
        //      If the cell is nil we return nil
        return nil == self.cell ? nil : self;
    }
    
    return self;
}

/*
 Also need to throw on some
 CTCSliderCell setters and getters
 */
- (NSImage *)knobImage {
    return ((CTCSliderCell *) self.cell).knobImage;
}

- (void)setKnobImage:(NSImage *)image {
    ((CTCSliderCell *) self.cell).knobImage = image;
}

- (NSImage *)barFillImage {
    return ((CTCSliderCell *) self.cell).barFillImage;
}

- (void)setBarFillImage:(NSImage *)image {
    ((CTCSliderCell *) self.cell).barFillImage = image;
}

- (NSImage *)barFillBeforeKnobImage {
    return ((CTCSliderCell *) self.cell).barFillBeforeKnobImage;
}

- (void)setBarFillBeforeKnobImage:(NSImage *)image {
    ((CTCSliderCell *) self.cell).barFillBeforeKnobImage = image;
}

- (NSImage *)barLeftAgeImage {
    return ((CTCSliderCell *) self.cell).barLeftAgeImage;
}

- (void)setBarLeftAgeImage:(NSImage *)image {
    ((CTCSliderCell *) self.cell).barLeftAgeImage = image;
}

- (NSImage *)barRightAgeImage {
    return ((CTCSliderCell *) self.cell).barRightAgeImage;
}

- (void)setBarRightAgeImage:(NSImage *)image {
    ((CTCSliderCell *) self.cell).barRightAgeImage = image;
}

@end
