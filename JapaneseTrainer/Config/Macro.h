//
//  Macro.h
//  HDOnline
//
//  Created by Bao (Brian) L. LE on 5/6/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#ifndef Macro_h
#define Macro_h
#import "AppDelegate.h"
#define ProgressBarShowLoading(_Title_) [SNLoading showWithTitle:_Title_]
#define ProgressBarDismissLoading(_Title_) [SNLoading hideWithTitle:_Title_]
// Init storyboard
#define InitStoryBoardWithIdentifier(identifier) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier]


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// Detect device
#define kDeviceIsPhoneSmallerOrEqual35 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 480.0)
#define kDeviceIsPhoneSmallerOrEqual40 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 568.0)
#define kDeviceIsPhoneSmallerOrEqual47 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 667.0)
#define kDeviceIsPhoneSmallerOrEqual55 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 1104.0)
#define kDeviceIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
// Error
#define errorString(value) [[error localizedDescription] isEqualToString:value]
#define kHTMLFontSize15 [NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>", @"Helvetica Neue",15.0]
#define kHTMLFontSize16 [NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>", @"Helvetica Neue",16.0]
#define kHTMLFontSize18 [NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>", @"Helvetica Neue",18.0]
#define kHTMLFontSize20 [NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>", @"Helvetica Neue",20.0]
#define kHTMLFontSize17 [NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>", @"Helvetica Neue",17.0]
#define getRegex(value) [NSRegularExpression regularExpressionWithPattern:value options:0 error:nil]
#define kRedHTML @"<b style='color:red'>Example<br/><br/></b><b>%d</b><br/> %@ <br/>"
#define kBoldNumberHTML @"\n <b>%d</b><br/> %@<br/>"
#endif /* Macro_h */
