//
//  AppDelegate.m
//  easybackgroundremove
//
//  Created by xusea on 15/11/13.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
@synthesize imagepath;
@synthesize pngfilepath;
@synthesize pngresultfilepath;
@synthesize pngresultfileimerodepath;
@synthesize resultfilepath;
@synthesize resultbgfilepath;
@synthesize hash_magic;
@synthesize pw;
@synthesize flag;
@synthesize g_progress;
@synthesize maxarea;
@synthesize areaset;
@synthesize posx;
@synthesize posy;
@synthesize showid;
@synthesize imagemap;
@synthesize dpi;
@synthesize modelRect;
@synthesize leftRect;
@synthesize rightRect;
//@synthesize _showorg;
//@synthesize _showresult;
//@synthesize _showbg;
@synthesize zoomFactor;
@synthesize maxzoomFactor;
@synthesize brushframe;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [_window setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"backg.png"]]];
    /*
     @property (weak) IBOutlet NSButton *showopen;
     @property (weak) IBOutlet NSButton *showsave;
     @property (weak) IBOutlet NSButton *showout;
     @property (weak) IBOutlet NSButton *showin;
     @property (weak) IBOutlet NSButton *showclear;
     @property (weak) IBOutlet NSSlider *showchangesize;
     @property (weak) IBOutlet NSButton *showundo;
     @property (weak) IBOutlet NSButton *showredo;
     @property (weak) IBOutlet NSButton *showmatting;
     */
    [_scrollbgview setAutohidesScrollers:FALSE];
    [_scrollbrushview setAutohidesScrollers:FALSE];
    //[_scrollbrushview setBackgroundColor:[NSColor blueColor]];
    
    zoomFactor = g_zoomfactor;
    maxzoomFactor = 10;
    curzoomFactor = 1;
    _showbsize.knobImage = [NSImage imageNamed:@"itunes_knob.png"];
    _showbsize.barFillImage = [NSImage imageNamed:@"itunes_barFill.png"];
    _showbsize.barFillBeforeKnobImage = [NSImage imageNamed:@"itunes_barFillBeforeknob.png"];
    _showbsize.barLeftAgeImage = [NSImage imageNamed:@"itunes_barLeftAge.png"];
    _showbsize.barRightAgeImage = [NSImage imageNamed:@"itunes_barRightAge.png"];
    [_showsave setEnabled:NO];
    
    [_showresult setBackground:_showbg];

    // leftview
    [_scrollbrushview setSynchronizedScrollView:_scrollbgview];
    [_scrollbrushview setZoomflag:1];
    [_scrollbrushview setViewname:@"scrollbrushview"];
    
    //[_leftshellview addSubview:_showbrush];
    
    //[_scrollbgview setDocumentView:_showbg];
    [_scrollbgview setSynchronizedScrollView:_scrollbrushview];
    [_scrollbgview setZoomflag:1];
    [_scrollbgview setViewname:@"scrollbgview"];
    
    [_leftshellview setAutoresizesSubviews:YES];
    [_rightshellview setAutoresizesSubviews:YES];
    
   // [_showout setEnabled:NO];
   // [_showin setEnabled:NO];
    [_showclear setEnabled:NO];
    [_showchangesize setEnabled:NO];
    [_showundo setEnabled:NO];
    [_showredo setEnabled:NO];
    [_showmatting setEnabled:NO];
    
   // [_showdrawout setState:NSOffState];
   // [_showdrawin setState:NSOffState];
    [_showdrawin setEnabled:NO];
    [_showdrawout setEnabled:NO];
    
    [_showdrawin setState:NSOnState];
    [_showdrawout setState:NSOnState];
   
    [_showzoomin setEnabled:NO];
    [_showzoomout setEnabled:NO];
    
    modelRect.size.width = rectwidth;
    modelRect.size.height = rectheight;
    lock = [[NSLock alloc] init];
    [_showbsize setMinValue:10.0];
    [_showbsize setMaxValue:30.0];
    [_showbsize setStringValue:@"20.0"];
    NSRect brushframerect;
    brushframerect.size.width = rectwidth;
    brushframerect.size.width = rectheight;
    brushframerect.origin.x = 0;
    brushframerect.origin.y = 0;
    [_showbrush setFrame:brushframerect];
    
    NSRect brushboundsrect;
    brushboundsrect.size.width = rectwidth;
    brushboundsrect.size.width = rectheight;
    brushboundsrect.origin.x = 0;
    brushboundsrect.origin.y = 0;
    [_showbrush setBounds:brushboundsrect];

    [_showbrush setBrushsize:20];
    [_showbrush setOffsetX:[_scrollbrushview frame].origin.x OffsetY:[_scrollbrushview frame].origin.y];
    [_showdrawin setState:NSOnState];
    hash_magic = @"df23js773";
    imagepath = @"";
    
    NSString* dir = NSTemporaryDirectory();
    NSString* prefix = [dir stringByAppendingString:hash_magic];
    //NSString* pth1 = [string stringByAppendingPathComponent:@"watermark.png"];
    pngresultfilepath = [prefix stringByAppendingString:@"_pngresultfile.png"];
    pngfilepath = [prefix stringByAppendingString:@"_pngfilepath.png"];
    pngresultfileimerodepath = [prefix stringByAppendingString:@"_pngresultfileimrode.png"];
    resultfilepath = [prefix stringByAppendingString:@"_resultfilepath.png"];
    resultbgfilepath = [prefix stringByAppendingString:@"_resultbgfilepath.png"];
    [_showbrush setPngfilepath:pngfilepath];
    [_showbrush setCandrawflag:0];
    trans_progress = [[NSThread alloc] initWithTarget:self selector:@selector(run_trans) object:nil];
    [trans_progress setName:@"Thread_trans"];
    [trans_progress start];
    g_progress = 0;
    trans_modal = [[NSThread alloc] initWithTarget:self selector:@selector(run_modal) object:nil];
    [trans_modal setName:@"Thread_modal"];
    [trans_modal start];
    flag = 0;
    maxarea = 0;
    posx = -1;
    posy = -1;
    areaset = [[NSMutableArray alloc]init];
    showid = -1;
    dpi = 72.0f;

    leftRect.size.width = rectwidth;
    leftRect.size.height = rectheight;
    leftRect.origin.x = 20;
    leftRect.origin.y = 20;
    
    rightRect.size.width = rectwidth;
    rightRect.size.height = rectheight;
    rightRect.origin.x = 430;
    rightRect.origin.y = 20;
    
    [_showchangebg setEnabled:NO];
    [_showchangetransparent setEnabled:NO];
    //[_showbg setImage:[NSImage imageNamed:@"background.png"]];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)openimage:(id)sender {
    
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Set array of file types
    NSArray *fileTypesArray;
    fileTypesArray = [NSArray arrayWithObjects:@"jpg",@"png", @"bmp", @"tiff", @"jpeg",@"gif", nil];
    
    // Enable options in the dialog.
    [openDlg setCanChooseFiles:YES];
    [openDlg setAllowedFileTypes:fileTypesArray];
    [openDlg setAllowsMultipleSelection:FALSE];
    
    if ( [openDlg runModal] == NSModalResponseOK ) {
        
        // Gets list of all files selected
        NSArray *files = [openDlg URLs];
        NSImageRep * imagerep = [NSImageRep imageRepWithContentsOfFile:[[files firstObject] path ]];
        NSImage * image = [[NSImage alloc] initWithContentsOfFile:[[files firstObject] path]] ;
        imagepath = [[files firstObject] path];
        curzoomFactor = 1;
        [_showsave setEnabled:YES];
        [_showdrawin setEnabled:YES];
        [_showdrawout setEnabled:YES];
        [_showzoomout setEnabled:YES];
        [_showzoomin setEnabled:YES];
        [_showclear setEnabled:YES];
        [_showchangesize setEnabled:YES];
        [_showundo setEnabled:YES];
        [_showredo setEnabled:YES];
        [_showmatting setEnabled:YES];
        [_showbrush setCandrawflag:1];
        // set size and position
        leftRect.size = modelRect.size;
        leftRect.origin.x = 0;
        leftRect.origin.y = 0;
        
        rightRect.size = modelRect.size;
        rightRect.origin.x = 0;
        rightRect.origin.y = 0;
        
        brushRect.size = modelRect.size;
        if((float)[image size].width / (float)[image size].height > (float)modelRect.size.width / (float)modelRect.size.height)
        {
            brushRect.size.height = (float)[image size].height / (float)[image size].width * modelRect.size.width;
            brushRect.size.height = (float)[image size].height / (float)[image size].width * modelRect.size.width;
        }
        else
        {
            brushRect.size.width = (float)[image size].width / (float)[image size].height * modelRect.size.height;
            brushRect.size.width = (float)[image size].width / (float)[image size].height * modelRect.size.height;
        }
       /* {
            leftRect.size.height = (float)[image size].height / (float)[image size].width * modelRect.size.width;
            rightRect.size.height = (float)[image size].height / (float)[image size].width * modelRect.size.width;
            leftRect.origin.x = 20;
            rightRect.origin.x = 430;
            leftRect.origin.y = (modelRect.size.height - leftRect.size.height) / 2 + 20;
            rightRect.origin.y = (modelRect.size.height - leftRect.size.height) / 2 + 20;
        }
        else
        {
            leftRect.size.width = (float)[image size].width / (float)[image size].height * modelRect.size.height;
            rightRect.size.width = (float)[image size].width / (float)[image size].height * modelRect.size.height;
            leftRect.origin.x = (modelRect.size.width - leftRect.size.width) / 2 + 20;
            rightRect.origin.x = (modelRect.size.width - leftRect.size.width) / 2 + 430;
            leftRect.origin.y = 20;
            rightRect.origin.y = 20;
    
        }*/
        
        [_showorg setFrame:leftRect];
        [_showbrush setFrame:leftRect];
        leftRect.origin.x=0;
        leftRect.origin.y=0;
        [_showbrush setBounds:leftRect];
        [_showbg setFrame:rightRect];
        [_showresult setFrame:rightRect];
        
        [_showorg setImage:image];
        [_showbrush setZoomfactor:1];
        [_showresult setZoomfactor:1];
        //////////////////
        NSLog(@"showorg %f %f %f %f", [[_leftview documentView] frame].origin.x, [[_leftview documentView] frame].origin.y, [_showorg frame].origin.x, [_showorg frame].origin.y);
        
        ///////////////////
        //[_showresult setImage:nil];
        [_showresult setI:nil];
        [_showbrush removepath];
        [_showdrawin setState:NSOnState];
        [_showdrawout setState:NSOffState];
        [_showbrush setBrusht:0];
        maxarea = 0;
        [areaset removeAllObjects];
        //set brush border
        brushframe = [_showorg frame];
        brushframe.origin.x = 0;
        brushframe.origin.y = 0;
        //NSRect brushbounds = [_showorg bounds];
        float borderrate = [_showorg frame].size.height / [_showorg frame].size.width;
        float imagerate = [image size].height / [image size].width;
        if(borderrate > imagerate)
        {
            brushframe.size.height = imagerate * brushframe.size.width;
            brushframe.origin.y = ([_showorg frame].size.height - brushframe.size.height) / 2;
        }
        else
        {
            brushframe.size.width = brushframe.size.height / imagerate;
            brushframe.origin.x = ([_showorg frame].size.width - brushframe.size.width) / 2;
        }
        NSSize pngsize;
        //NSSize pngsize = [image size];
        pngsize.width = [imagerep pixelsWide];
        pngsize.height = [imagerep pixelsHigh];
        NSLog(@"%f ", [_window backingScaleFactor]);
        if([_window backingScaleFactor] > 1.0)
        {
            pngsize.width /= 2;
            pngsize.height /= 2;
        }
        NSLog(@"%f %f", pngsize.height, pngsize.width);
        [_showbrush setImagesize:pngsize];
        [_showbrush setCroparea:brushframe];
        
        
        NSImage * srcImage = [NSImage imageNamed:@"background.png"];
        
        NSImage *newImage = [[NSImage alloc] initWithSize:brushRect.size];
        [newImage lockFocus];
        [[NSColor grayColor] set];
        NSRectFill(NSMakeRect(0,0,[newImage size].width, [newImage size].height));
        //[srcImage compositeToPoint:NSZeroPoint operation:NSCompositeCopy];
        [srcImage drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0,0,[newImage size].width, [newImage size].height) operation:NSCompositeSourceOver fraction:1.0];
        [newImage unlockFocus];

        //[_showbg setImageScaling:NSImageScaleNone];
        //[_showbg setImage:newImage];
        [_showbg setI:newImage];
        [_showbg setPointbound:brushframe];
        [_showbg setBgtype:1];
        [_showresult setImageboung:brushframe];
        [_showresult setPointbound:brushframe];
        [_showresult setNeedsDisplay:YES];
        //[_showbg setI:newImage];
        //[_showbg setPointbound:brushframe];
        // dpi
        
        
        dpi = ceilf((72.0f * [imagerep pixelsWide])/[image size].width);
        [_showbrush setOrgdpi:dpi];
        
        [_showchangebg setEnabled:YES];
        [_showchangetransparent setEnabled:YES];

    }
}

- (IBAction)saveimage:(id)sender {
    NSSavePanel* savePanel = [NSSavePanel savePanel];
    [savePanel setNameFieldStringValue:@"untitled.png"];
    // Hide this window
    //[self.window orderOut:self];
    NSString * savepanelopendir = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0],[[NSBundle mainBundle] bundleIdentifier]]];
    [savePanel setDirectoryURL:[NSURL URLWithString:savepanelopendir]];
    
    // Run the save dialog
    NSInteger result = [savePanel runModal];
    if (result == NSFileHandlingPanelOKButton) {
        // Build the URLs
        NSURL *sourceURL = [NSURL fileURLWithPath:resultfilepath];
        if([_showbg bgtype] == 2)
        {
            NSImageRep * resultimagerep = [NSImageRep imageRepWithContentsOfFile:resultfilepath];
            int resultimagerepwidth = (int)[resultimagerep pixelsWide];
            int resultimagerepheight = (int)[resultimagerep pixelsHigh];
            NSImage * resultimage = [[NSImage alloc] initWithContentsOfFile:resultfilepath] ;
            int resultimagewidth = [resultimage size].width;
            int resultimageheight = [resultimage size].height;
            float factor = resultimagewidth / brushframe.size.width ;
            if(curzoomFactor < 1+0.001)
            {
                factor = resultimagewidth / brushframe.size.width / curzoomFactor;
            }
            
            int bgwidth = [_showbg pointbound].size.width * factor;
            int bgheight = [_showbg pointbound].size.height * factor;
            
            NSBitmapImageRep *mergebg_rep = [[NSBitmapImageRep alloc]
                                           initWithBitmapDataPlanes: NULL
                                           pixelsWide: bgwidth
                                           pixelsHigh: bgheight
                                           bitsPerSample: 8
                                           samplesPerPixel: 4
                                           hasAlpha: YES
                                           isPlanar: NO
                                           colorSpaceName: NSDeviceRGBColorSpace
                                           bytesPerRow: bgwidth * 4
                                           bitsPerPixel: 32];
            NSGraphicsContext *mergebg_ctx = [NSGraphicsContext graphicsContextWithBitmapImageRep: mergebg_rep];
            [NSGraphicsContext saveGraphicsState];
            [NSGraphicsContext setCurrentContext: mergebg_ctx];
            
            [[_showbg i] drawInRect:NSMakeRect(0, 0, bgwidth, bgheight)];
            NSPoint resultdrawpoint;
            resultdrawpoint.x = ([_showresult imageboung].origin.x - [_showresult pointbound].origin.x) * factor;
            resultdrawpoint.y = ([_showresult imageboung].origin.y - [_showresult pointbound].origin.y) * factor ;
            //resultdrawpoint.x = ([_showresult imageboung].origin.x - [_showresult pointbound].origin.x);
            //resultdrawpoint.y = ([_showresult imageboung].origin.y - [_showresult pointbound].origin.y);
            [resultimage drawAtPoint: resultdrawpoint fromRect: NSZeroRect operation: NSCompositeSourceOver fraction: 1.0];
            //[resultimage drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeSourceOver fraction: 1.0];
            
            
            //NSCompositeSourceOver
            [NSGraphicsContext restoreGraphicsState];
            NSData * imagedata = [mergebg_rep representationUsingType:NSPNGFileType properties:nil];
            [imagedata writeToFile:resultbgfilepath atomically:YES];
            sourceURL = [NSURL fileURLWithPath:resultbgfilepath];
        }
       
        NSURL *destinationURL = savePanel.URL;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error = nil;
        
        if ([fileManager fileExistsAtPath:destinationURL.path]) {
            [fileManager removeItemAtURL:destinationURL error:&error];
            
            if (error != nil) {
                [[NSAlert alertWithError:error] runModal];
            }
        }
        
        // Bail on error
        if (error != nil) {
            return;
        }
        
        [[NSFileManager defaultManager] copyItemAtURL:sourceURL toURL:destinationURL error:&error];
        
    }
}

- (IBAction)savealpha:(id)sender {
    [_showbrush buildpng];
}
- (IBAction)changebrushsize:(id)sender {
    [_showbrush setBrushsize:(int)[_showbsize integerValue]];
}

- (IBAction)drawout:(id)sender {
    [_showbrush setBrusht:1];
    [_showdrawin setState:NSOffState];
    [_showdrawout setState:NSOnState];
    
}

- (IBAction)drawin:(id)sender {
    [_showbrush setBrusht:0];
    [_showdrawout setState:NSOffState];
    [_showdrawin setState:NSOnState];
}
- (IBAction)matting:(id)sender {
    NSLog(@"start matting");
   // NSLog(@"position %f %f %f %f", [[_scrollbrushview contentView] frame].origin.x, [[_scrollbrushview contentView] frame].origin.y, [[_scrollbrushview contentView] bounds].origin.x, [[_scrollbrushview contentView] bounds].origin.y);
    NSPoint position = [[_scrollbrushview contentView] bounds].origin;
   // position.x = 200;
   // position.y = 200;
    [_showbrush buildpng];
    [[_scrollbrushview contentView] scrollToPoint:position];
    [_scrollbrushview reflectScrolledClipView:[_scrollbrushview contentView]];
    pw = [[progresswindow alloc] init ];
    
    [[pw pg]setMinValue:0.0];
    [[pw pg]setMaxValue:100.0];
    [[pw pg]setDoubleValue:50.0];
    //NSPoint pp = [_window frame].origin;
    NSPoint p = [_window frame].origin;
    //p.x += 300;
    p.x += 1060 / 2 - 200 / 2 - 15;

    p.y += 200;
    [[pw window] setFrameOrigin:p];
    [[pw pg] displayIfNeeded];
    //flag = 1;
    [_window setMovable:NO];
    [lock lock];
    flag = 1;
    [lock unlock];
    [pw runModal];
    [_window setMovable:YES];

    //[self matt_internal];
}
- (void)matt_internal
{
    showid = -1;
    maxarea = 0;
    [areaset removeAllObjects];
    //[_showbrush buildpng];
    [matt buildmattimage:imagepath graypicname:pngfilepath outputpicname:pngresultfilepath  progressname:&g_progress];
    
    // change DPI
    {
    NSImage * image_dpi = [[NSImage alloc]initByReferencingFile:pngresultfilepath];
    int width = [image_dpi size].width;
    int height = [image_dpi size].height;
    
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
    
    updatedPointsSize.width = ceilf((72.0f * pixelSize.width)/dpi);
    updatedPointsSize.height = ceilf((72.0f * pixelSize.height)/dpi);
    
    [rep_dpi setSize:updatedPointsSize];
    
    NSData *data = [rep_dpi representationUsingType: NSPNGFileType properties: nil];
    [data writeToFile: pngresultfileimerodepath atomically: YES];
    }
//////////////
   /* NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    
    if ([fileManager fileExistsAtPath:pngresultfileimerodepath]) {
        [fileManager removeItemAtPath:pngresultfileimerodepath error:&error];
        
        if (error != nil) {
            [[NSAlert alertWithError:error] runModal];
        }
    }
    
    // Bail on error
    if (error != nil) {
        return;
    }
    
    [[NSFileManager defaultManager] copyItemAtPath:pngresultfilepath toPath:pngresultfileimerodepath error:&error];*/
    
    
    //int ** map = NULL;
    NSImage * image_alpha = [[NSImage alloc]initByReferencingFile:pngresultfileimerodepath];
    int mapw = [image_alpha size].width;
    int maph = [image_alpha size].height;
    imagemap = [[NSMutableArray alloc]initWithCapacity:mapw];
    
    NSImage * image_alpha_erode = [[NSImage alloc]initByReferencingFile:pngresultfileimerodepath];
    
    NSBitmapImageRep *rep_alpha = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes: NULL
                                 pixelsWide: mapw
                                 pixelsHigh: maph
                                 bitsPerSample: 8
                                 samplesPerPixel: 4
                                 hasAlpha: YES
                                 isPlanar: NO
                                 colorSpaceName: NSDeviceRGBColorSpace
                                 bytesPerRow: mapw * 4
                                 bitsPerPixel: 32];
    NSGraphicsContext *ctx_alpha = [NSGraphicsContext graphicsContextWithBitmapImageRep: rep_alpha];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctx_alpha];
    

    [image_alpha_erode drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctx_alpha flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    unsigned char * rep_bitmapdata = [rep_alpha bitmapData];
    NSUInteger rep_bitmapdata_BytesPerRow = [rep_alpha bytesPerRow];
    for(int i = 0; i< mapw;i++)
    {
        NSMutableArray * ma = [[NSMutableArray alloc]initWithCapacity:maph];
        for(int j = 0;j<maph; j ++)
        {
            unsigned char *pixel = rep_bitmapdata + ((i * 4) + (j * rep_bitmapdata_BytesPerRow));
            u_int sr, sg, sb, sa;
            sr = (u_int)*pixel;
            sg = (u_int)*(pixel + 1);
            sb = (u_int)*(pixel + 2);
            sa = (u_int)*(pixel + 3);
            int pi = 0;
 //           float factor = 255.0f / sa;
            if( (float)sr / (float)sa > 0.2
               && (float)sg / (float)sa > 0.2
               && (float)sb / (float)sa > 0.2)
            {
                pi = -1;
            }
            [ma addObject:[NSNumber numberWithInt:pi]];
        }
        [imagemap addObject:ma];
    }
    [areaset removeAllObjects];
    int mapid = 100;
    for(int i = 0;i<mapw;i++)
    {
        for(int j = 0;j<maph;j++)
        {
            
            if([[[imagemap objectAtIndex:i] objectAtIndex:j] intValue]== -1)
            {
                [self bfs:i posy:j width:mapw height:maph value:mapid++];
            }
        }
    }
    
    //NSArray * sortedArray = [areaset sortedArrayUsingSelector:@selector(compare:)];
    /*for(int i = [sortedArray count] - 10;i<[sortedArray count];i++)
    {
        NSLog(@"%d %d", i , (int)[[sortedArray objectAtIndex:i] integerValue]);
    }*/
    NSLog(@"showid %d %d", showid, maxarea);
    
    
    NSLog(@"max area %d %d %d", maxarea, posx, posy);
    // alpha to image
    NSImage * image_res = [[NSImage alloc]initByReferencingFile:imagepath];
    NSImage * image_org = [[NSImage alloc]initByReferencingFile:pngresultfileimerodepath];
    int width = [image_org size].width;
    int height = [image_org size].height;
    
    if(width < 1 || height < 1)
        return ;
    
    NSBitmapImageRep *rep_org = [[NSBitmapImageRep alloc]
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
    
    NSBitmapImageRep *rep_res = [[NSBitmapImageRep alloc]
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
    
    NSGraphicsContext *ctx_org = [NSGraphicsContext graphicsContextWithBitmapImageRep: rep_org];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctx_org];
    [image_org drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctx_org flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    
    
    NSGraphicsContext *ctx_res = [NSGraphicsContext graphicsContextWithBitmapImageRep: rep_res];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: ctx_res];
    [image_res drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeCopy fraction: 1.0];
    [ctx_res flushGraphics];
    [NSGraphicsContext restoreGraphicsState];
    
    //NSColor * c = [NSColor clearColor];
    int sumblack = 0;
    int sumwhite = 0;
    //unsigned char * org_bitmapdata = [rep_org bitmapData];
    //NSUInteger org_bitmapdata_BytesPerRow = [rep_org bytesPerRow];
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
      //      int pi = 0;
      //      float factor = 255.0f / sa;
            if( ((float)sr / (float)sa < 0.1
               && (float)sg / (float)sa < 0.1
               && (float)sb / (float)sa < 0.1 )
               ||([[[imagemap objectAtIndex:i] objectAtIndex:j] intValue] != showid))
            {
                @autoreleasepool {
                NSColor * crep_new = [[rep_res colorAtX:i y:j] colorWithAlphaComponent:0.0];
                    [rep_res setColor:crep_new atX:i y:j];
                }
            }
        }
    }
    NSData * imageData1 = [rep_res representationUsingType:NSPNGFileType properties:nil];
    [imageData1 writeToFile:resultfilepath atomically:YES];
    NSLog(@" %d %d %d %d", sumblack, sumwhite, sumblack+sumwhite ,width * height);
    
    NSImage * resimage = [[NSImage alloc]initWithContentsOfFile:resultfilepath];
    //[_showresult setImage:resimage];
    [_showresult setI:resimage];
    //[_showresult setPointbound:brushframe];
    //[_showresult setImageboung:brushframe];
    [_showresult setNeedsDisplay:YES];
    [_rightview reflectScrolledClipView:[_rightview contentView]];
    g_progress = 100;
    
}

- (IBAction)callremovepath:(id)sender {
    [_showbrush removepath];
}

- (IBAction)callundo:(id)sender {
    [_showbrush undo];
}

- (IBAction)callredo:(id)sender {
    [_showbrush redo];
}

- (IBAction)callmodal:(id)sender {
    pw = [[progresswindow alloc] init ];
    
    [[pw pg]setMinValue:0.0];
    [[pw pg]setMaxValue:100.0];
    [[pw pg]setDoubleValue:50.0];
    //NSPoint pp = [_window frame].origin;
    NSPoint p = [_window frame].origin;
    //p.x = 500;
    //p.y = 500;
    [[pw window] setFrameOrigin:p];
    [[pw pg] displayIfNeeded];
    flag = 1;
    [_window setMovable:NO];
    [pw runModal];
    [_window setMovable:YES];
    flag = 0;

}
- (void)run_trans
{
    while (YES) {
        [NSThread sleepForTimeInterval:0.1];
        [lock lock];
        if(flag == 1 && pw != nil)
        {
            //[[tw pg] setProgressOffset:a++];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[pw pg] setDoubleValue:g_progress];
            });
            //            NSLog(@"%d", a);
            //[alert setshow:a++];
        }
        if(g_progress == 100)
        {
            flag = 0;
            dispatch_async(dispatch_get_main_queue(), ^{
                [NSApp endSheet:[pw window]];
                [_window setMovable:YES];
            });
            g_progress = 0;
        }
        [lock unlock];
    }
    
    
}

-(void)run_modal
{
    while (YES) {
        
        [NSThread sleepForTimeInterval:0.1];
        if(flag == 1)
        {
            [self matt_internal];
            flag = 0;
        }
    }
}
-(void)breadthsearch:(int **)map posx:(int)i posy:(int)j width:(int)w height:(int)h value:(int)v
{
    int offsetx[4] = { 1, -1, 0 ,0};
    int offsety[4] = { 0, 0, 1, -1};
    int maxnum = 0;
    map[i][j]=1;
    NSMutableArray * bpointarray = [[NSMutableArray alloc]init];
    maxnum = 1;
    NSPoint p ;
    p.x = i;
    p.y = j;
    [bpointarray addObject:[NSValue valueWithPoint:p]];
    while([bpointarray count] > 0)
    {
        NSPoint pc = [[bpointarray firstObject] pointValue];
        [bpointarray removeObjectAtIndex:0];
        for(int i = 0;i < 4;i ++)
        {
            NSPoint npc = pc;
            npc.x += offsetx[i];
            npc.y += offsety[i];
            if(npc.x < 0 || npc.y < 0 || npc.x >= w || npc.y >=h )
            {
                continue;
            }
            if(map[(int)npc.x][(int)npc.y] == -1)
            {
                map[(int)npc.x][(int)npc.y] = v;
                [bpointarray addObject:[NSValue valueWithPoint:npc]];
                maxnum ++;
            }
        }
    }
    
    [areaset addObject:[NSNumber numberWithInt:  maxnum]];
    if(maxarea < maxnum)
    {
        maxarea = maxnum;
        showid = v;
    }
}
-(void)bfs:(int)i posy:(int)j width:(int)w height:(int)h value:(int)v
{
    int offsetx[4] = { 1, -1, 0 ,0};
    int offsety[4] = { 0, 0, 1, -1};
    int maxnum = 0;
    [[imagemap objectAtIndex:i]replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:v]];
    //map[i][j]=1;
    NSMutableArray * bpointarray = [[NSMutableArray alloc]init];
    maxnum = 1;
    NSPoint p ;
    p.x = i;
    p.y = j;
    [bpointarray addObject:[NSValue valueWithPoint:p]];
    while([bpointarray count] > 0)
    {
        NSPoint pc = [[bpointarray firstObject] pointValue];
        [bpointarray removeObjectAtIndex:0];
        for(int i = 0;i < 4;i ++)
        {
            NSPoint npc = pc;
            npc.x += offsetx[i];
            npc.y += offsety[i];
            if(npc.x < 0 || npc.y < 0 || npc.x >= w || npc.y >=h )
            {
                continue;
            }
            if([[[imagemap objectAtIndex:(int)npc.x] objectAtIndex:(int)npc.y] intValue]== -1)
            {
                [[imagemap objectAtIndex:(int)npc.x]replaceObjectAtIndex:(int)npc.y withObject:[NSNumber numberWithInt:v]];
                [bpointarray addObject:[NSValue valueWithPoint:npc]];
                maxnum ++;
            }
        }
    }
    
    [areaset addObject:[NSNumber numberWithInt:  maxnum]];
    if(maxarea < maxnum)
    {
        maxarea = maxnum;
        showid = v;
    }
}
-(void)depthsearch:(int **) map posx:(int)i posy:(int)j width:(int)w height:(int)h value:(int)v
{
    if(i < 0 || j < 0 || i>=w || j >= h)
    {
        return;
    }
    if(map[i][j] != -1)
    {
        return;
    }
    map[i][j] = v;
    if(v > maxarea)
    {
        maxarea = v;
        posx = i;
        posy = j;
    }
    [self depthsearch:map posx:i + 1 posy:j width:w height:h value:v+1];
    [self depthsearch:map posx:i posy:j + 1 width:w height:h value:v+1];
    [self depthsearch:map posx:i - 1 posy:j width:w height:h value:v+1];
    [self depthsearch:map posx:i posy:j - 1 width:w height:h value:v+1];
}

- (BOOL)windowShouldClose:(id)sender {
    [[NSApplication sharedApplication] hide:self];
    NSLog(@"click red close123");
    return NO;
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    [[NSApplication sharedApplication] unhide:self];
    NSLog(@"click dock");
}
- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    [_window setIsVisible:YES];
    NSLog(@"reopen???");
    return YES;
}
- (IBAction)gethelp:(id)sender {
    NSURL * helpFile = [NSURL URLWithString:@"http://blog.sina.com.cn/u/5612550186"];
    [[NSWorkspace sharedWorkspace] openURL:helpFile];
    NSLog(@"call showHelp!!!");
}

- (IBAction)menureopen:(id)sender {
    //[[NSApplication sharedApplication] unhide:self];
    [_window setIsVisible:YES];
    NSLog(@"click menureopen");
}
- (IBAction)zoomin:(id)sender {
    [_showzoomout setEnabled:YES];
    
    if(curzoomFactor  < 1 + 0.001)
    {
        
        NSRect leftinnershellviewframe = [_leftinnershellview frame];
        leftinnershellviewframe.size.width /= zoomFactor;
        leftinnershellviewframe.size.height /= zoomFactor;
        leftinnershellviewframe.origin.x = ([_leftshellview frame].size.width - leftinnershellviewframe.size.width) / 2;
        leftinnershellviewframe.origin.y = ([_leftshellview frame].size.height - leftinnershellviewframe.size.height) / 2;
        [_leftinnershellview scaleUnitSquareToSize:NSMakeSize(1/zoomFactor, 1/zoomFactor)];
        [_leftinnershellview setFrame:leftinnershellviewframe];
        
        
        
        NSRect showresultframe = [_showresult frame];
        showresultframe.origin.x = 0;
        showresultframe.origin.y = 0;
        [_showresult setFrame:showresultframe];
        
        NSRect showbgpointbound = [_showbg pointbound];
        showbgpointbound.size.width /= zoomFactor;
        showbgpointbound.size.height /= zoomFactor;
        showbgpointbound.origin.x += (rectwidth / 2  - showbgpointbound.origin.x) / zoomFactor * (zoomFactor - 1);
        showbgpointbound.origin.y += (rectheight / 2 - showbgpointbound.origin.y) / zoomFactor * (zoomFactor - 1);
        //showbgpointbound.origin.x = ([_leftshellview frame].size.width - showbgpointbound.size.width) / 2;
        //showbgpointbound.origin.y = ([_leftshellview frame].size.height - showbgpointbound.size.height) / 2;
        [_showbg setPointbound:showbgpointbound];
        [_showbg setNeedsDisplay:YES];
        //[_showbg setFrame:showbgframe];
        
        //NSRect showresultpointbound = [_showresult pointbound];
        NSRect showresultimagebound = [_showresult imageboung];
        showresultimagebound.size.width /= zoomFactor;
        showresultimagebound.size.height /= zoomFactor;
        showresultimagebound.origin.x = ([_rightshellview frame].size.width - showresultimagebound.size.width) / 2;
        showresultimagebound.origin.y = ([_rightshellview frame].size.height - showresultimagebound.size.height) / 2;
        [_showresult setImageboung:showresultimagebound];
        
        NSRect showresultpointbound = [_showresult pointbound];
        showresultpointbound.size.width /= zoomFactor;
        showresultpointbound.size.height /= zoomFactor;
        showresultpointbound.origin.x += (rectwidth / 2  - showresultpointbound.origin.x) / zoomFactor * (zoomFactor - 1);
        showresultpointbound.origin.y += (rectheight / 2 - showresultpointbound.origin.y) / zoomFactor * (zoomFactor - 1);
        
        //showresultpointbound.origin.x = ([_rightshellview frame].size.width - showresultpointbound.size.width) / 2;
        //showresultpointbound.origin.y = ([_rightshellview frame].size.height - showresultpointbound.size.height) / 2;
        [_showresult setPointbound:showresultpointbound];
        [_showresult setNeedsDisplay:YES];
        
    }
    else
    {
        NSRect visible = [_scrollbrushview documentVisibleRect];
        NSRect newrect = NSOffsetRect(visible, -NSWidth(visible)*(zoomFactor - 1)/2.0, -NSHeight(visible)*(zoomFactor - 1)/2.0);
        
        NSRect frame = [_scrollbrushview.documentView frame];
        [_scrollbrushview.documentView scaleUnitSquareToSize:NSMakeSize(1/zoomFactor, 1/zoomFactor)];
        
        
        
        [_scrollbrushview.documentView setFrame:NSMakeRect(0, 0, frame.size.width / zoomFactor, frame.size.height / zoomFactor)];
        
        [[_scrollbrushview documentView] scrollPoint:newrect.origin];
       
        [_scrollbgview.documentView scaleUnitSquareToSize:NSMakeSize(1/zoomFactor, 1/zoomFactor)];
        [_scrollbgview.documentView setFrame:NSMakeRect(0, 0, frame.size.width / zoomFactor, frame.size.height / zoomFactor)];
        [[_scrollbgview documentView] scrollPoint:newrect.origin];
        
        NSRect showbrushframe = [_showbrush frame];
        showbrushframe.origin.x = 0;
        showbrushframe.origin.y = 0;
        [_showbrush setFrame:showbrushframe];
        
        NSRect showorgframe = [_showorg frame];
        showorgframe.origin.x = 0;
        showorgframe.origin.y = 0;
        [_showorg setFrame:showorgframe];
        
        NSRect showresultframe = [_showresult frame];
        showresultframe.origin.x = 0;
        showresultframe.origin.y = 0;
        [_showresult setFrame:showresultframe];
        
        NSRect showbgframe = [_showbg frame];
        showbgframe.origin.x = 0;
        showbgframe.origin.y = 0;
        [_showbg setFrame:showbgframe];
        
        [_showresult setZoomfactor:1 / zoomFactor * [_showresult zoomfactor]];
    }
    NSLog(@"zoomin");

   // NSRect fs = [_showbrush frame];
   // [_showbg setFrame:NSMakeRect(0, 0, fs.size.width / zoomFactor, fs.size.height / zoomFactor)];
    
    
    
    [_showbrush setZoomfactor:1 / zoomFactor * [_showbrush zoomfactor]];
    
    curzoomFactor /= zoomFactor;
    if(curzoomFactor < g_zoommin)
    {
        [_showzoomin setEnabled:NO];
    }
}

- (IBAction)zoomout:(id)sender {
    [_showzoomin setEnabled:YES];
    if(curzoomFactor  + 0.001 < 1 )
    {
        
        NSRect leftinnershellviewframe = [_leftinnershellview frame];
        leftinnershellviewframe.size.width *= zoomFactor;
        leftinnershellviewframe.size.height *= zoomFactor;
        leftinnershellviewframe.origin.x = ([_leftshellview frame].size.width - leftinnershellviewframe.size.width) / 2;
        leftinnershellviewframe.origin.y = ([_leftshellview frame].size.height - leftinnershellviewframe.size.height) / 2;
        [_leftinnershellview scaleUnitSquareToSize:NSMakeSize(zoomFactor, zoomFactor)];
        [_leftinnershellview setFrame:leftinnershellviewframe];
        
        NSRect showresultframe = [_showresult frame];
        showresultframe.origin.x = 0;
        showresultframe.origin.y = 0;
        [_showresult setFrame:showresultframe];
        
        NSRect showbgpointbound = [_showbg pointbound];
        showbgpointbound.size.width *= zoomFactor;
        showbgpointbound.size.height *= zoomFactor;
        showbgpointbound.origin.x -= (rectwidth / 2 - showbgpointbound.origin.x) * (zoomFactor - 1);
        showbgpointbound.origin.y -= (rectheight  / 2 - showbgpointbound.origin.y) * (zoomFactor - 1);
        //showbgpointbound.origin.x = ([_leftshellview frame].size.width - showbgpointbound.size.width) / 2;
        //showbgpointbound.origin.y = ([_leftshellview frame].size.height - showbgpointbound.size.height) / 2;
        [_showbg setPointbound:showbgpointbound];
        [_showbg setNeedsDisplay:YES];
        
        NSRect showresultimagebound = [_showresult imageboung];
        showresultimagebound.size.width *= zoomFactor;
        showresultimagebound.size.height *= zoomFactor;
        showresultimagebound.origin.x = ([_rightshellview frame].size.width - showresultimagebound.size.width) / 2;
        showresultimagebound.origin.y = ([_rightshellview frame].size.height - showresultimagebound.size.height) / 2;
        [_showresult setImageboung:showresultimagebound];
        NSRect showresultpointbound = [_showresult pointbound];
        showresultpointbound.size.width *= zoomFactor;
        showresultpointbound.size.height *= zoomFactor;
        showresultpointbound.origin.x -= (rectwidth / 2 - showresultpointbound.origin.x) * (zoomFactor - 1);
        showresultpointbound.origin.y -= (rectheight / 2 - showresultpointbound.origin.y) * (zoomFactor - 1);
        //showresultpointbound.origin.x = ([_rightshellview frame].size.width - showresultpointbound.size.width) / 2;
        //showresultpointbound.origin.y = ([_rightshellview frame].size.height - showresultpointbound.size.height) / 2;
        [_showresult setPointbound:showresultpointbound];

        [_showresult setNeedsDisplay:YES];    }
    else
    {
        NSRect visible = [_scrollbrushview documentVisibleRect];
        NSRect newrect = NSInsetRect(visible, NSWidth(visible)*(1 - 1/zoomFactor)/2.0, NSHeight(visible)*(1 - 1/zoomFactor)/2.0);
        NSRect frame = [[_scrollbrushview documentView] frame];
        [_scrollbrushview.documentView scaleUnitSquareToSize:NSMakeSize(zoomFactor, zoomFactor)];
        [_scrollbrushview.documentView setFrame:NSMakeRect(0, 0, frame.size.width * zoomFactor, frame.size.height * zoomFactor)];
      
        [[_scrollbrushview documentView] scrollPoint:newrect.origin];
       
        [_scrollbgview.documentView scaleUnitSquareToSize:NSMakeSize(zoomFactor, zoomFactor)];
        [_scrollbgview.documentView setFrame:NSMakeRect(0, 0, frame.size.width * zoomFactor, frame.size.height * zoomFactor)];
        
        [[_scrollbgview documentView] scrollPoint:newrect.origin];
        
        [_showresult setZoomfactor:zoomFactor * [_showresult zoomfactor]];
    
    }

    
    [_scrollbrushview setZoomflag:1];
    [_scrollbgview setZoomflag:1];
    
    [_showbrush setZoomfactor:zoomFactor * [_showbrush zoomfactor]];

    curzoomFactor *= zoomFactor;
    if(curzoomFactor >= g_zoommax)
    {
        [_showzoomout setEnabled:NO];
    }
}
- (IBAction)debug:(id)sender {
    NSImageRep * resultimagerep = [NSImageRep imageRepWithContentsOfFile:resultfilepath];
    int resultimagerepwidth = (int)[resultimagerep pixelsWide];
    int resultimagerepheight = (int)[resultimagerep pixelsHigh];
    NSImage * resultimage = [[NSImage alloc] initWithContentsOfFile:resultfilepath] ;
    int resultimagewidth = [resultimage size].width;
    int resultimageheight = [resultimage size].height;
    
    float factor = resultimagewidth / brushframe.size.width / curzoomFactor;
    int bgwidth = [_showbg pointbound].size.width * factor;
    int bgheight = [_showbg pointbound].size.height * factor;
    
    //bgwidth = bgheight = 230;
    //factor = 2;
    NSLog(@"debug !!! %d %d %f", bgwidth, bgheight, factor);
    NSBitmapImageRep *mergebg_rep = [[NSBitmapImageRep alloc]
                                     initWithBitmapDataPlanes: NULL
                                     pixelsWide: bgwidth
                                     pixelsHigh: bgheight
                                     bitsPerSample: 8
                                     samplesPerPixel: 4
                                     hasAlpha: YES
                                     isPlanar: NO
                                     colorSpaceName: NSDeviceRGBColorSpace
                                     bytesPerRow: bgwidth * 4
                                     bitsPerPixel: 32];
    NSGraphicsContext *mergebg_ctx = [NSGraphicsContext graphicsContextWithBitmapImageRep: mergebg_rep];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext: mergebg_ctx];
    
    [[_showbg i] drawInRect:NSMakeRect(0, 0, bgwidth * factor, bgheight * factor )];
    [resultimage drawAtPoint: NSZeroPoint fromRect: NSZeroRect operation: NSCompositeSourceOver fraction: 1.0];
    
    
    //NSCompositeSourceOver
    [NSGraphicsContext restoreGraphicsState];
    NSData * imagedata = [mergebg_rep representationUsingType:NSPNGFileType properties:nil];
    [imagedata writeToFile:resultbgfilepath atomically:YES];
}
- (IBAction)changebg:(id)sender {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Set array of file types
    NSArray *fileTypesArray;
    fileTypesArray = [NSArray arrayWithObjects:@"jpg",@"png", @"bmp", @"tiff", @"jpeg",@"gif", nil];
    
    // Enable options in the dialog.
    [openDlg setCanChooseFiles:YES];
    [openDlg setAllowedFileTypes:fileTypesArray];
    [openDlg setAllowsMultipleSelection:FALSE];
    
    if ( [openDlg runModal] == NSModalResponseOK ) {
        
        // Gets list of all files selected
        NSArray *files = [openDlg URLs];
        NSImage * image = [[NSImage alloc] initWithContentsOfFile:[[files firstObject] path]] ;
        [_showbg setI:image];
        [_showbg setBgtype:2];
        [_showbg setNeedsDisplay:YES];
    }
}

- (IBAction)changetransparent:(id)sender {
    NSImage * image = [NSImage imageNamed:@"background.png"];
    [_showbg setI:image];
    [_showbg setBgtype:1];
    [_showbg setNeedsDisplay:YES];
}
@end
