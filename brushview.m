//
//  brushview.m
//  easybackgroundremove
//
//  Created by xusea on 15/11/13.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "brushview.h"
#import "BrushPoint.h"
/*@interface BrushPoint : NSObject
{
    NSPoint p;
    int t;
    int bsize;
    int inoutflag;
    int undoflag;
}

@property (readwrite) NSPoint p;
@property (readwrite) int t;
@property (readwrite) int bsize;
@property (readwrite) int inoutflag;
@property (readwrite) int undoflag;
@end

@implementation BrushPoint

@synthesize p;
@synthesize t;
@synthesize bsize;
@synthesize inoutflag;
@synthesize undoflag;
@end*/

@implementation brushview
@synthesize a;
@synthesize b;
@synthesize createpngflag;
@synthesize brushsize;
@synthesize validpath;
@synthesize allpath;
@synthesize brusht;
@synthesize croparea;
@synthesize imagesize;
@synthesize drawcolor;
@synthesize rawpath;
@synthesize rawgraypath;
@synthesize rawfillblackpath;
@synthesize croppath;
@synthesize pngfilepath;
@synthesize rawdpipath;
@synthesize hash_magic;
@synthesize candrawflag;
@synthesize orgdpi;
@synthesize zoomfactor;
@synthesize offsetx;
@synthesize offsety;
- (void) awakeFromNib{
    
    [super awakeFromNib];
    a = [[NSMutableArray alloc]init];
    b = [[NSMutableArray alloc]init];
    createpngflag = 0;
    brusht = 0;
    brushsize = 20;
    validpath = 0;
    allpath = 0;
    drawcolor = 0;
    croparea = [self bounds];
    hash_magic = @"qs3jdu83";
    NSString* dir = NSTemporaryDirectory();
    NSString* prefix = [dir stringByAppendingString:hash_magic];
    rawpath = [prefix stringByAppendingString:@"_rawpath.png"];
    rawgraypath = [prefix stringByAppendingString:@"_rawgraypath.png"];
    rawfillblackpath = [prefix stringByAppendingString:@"_rawfillblackpath.png"];
    croppath = [prefix stringByAppendingString:@"_croppath.png"];
    rawdpipath = [prefix stringByAppendingString:@"_rawdpipath.png"];
    pngfilepath = @"NONE";
    candrawflag = 0;
    orgdpi = 72.0f;
    //no use
    zoomfactor = 1;
    //  [self addSubview:cv];
}
- (id)initWithFrame:(NSRect)frame
{
    
    self = [super initWithFrame:frame];
    return self;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
   /* NSBezierPath * bp = [NSBezierPath bezierPathWithRect:[self bounds]];
    [[NSColor blueColor] set];
    [bp setLineWidth:2];
    [bp stroke];*/
    if([a count]>1 && validpath !=0)
    {
       // NSLog(@"%d", (int)[a count]);
        
        BrushPoint * bp = [a objectAtIndex:0];
        
        NSBezierPath *trace = [[NSBezierPath alloc]init];
        [trace setLineWidth:[bp bsize]];
        if([bp inoutflag] == 0)
        {
            if(drawcolor == 0)
            {
                NSColor * c = [NSColor greenColor];
                NSColor * cn = [c colorWithAlphaComponent:0.5];
                [cn set];
            }
            else
            {
                [[NSColor whiteColor] set];
            }
        }
        else
        {
            if(drawcolor == 0)
            {
                NSColor * c = [NSColor redColor];
                NSColor * cn = [c colorWithAlphaComponent:0.5];
                [cn set];
            }
            else
            {
                [[NSColor blackColor] set];
            }
        }
        [NSBezierPath setDefaultFlatness:0.5];
        [NSBezierPath setDefaultLineCapStyle: NSRoundLineCapStyle];
        [trace moveToPoint:[bp p]];
        for(int i = 1;i<[a count]; i ++)
        {
            bp = [a objectAtIndex:i];
            //NSLog(@"%f %f", [bp p].x,[bp p].y);
            if([bp t] == 0)
            {
                [trace setLineWidth:[bp bsize]];
                [trace lineToPoint:[bp p]];
            }
            else{
                [trace closePath];
                [trace stroke];
                if([bp undoflag] == 1)
                {
                    break;
                }
                trace = [[NSBezierPath alloc]init];
                [trace setLineWidth:[bp bsize]];
                [NSBezierPath setDefaultFlatness:0.5];
                [NSBezierPath setDefaultLineCapStyle: NSRoundLineCapStyle];
                if([bp inoutflag] == 0)
                {
                    if(drawcolor == 0)
                    {
                        NSColor * c = [NSColor greenColor];
                        NSColor * cn = [c colorWithAlphaComponent:0.5];
                        [cn set];
                    }
                    else
                    {
                        [[NSColor whiteColor] set];
                    }
                }
                else
                {
                    if(drawcolor == 0)
                    {
                        NSColor * c = [NSColor redColor];
                        NSColor * cn = [c colorWithAlphaComponent:0.5];
                        [cn set];
                    }
                    else
                    {
                        [[NSColor blackColor] set];
                    }
                }
            }
            [trace moveToPoint: [bp p]];
        }
        [trace closePath];
        [trace stroke];
    }
    /////
    float left = 0.0;
    float right = [self frame].size.width / zoomfactor;
    float buttom = 0.0;
    float top = [self frame].size.height / zoomfactor;
    /*left = ([self frame].size.width / zoomfactor- croparea.size.width ) / 2;
     right = ([self frame].size.width / zoomfactor- croparea.size.width ) / 2 + croparea.size.width;
     
     buttom = ([self frame].size.height/zoomfactor - croparea.size.height ) / 2;
     top = ([self frame].size.height /zoomfactor- croparea.size.height ) / 2 + croparea.size.height;*/
    left = ([self frame].size.width - croparea.size.width ) / 2;
    right = ([self frame].size.width - croparea.size.width ) / 2 + croparea.size.width;
    
    buttom = ([self frame].size.height - croparea.size.height ) / 2;
    top = ([self frame].size.height - croparea.size.height ) / 2 + croparea.size.height;
    
    NSImage * bordermark = [NSImage imageNamed:@"rightbuttom.png"];
    
    // top
    [bordermark drawInRect:NSMakeRect(0, top, [self frame].size.width, [self frame].size.height - top)];
    
    // buttom
    [bordermark drawInRect:NSMakeRect(0, 0, [self frame].size.width, buttom)];
    
    // left
    [bordermark drawInRect:NSMakeRect(0, 0, left, [self frame].size.height)];
    
    // right
    [bordermark drawInRect:NSMakeRect(right, 0, [self frame].size.width - right,[self frame].size.height)];
    
}
- (void)mouseDown:(NSEvent *)theEvent
{
    if(candrawflag == 0)
    {
        return;
    }
    NSRect locat;
    locat.origin = [theEvent locationInWindow];
    
    NSPoint local_point = [self convertPoint:locat.origin fromView:nil];
    NSLog(@"local point %f %f", local_point.x, local_point.y);
    if([self checkincroparea:local_point] == FALSE)
    {
        NSLog(@"not in croparea %f %f", local_point.x, local_point.y);
        return ;
    }
    //locat.origin.x -= [self frame].origin.x;
    //locat.origin.y -= [self frame].origin.y;
    
    //locat.origin.x -=  offsetx * zoomfactor;
    //locat.origin.y -=  offsety * zoomfactor;
    
    locat.origin.x = (locat.origin.x - offsetx) / zoomfactor;
    locat.origin.y = (locat.origin.y - offsety) / zoomfactor;
    NSLog(@"click position %f %f", locat.origin.x, locat.origin.y);

    NSRange range;
    range.length = 0;
    for(int i = 0;i<[a count] ;i++)
    {
        BrushPoint * bp = [a objectAtIndex:i];
        if([bp t] == 1 && [bp undoflag] == 1)
        {
            range.location = i;
            range.length = [a count] - i;
            break;
        }
    }
    if(range.length > 0)
    {
        [a removeObjectsInRange:range];
    }
    BrushPoint * bp = [[BrushPoint alloc]init];
    //[bp setP:locat.origin];
    [bp setP:local_point];
    [bp setT:1];
    [bp setBsize:[self brushsize]];
    [bp setUndoflag:0];
    [bp setInoutflag:brusht];
    [a addObject:bp];
    validpath ++;
    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    if(candrawflag == 0)
    {
        return;
    }
    NSRect locat;
    locat.origin = [theEvent locationInWindow];
    NSPoint local_point = [self convertPoint:locat.origin fromView:nil];
    if([self checkincroparea:local_point] == FALSE)
    {
        NSLog(@"not in croparea %f %f", local_point.x, local_point.y);
        return ;
    }

    //locat.origin.x -= [self frame].origin.x;
    //locat.origin.y -= [self frame].origin.y;
    locat.origin.x = (locat.origin.x - offsetx) / zoomfactor;
    locat.origin.y = (locat.origin.y - offsety) / zoomfactor;
    BrushPoint * bp = [[BrushPoint alloc]init];
    //[bp setP:locat.origin];
    [bp setP:local_point];
    [bp setT:0];
    [bp setUndoflag:0];
    [bp setBsize:[self brushsize]];

    [bp setInoutflag:brusht];
    [a addObject:bp];
    [self setNeedsDisplay:YES];
    
}

- (void)mouseUp:(NSEvent *)theEvent
{
    
    NSRect locat;
    locat.origin = [theEvent locationInWindow];
    locat.origin.x -= [self frame].origin.x;
    locat.origin.y -= [self frame].origin.y;
   // NSLog(@"location %f %f", [self frame].origin.x, [self frame].origin.y);
   // NSLog(@"click %f %f", [theEvent locationInWindow].x, [theEvent locationInWindow].y);
   
}
- (void)createpng
{
    //float zoomfactor = 2;
 /*   NSRect frame = [self frame];
    [self scaleUnitSquareToSize:NSMakeSize(1/zoomfactor, 1/zoomfactor)];
    [self setFrame:NSMakeRect(0, 0, rectwidth , rectheight)];*/
    
    NSBitmapImageRep* rep = [self bitmapImageRepForCachingDisplayInRect:[self bounds]];
    NSRect bounds = [self bounds];
    NSLog(@"raw png %f %f", bounds.size.width, bounds.size.height);
    [self cacheDisplayInRect:[self bounds] toBitmapImageRep:rep];
    
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    NSData* data = [rep representationUsingType:NSPNGFileType properties:imageProps];
    
    
    [data writeToFile:rawpath atomically:YES];
    [NSGraphicsContext restoreGraphicsState];
    
    
    
 /*   [self scaleUnitSquareToSize:NSMakeSize(zoomfactor, zoomfactor)];
    [self setFrame:NSMakeRect(frame.origin.x, frame.origin.y, rectwidth * zoomfactor, rectheight * zoomfactor)];*/
}
- (void)debug
{
    NSRect orgframe = [self frame];
    createpngflag = 1;
    drawcolor = 1;
    [self setNeedsDisplay:YES];
    [self createpng];
    [self setFrame:orgframe];
    drawcolor = 0;
    dispatch_async( dispatch_get_main_queue(), ^{
        [self setNeedsDisplay:YES];
    } );
}
- (void)buildpng
{
    NSLog(@"call textview createwatermakimage");
    NSRect orgframe = [self frame];
    createpngflag = 1;
    drawcolor = 1;
    [self setNeedsDisplay:YES];
    [self createpng];
    [self setFrame:orgframe];
    drawcolor = 0;
    dispatch_async( dispatch_get_main_queue(), ^{
        [self setNeedsDisplay:YES];
    } );
    NSString *pth1 = rawpath;
    NSString *path2 = rawfillblackpath;
    NSString *path = rawgraypath;
    NSString *path3 = croppath;
    NSString *path4 = rawdpipath;
    NSString *path5 = pngfilepath;
    
    //step 1 fillblack from rawpath to rawfillblackpath
    NSImage * image_raw = [[NSImage alloc]initByReferencingFile:rawpath];
    int width = [image_raw size].width;
    int height = [image_raw size].height;
    NSBitmapImageRep *rep_raw = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes: NULL
                                 pixelsWide: width
                                 pixelsHigh: height
                                 bitsPerSample: 8
                                 samplesPerPixel: 4
                                 hasAlpha: YES
                                 isPlanar: NO
                                 colorSpaceName: NSDeviceRGBColorSpace
                                 bytesPerRow: width * 4
                                 bitsPerPixel: 32];

    NSGraphicsContext *ctx_raw = [NSGraphicsContext graphicsContextWithBitmapImageRep: rep_raw];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctx_raw];
    [image_raw drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctx_raw flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    unsigned char * rep_bitmapdata = [rep_raw bitmapData];
    NSUInteger rep_bitmapdata_BytesPerRow = [rep_raw bytesPerRow];
    NSColor *fillcolor = [[NSColor redColor] colorWithAlphaComponent:0.1];
    //1.spread round
    for(int i = 0 ;i< width; i ++)
    {
        for(int j = 0; j< height; j ++)
        {
            unsigned char *pixel = rep_bitmapdata + ((i * 4) + (j * rep_bitmapdata_BytesPerRow));
            u_int sr, sg, sb, sa;
            sr = (u_int)*pixel;
            sg = (u_int)*(pixel + 1);
            sb = (u_int)*(pixel + 2);
            sa = (u_int)*(pixel + 3);
            float factor = 255.0f / sa;
            if( (float)sr / (float)sa < 0.1
               && (float)sg / (float)sa < 0.1
               && (float)sb / (float)sa < 0.1
               && sa > 255.0f * 0.5)
            {
                int flag = 0;
                if(i<width /4)
                {
                    for(int k = 0;k < i ;k++)
                    {
                        
                        unsigned char *pixel = rep_bitmapdata + ((k * 4) + (j * rep_bitmapdata_BytesPerRow));
                        u_int sr, sg, sb, sa;
                        sr = (u_int)*pixel;
                        sg = (u_int)*(pixel + 1);
                        sb = (u_int)*(pixel + 2);
                        sa = (u_int)*(pixel + 3);
                        
                        if(sa > 255.0f * 0.5)
                        {
                            flag = 1;
                            break;
                        }
                    }
                    if(flag == 0 && i<width/4)
                    {
                        for(int k = 0;k < i ;k++)
                        {
                            [rep_raw setColor:fillcolor atX:k y:j];
                        }
                    }
                }
                //(i+1,j),(i+2,j)...(width-1,j)
                
                if(i>3*width/4)
                {
                    flag = 0;
                    for(int k = i+1;k < width ;k++)
                    {
                        unsigned char *pixel = rep_bitmapdata + ((k * 4) + (j * rep_bitmapdata_BytesPerRow));
                        u_int sr, sg, sb, sa;
                        sr = (u_int)*pixel;
                        sg = (u_int)*(pixel + 1);
                        sb = (u_int)*(pixel + 2);
                        sa = (u_int)*(pixel + 3);
                        
                        if(sa > 255.0f * 0.5)
                        {
                            flag = 1;
                            break;
                        }
                    }
                    if(flag == 0 && i> 3*width/4)
                    {
                        for(int k = i+1;k < width ;k++)
                        {
                            [rep_raw setColor:fillcolor atX:k y:j];
                        }
                    }
                }
            }
        }
    }
    //2.top bottom left right to center
    //a top to bottom
    for(int i = 0; i < width ;i++)
    {
        int flag = 0;
        for(int j = 0 ;j < height ; j++)
        {
            unsigned char *pixel = rep_bitmapdata + ((i * 4) + (j * rep_bitmapdata_BytesPerRow));
            u_int sr, sg, sb, sa;
            sr = (u_int)*pixel;
            sg = (u_int)*(pixel + 1);
            sb = (u_int)*(pixel + 2);
            sa = (u_int)*(pixel + 3);
            if(sa > 255.0f * 0.5)
            {
                flag = 1;
                break;
            }
        }
        if(flag == 1)
        {
            break;
        }
        for(int j = 0 ;j < height ; j++)
        {
            [rep_raw setColor:fillcolor atX:i y:j];
        }
    }
    
    for(int i = width; i > 0 ;i--)
    {
        int flag = 0;
        for(int j = 0 ;j < height ; j++)
        {
            unsigned char *pixel = rep_bitmapdata + ((i * 4) + (j * rep_bitmapdata_BytesPerRow));
            u_int sr, sg, sb, sa;
            sr = (u_int)*pixel;
            sg = (u_int)*(pixel + 1);
            sb = (u_int)*(pixel + 2);
            sa = (u_int)*(pixel + 3);
            if(sa > 255.0f * 0.5)
            {
                flag = 1;
                break;
            }
        }
        if(flag == 1)
        {
            break;
        }
        for(int j = 0 ;j < height ; j++)
        {
            [rep_raw setColor:fillcolor atX:i y:j];
        }
    }
    /*
    for(int j = 0; j<height;j++)
    {
        int flag = 0;
        for(int i = 0 ;i<width ; i++)
        {
            NSColor * color = [rep_raw colorAtX:i y:j];
            CGFloat red = 0.0;
            CGFloat green = 0.0;
            CGFloat blue = 0.0;
            CGFloat alpha = 0.0;
            [color getRed:&red green:&green blue:&blue alpha:&alpha];
            NSColor * f = [rep_raw colorAtX:i y:j];
            if((float)alpha > 0.5)
            {
                flag = 1;
                break;
            }
        }
        if(flag == 1)
        {
            break;
        }
        for(int i = 0 ;i < width ; i++)
        {
            [rep_raw setColor:fillcolor atX:i y:j];
        }
    }
    
    
    for(int j = height-1; j>-1;j--)
    {
        int flag = 0;
        for(int i = 0 ;i<width ; i++)
        {
            NSColor * color = [rep_raw colorAtX:i y:j];
            CGFloat red = 0.0;
            CGFloat green = 0.0;
            CGFloat blue = 0.0;
            CGFloat alpha = 0.0;
            [color getRed:&red green:&green blue:&blue alpha:&alpha];
            NSColor * f = [rep_raw colorAtX:i y:j];
            if((float)alpha > 0.5)
            {
                flag = 1;
                break;
            }
        }
        if(flag == 1)
        {
            break;
        }
        for(int i = 0 ;i < width ; i++)
        {
            [rep_raw setColor:fillcolor atX:i y:j];
        }
    }
*/
    
    NSColor * fillblack = [NSColor colorWithCalibratedRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    NSLog(@"%@ |||| %@", fillcolor, fillblack);
    
    for(int i = 0 ;i< width; i ++)
    {
        for(int j = 0; j< height; j ++)
        {
            unsigned char *pixel = rep_bitmapdata + ((i * 4) + (j * rep_bitmapdata_BytesPerRow));
            u_int sr, sg, sb, sa;
            sr = (u_int)*pixel;
            sg = (u_int)*(pixel + 1);
            sb = (u_int)*(pixel + 2);
            sa = (u_int)*(pixel + 3);
            float factor = 255.0f / sa;
            if( (float)sr / (float)sa > 0.1
               && (float)sg / (float)sa < 0.1
               && (float)sb / (float)sa < 0.1
               && sa < 255.0f * 0.5)
            {
                [rep_raw setColor:fillblack atX:i y:j];
            }
        }
    }
    
    
    NSData * imageData1 = [rep_raw representationUsingType:NSPNGFileType properties:nil];
    [imageData1 writeToFile:path2 atomically:YES];

    
    //step 2 resize
    
    //NSImage * srcImage = [[NSImage alloc] initWithContentsOfFile:pth1];
    NSImage * srcImage = [[NSImage alloc] initWithContentsOfFile:path2];
    
    NSImage *newImage = [[NSImage alloc] initWithSize:[srcImage size]];
    [newImage lockFocus];
    [[NSColor grayColor] set];
    NSRectFill(NSMakeRect(0,0,[newImage size].width, [newImage size].height));
    //[srcImage compositeToPoint:NSZeroPoint operation:NSCompositeCopy];
    [srcImage drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0,0,[newImage size].width, [newImage size].height) operation:NSCompositeSourceOver fraction:1.0];
    [newImage unlockFocus];
    
    [[newImage TIFFRepresentation] writeToFile:path atomically:YES];
    
    
    NSImage *target = [[NSImage alloc]initWithSize:croparea.size];
    NSRect desrect ;
    desrect.size = croparea.size;
    desrect.origin.x = desrect.origin.y = 0;
    [target lockFocus];
    [newImage drawInRect:desrect fromRect:croparea operation:NSCompositeCopy fraction:1.0];
    [target unlockFocus];
    [[target TIFFRepresentation] writeToFile:path3 atomically:YES];
    
    
    NSImage *sourceImage = target;
    [sourceImage setScalesWhenResized:YES];
    
    // Report an error if the source isn't a valid image
    if (![sourceImage isValid]){
        NSLog(@"Invalid Image");
    } else {
        NSImage * orgimage = [[NSImage alloc] initWithSize: imagesize];
        [orgimage lockFocus];
        [sourceImage setSize: imagesize];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [sourceImage drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, imagesize.width, imagesize.height) operation:NSCompositeCopy fraction:1.0];
        [orgimage unlockFocus];
        [[orgimage TIFFRepresentation] writeToFile:path5 atomically:YES];
        //return smallImage;
    }
    
   /* {
        NSImage * image_dpi = [[NSImage alloc]initByReferencingFile:path4];
        int width = [image_dpi size].width;
        int height = [image_dpi size].height;
        
        NSImageRep * imagerep = [NSImageRep imageRepWithContentsOfFile:path4];
        
        float dpi = ceilf((72.0f * [imagerep pixelsWide])/[image_dpi size].width);
        width *= dpi / 72.0f;
        height *= dpi / 72.0f;
      
        if(width < 1 || height < 1)
            return ;
        
        NSBitmapImageRep *rep_dpi = [[NSBitmapImageRep alloc]
                                     initWithBitmapDataPlanes: NULL
                                     pixelsWide: width
                                     pixelsHigh: height
                                     bitsPerSample: 8
                                     samplesPerPixel: 4
                                     hasAlpha: YES
                                     isPlanar: NO
                                     colorSpaceName: NSDeviceRGBColorSpace
                                     bytesPerRow: width * 4
                                     bitsPerPixel: 32];
        
        NSGraphicsContext *ctx_dpi = [NSGraphicsContext graphicsContextWithBitmapImageRep: rep_dpi];
        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext: ctx_dpi];
        [image_dpi drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
        [ctx_dpi flushGraphics];
        [NSGraphicsContext restoreGraphicsState];
        
        NSSize pointsSize = rep_dpi.size;
        NSSize pixelSize = NSMakeSize(rep_dpi.pixelsWide, rep_dpi.pixelsHigh);
        
        CGFloat currentDPI = ceilf((72.0f * pixelSize.width)/pointsSize.width);
        NSLog(@"current DPI %f", currentDPI);
        
        NSSize updatedPointsSize = pointsSize;
        
        //updatedPointsSize.width = ceilf(pixelSize.width) * dpi / orgdpi;
        //updatedPointsSize.height = ceilf(pixelSize.height) * dpi / orgdpi;
        if(dpi > 100.0)
        {
            updatedPointsSize.width = ceilf(pixelSize.width) * 2;
            updatedPointsSize.height = ceilf(pixelSize.height) * 2;
        }
        else
        {
            updatedPointsSize.width = ceilf(pixelSize.width);
            updatedPointsSize.height = ceilf(pixelSize.height);
            
        }
        //updatedPointsSize.width = ceilf((72.0f * pixelSize.width)/dpi);
        //updatedPointsSize.height = ceilf((72.0f * pixelSize.height)/dpi);
        
        [rep_dpi setSize:updatedPointsSize];
        
        NSData *data = [rep_dpi representationUsingType: NSPNGFileType properties: nil];
        [data writeToFile: path5 atomically: YES];
    }*/
}

-(void)removepath
{
    [a removeAllObjects];
    [b removeAllObjects];
    validpath = 0;
   // allpath= 0;
    [self setNeedsDisplay:YES];
}

- (void)undo
{
    for(int i = (int)[a count] - 1; i > -1 ; i--)
    {
        BrushPoint* bp = [a objectAtIndex:i];
        if([bp t] == 1 && [bp undoflag] == 0)
        {
            [bp setUndoflag:1];
            [a replaceObjectAtIndex:i withObject:bp];
            validpath --;
            break;
        }
    }
    [self setNeedsDisplay:YES];
}
- (void)redo
{
    for(int i = 0; i< (int)[a count]; i ++)
    {
        BrushPoint* bp = [a objectAtIndex:i];
        if([bp t] == 1 && [bp undoflag] == 1)
        {
            [bp setUndoflag:0];
            [a replaceObjectAtIndex:i withObject:bp];
            validpath ++;
            break;
        }
    }
    [self setNeedsDisplay:YES];
}

- (NSSize)intrinsicContentSize
{
    return NSMakeSize(rectwidth,rectheight);
}

- (void)setOffsetX:(int) px OffsetY:(int) py
{
    offsetx = px;
    offsety = py;
    return ;
   /* posx = px;
    posy = py;
    NSLog(@"set off set %f %f %d %d" , [self frame].origin.x, [self frame].origin.y, px, py);
    NSRect frame = [self frame];
    frame.origin.x -= px;
    frame.origin.y -= py;
    [self setFrame:frame];
    //[self setNeedsDisplay:YES];*/
}

- (bool)checkincroparea:(NSPoint) pos
{
    return TRUE;
    
    float left = 0.0;
    float right = [self frame].size.width / zoomfactor;
    float buttom = 0.0;
    float top = [self frame].size.height / zoomfactor;
    /*left = ([self frame].size.width / zoomfactor- croparea.size.width ) / 2;
    right = ([self frame].size.width / zoomfactor- croparea.size.width ) / 2 + croparea.size.width;
    
    buttom = ([self frame].size.height/zoomfactor - croparea.size.height ) / 2;
    top = ([self frame].size.height /zoomfactor- croparea.size.height ) / 2 + croparea.size.height;*/
    left = ([self frame].size.width - croparea.size.width ) / 2;
    right = ([self frame].size.width - croparea.size.width ) / 2 + croparea.size.width;
    
    buttom = ([self frame].size.height - croparea.size.height ) / 2;
    top = ([self frame].size.height - croparea.size.height ) / 2 + croparea.size.height;
    if( pos.x - brushsize / 2 < left || pos.x + brushsize / 2 > right || pos.y - brushsize / 2 < buttom || pos.y + brushsize / 2  > top)
    {
        return FALSE;
    }
    return TRUE;
}
@end
