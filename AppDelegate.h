//
//  AppDelegate.h
//  easybackgroundremove
//
//  Created by xusea on 15/11/13.
//  Copyright © 2015年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "matt.h"
#import "brushview.h"
#import "progresswindow.h"
#import "CTCSlider.h"
#import "CTCSliderCell.h"
#import "SynchroScrollView.h"
#import "resizebound.h"
#import "backgroundbound.h"
#import "util.h"
#import "shellview.h"
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSString * imagepath;
    NSString * pngfilepath;
    NSString * pngresultfilepath;
    NSString * pngresultfileimerodepath;
    NSString * resultfilepath;
    NSString * resultbgfilepath;
    NSString * hash_magic;
    progresswindow * pw;
    NSThread* trans_progress;
    NSThread* trans_modal;
    int flag;
    int g_progress;
    int maxarea;
    int posx;
    int posy;
    NSMutableArray * areaset;
    int showid;
    NSLock *lock;
    NSMutableArray * imagemap;
    float dpi;
    NSRect modelRect;
    NSRect leftRect;
    NSRect rightRect;
    NSRect brushRect;
    NSRect brushframe;
    //NSImageView *_showresult;
    //resizebound *_showresult;
    //NSImageView *_showorg;
    //NSImageView *_showbg;
    //backgroundbound *_showbg;
    //resizebound * _showbg;
    float zoomFactor;
    float maxzoomFactor;
    float curzoomFactor;
    
}
@property (readwrite) float zoomFactor;
@property (readwrite) float maxzoomFactor;
@property (readwrite) float curzoomFactor;
@property (readwrite) NSImageView * _showorg;
//@property  NSImageView * _showresult;
@property(readwrite) resizebound * _showresult;
//@property (readwrite) NSImageView * _showbg;
@property(readwrite) backgroundbound * _showbg;
//@property(readwrite) resizebound *_showbg;
@property (readwrite) NSString * imagepath;
@property (readwrite) NSString * pngfilepath;
@property (readwrite) NSString * pngresultfilepath;
@property (readwrite) NSString * resultfilepath;
@property (readwrite) NSString * resultbgfilepath;
@property (readwrite) NSString * pngresultfileimerodepath;
@property (readwrite) NSString * hash_magic;
@property (readwrite) progresswindow * pw;
@property (readwrite) int flag;
@property (readwrite) int g_progress;
@property(readwrite) int maxarea;
@property(readwrite) int posx;
@property(readwrite) int posy;
@property(readwrite) NSMutableArray * areaset;
@property(readwrite) int showid;
@property(readwrite) float dpi;
@property (readwrite) NSMutableArray * imagemap;
@property(readwrite) NSRect modelRect;
@property(readwrite) NSRect leftRect;
@property(readwrite) NSRect rightRect;
@property(readwrite) NSRect brushRect;
@property(readwrite) NSRect brushframe;
- (IBAction)openimage:(id)sender;
- (IBAction)saveimage:(id)sender;
- (IBAction)savealpha:(id)sender;
@property (weak) IBOutlet NSSlider *showbrushsize;
- (IBAction)changebrushsize:(id)sender;
- (IBAction)drawout:(id)sender;
- (IBAction)drawin:(id)sender;
//@property (weak) IBOutlet NSImageView *showresult;
@property (weak) IBOutlet NSImageView *showorg;
@property (weak) IBOutlet brushview *showbrush;
@property (weak) IBOutlet NSButton *showdrawout;
@property (weak) IBOutlet NSButton *showdrawin;
- (IBAction)matting:(id)sender;

- (IBAction)callremovepath:(id)sender;
- (IBAction)callundo:(id)sender;
- (IBAction)callredo:(id)sender;

- (IBAction)callmodal:(id)sender;
-(void)run_trans;
-(void)run_modal;
- (void)matt_internal;
-(void)depthsearch:(int **) map posx:(int) i posy:(int)j width:(int)w height:(int)h value:(int)v;
-(void)breadthsearch:(int **) map posx:(int) i posy:(int)j width:(int)w height:(int)h value:(int)v;
-(void)bfs:(int)i posy:(int)j width:(int)w height:(int)h value:(int)v;
//@property (weak) IBOutlet NSImageView *showbg;
@property (weak) IBOutlet NSButton *showopen;
@property (weak) IBOutlet NSButton *showsave;
@property (weak) IBOutlet NSButton *showout;
@property (weak) IBOutlet NSButton *showin;
@property (weak) IBOutlet NSButton *showclear;
@property (weak) IBOutlet NSSlider *showchangesize;
@property (weak) IBOutlet NSButton *showundo;
@property (weak) IBOutlet NSButton *showredo;
@property (weak) IBOutlet NSButton *showmatting;
@property (weak) IBOutlet CTCSlider *showbsize;

- (IBAction)gethelp:(id)sender ;
- (IBAction)menureopen:(id)sender ;
@property (weak) IBOutlet SynchroScrollView *leftview;
@property (weak) IBOutlet SynchroScrollView *rightview;
@property (weak) IBOutlet SynchroScrollView *scrollbrushview;
- (IBAction)zoomin:(id)sender;
- (IBAction)zoomout:(id)sender;
@property (weak) IBOutlet SynchroScrollView *scrollbgview;
- (IBAction)debug:(id)sender;
@property (weak) IBOutlet NSButton *showzoomout;
@property (weak) IBOutlet NSButton *showzoomin;
@property (weak) IBOutlet shellview *leftshellview;
@property (weak) IBOutlet shellview *rightshellview;
@property (weak) IBOutlet resizebound *showresult;
@property (weak) IBOutlet backgroundbound *showbg;
@property (weak) IBOutlet shellview *leftinnershellview;
@property (weak) IBOutlet NSButton *showchangebg;
- (IBAction)changebg:(id)sender;
- (IBAction)changetransparent:(id)sender;
@property (weak) IBOutlet NSButton *showchangetransparent;

@end

