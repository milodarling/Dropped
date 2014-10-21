#import <Preferences/Preferences.h>
#import <SettingsKit/SKListControllerProtocol.h>
#import <SettingsKit/SKTintedListController.h>
#import <SettingsKit/SKSharedHelper.h>
#import <UIKit/UIKit.h>

@interface DroppedPrefsListController: SKTintedListController<SKListControllerProtocol>{
}
@end

@implementation DroppedPrefsListController

// Want a tint color?
 -(UIColor*) tintColor {
    return [UIColor colorWithRed:133.0f/255.0f green:80.0f/255.0f blue:229.0f/255.0f alpha:1.0];
 }
-(BOOL) tintNavigationTitleText { return YES; }

-(BOOL) showHeartImage { return YES; }
-(BOOL) shiftHeartImage { return YES; }
-(NSString*) shareMessage { return @"#Dropped by @JamesIscNeutron is an awful tweak. I hate it."; }

-(NSString*) headerImage { return @"header.png"; }
-(NSString*) customTitle { return @"Dropped"; }
-(NSArray*) customSpecifiers
{
    return @[
             @{
                 @"cell": @"PSGroupCell",
                 @"label": @"Fall Sensitivity"
                 },
             @{
                 @"cell": @"PSSliderCell",
                 @"min": @"0.00",
                 @"max": @"0.10",
                 @"showValue": @YES,
                 @"default": @"0.04",
                 @"defaults": @"com.milodarling.dropped",
                 @"key": @"fallingSensitivity",
                 @"PostNotification": @"com.milodarling.dropped/prefsChanged",
                 @"cellClass": @"SKTintedSliderCell"
                 },
             @{
                 @"cell": @"PSGroupCell",
                 @"label": @"Stop Sensitivity",
                 @"footerText": @"When the device hits the ground after falling"
                 },
             @{
                 @"cell": @"PSSliderCell",
                 @"min": @"5.0",
                 @"max": @"9.8",
                 @"showValue": @YES,
                 @"default": @"6.0",
                 @"defaults": @"com.milodarling.dropped",
                 @"key": @"stoppingSensitivity",
                 @"PostNotification": @"com.milodarling.dropped/prefsChanged",
                 @"cellClass": @"SKTintedSliderCell"
                 },
             @{
                 @"cell": @"PSGroupCell",
                 @"label": @"",
                 @"footerText": @"Please note that it may take up to 30 seconds at most for the event to start working when you enable it. This is hopefully temporary, and is necessary to save battery for the time being.",
                 },
             @{
                 @"cell": @"PSButtonCell",
                 @"label": @"Created by Milo Darling",
                 @"action": @"openMiloTwitter",
                 @"cellClass": @"SKTintedCell",
                 @"icon": @"makers.png",
                 },
             @{
                 @"cell": @"PSButtonCell",
                 @"label": @"Based off Steve Rolfe's FreeFall",
                 @"cellClass": @"SKTintedCell",
                 @"action": @"viewFreeFallSource",
                 @"icon": @"github.png",
                 },
             @{	//Source
                 @"cell": @"PSButtonCell",
                 @"cellClass": @"SKTintedCell",
                 @"label": @"Source Code",
                 @"action": @"viewSource",
                 @"icon": @"github.png",
                 },
             ];
}

-(void) openMiloTwitter
{
    [SKSharedHelper openTwitter:@"JamesIscNeutron"];
}

-(void)viewSource {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://github.com/MiloSovoy/Dropped"]];
}

-(void)viewFreeFallSource {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/srolfe/tweaks/tree/master/freefall"]];
}
@end
