#import <Preferences/Preferences.h>
#import <SettingsKit/SKListControllerProtocol.h>
#import <SettingsKit/SKTintedListController.h>
#import <SettingsKit/SKSharedHelper.h>
#import <UIKit/UIKit.h>

@interface DroppedPrefsListController: SKTintedListController<SKListControllerProtocol>{
}
@end
@interface DroppedMiloListController: SKTintedListController<SKListControllerProtocol>{
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
-(NSString*) shareMessage { return @"#Dropped by @JamesIscNeutron is an awesome tweak!"; }

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
                 @"footerText": @"When the device hits the ground after falling\nPlease note that it may take up to 30 seconds at most for the event to start working when you enable it. This is hopefully temporary, and is necessary to save battery for the time being."
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
                 @"footerText": @"Creators, credits, and more.",
                 },
             @{
                 @"cell": @"PSLinkListCell",
                 @"label": @"More",
                 @"detail": @"DroppedMiloListController",
                 @"cellClass": @"SKTintedCell",
                 @"icon": @"makers.png",
                 },
/*             @{
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
                 },*/
             ];
}

-(void) openMiloTwitter {
    [SKSharedHelper openTwitter:@"JamesIscNeutron"];
}

-(void)viewSource {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://github.com/MiloSovoy/Dropped"]];
}

-(void)viewFreeFallSource {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/srolfe/tweaks/tree/master/freefall"]];
}
@end

@implementation DroppedMiloListController

-(UIColor*) tintColor {
    return [UIColor colorWithRed:133.0f/255.0f green:80.0f/255.0f blue:229.0f/255.0f alpha:1.0];
}
-(BOOL) tintNavigationTitleText { return YES; }
-(BOOL) showHeartImage { return NO; }
-(NSString*) customTitle { return @"More"; }

-(NSArray*) customSpecifiers
{
    return @[
             @{
                 @"cell": @"PSButtonCell",
                 @"label": @"Made by Milo Darling",
                 @"action": @"openMiloTwitter",
                 @"cellClass": @"SKTintedCell",
                 @"icon": @"makers.png",
                 },
             @{	//Source
                 @"cell": @"PSButtonCell",
                 @"cellClass": @"SKTintedCell",
                 @"label": @"Source Code",
                 @"action": @"viewSource",
                 @"icon": @"github.png",
                 },
             @{
                 @"cell": @"PSGroupCell",
                 @"label": @"Thanks",
                 @"footerText": @"",
                 },
            @{
                 @"cell": @"PSButtonCell",
                 @"label": @"Steve Rolfe's FreeFall",
                 @"cellClass": @"SKTintedCell",
                 @"action": @"viewFreeFallSource",
                 @"icon": @"github.png",
                 },
             @{
                 @"cell": @"PSButtonCell",
                 @"label": @"Uroboro's Help",
                 @"cellClass": @"SKTintedCell",
                 @"action": @"openUroboroTwitter",
                 @"icon": @"makers.png",
                 },
             @{
                 @"cell": @"PSButtonCell",
                 @"label": @"iPhoneDevWiki's Help",
                 @"cellClass": @"SKTintedCell",
                 @"action": @"openDevWiki",
                 @"icon": @"support.png",
                 },
             @{
                 @"cell": @"PSStaticTextCell",
                 @"label": @"Alex Scott for Motivation",
                 @"cellClass": @"SKTintedCell",
                 @"icon": @"star.png",
                 },
             ];
}

-(void) openMiloTwitter {
    [SKSharedHelper openTwitter:@"JamesIscNeutron"];
}

-(void) openUroboroTwitter {
    [SKSharedHelper openTwitter:@"uroboro845"];
}

-(void)viewSource {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://github.com/MiloSovoy/Dropped"]];
}

-(void)viewFreeFallSource {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/srolfe/tweaks/tree/master/freefall"]];
}

-(void)openDevWiki {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://iphonedevwiki.net/"]];
}

-(void) viewActiSound {
    //if they have the repo. Checking for multiple case instances.
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/apt/lists/rcrepo.com_._Packages"] || [[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/apt/lists/Rcrepo.com_._Packages"] || [[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/apt/lists/RCRepo.com_._Packages"] || [[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/apt/lists/RCREPO.com_._Packages"] || [[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/apt/lists/RCREPO.COM_._Packages"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://package/com.milodarling.actisound"]];
    } else {
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Uh oh."
                                                         message:[NSString stringWithFormat:@"It appears you don't have the RCRepo installed. Please add http://rcrepo.com to your Cydia sources to get ActiSound."]
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@"Open Cydia", nil];
        [alert1 show];
        [alert1 release];
    }
}

//Just open cydia, because the new Cydia doesn't support cydia://sources/add/ :(
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView firstOtherButtonIndex]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://"]];
    }
}

@end