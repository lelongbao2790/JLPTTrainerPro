//
//  Utilities.h
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/25/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+ (void)removeBlankFooterTableView:(nonnull UITableView *)tbv;
+ (nonnull NSString *)removeAlphabeFromJapaneseString:(nonnull NSString *)original;
/*
 * Detect is search or not
 */
+ (BOOL)isSearchController:(nonnull UISearchController *)searchController;

/*
 * Convert Object String
 */
+ (nonnull NSString *)convertString:(nonnull NSString *)strWord;

+ (nonnull NSDictionary *)parseRawSearchToDict:(nonnull NSString *)original;
+ (void)circleButton:(nonnull UIView *)btn;

+ (void)borderView:(nonnull UIView *)btn;

+ (nonnull NSAttributedString *)convertStringToNSAttributeString:(nonnull NSString *)original;

/*
 * Get frame from string
 */
+ (CGRect)getRectFromAttributedString:(nonnull NSAttributedString *)message withWidth:(CGFloat)width;

/*
 * Get frame from string
 */
+ (CGRect)getRectFromString:(nonnull NSString *)string;

/**
 * Show iToast message for informing.
 * @param message
 */
+ (void)showiToastMessage:(nonnull NSString *)message;

+ (void) reloadSectionDU:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation tableView:(UITableView *)tableView;

/*
 * Show dialog
 */
+ (void)showDialogController:(nonnull UIViewController *)dialog withTag:(NSInteger)tag;

/*
 * Hide dialog
 */
+ (void)hideDialogController:(nonnull UIViewController *)dialog withTag:(NSInteger)tag;

/*
 * Change root view controller
 */
+ (void)changeRootViewToTabBar:(UITabBarController *)tabbar andView:(UINavigationController *)controller isTabbar:(BOOL)isTabbar;
@end
