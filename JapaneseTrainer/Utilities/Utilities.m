//
//  Utilities.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/25/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities


+ (void)removeBlankFooterTableView:(nonnull UITableView *)tbv {
    tbv.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tbv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

+ (nonnull NSString *)removeAlphabeFromJapaneseString:(nonnull NSString *)original {
    if ([original isEqualToString:kStringEmpty]) {
        return kEmpty;
    } else {
       return [getRegex(kRegExAZ) stringByReplacingMatchesInString:original options:0 range:NSMakeRange(0, [original length]) withTemplate:kEmpty]; 
    }
    
}

/*
 * Detect is search or not
 */
+ (BOOL)isSearchController:(nonnull UISearchController *)searchController {
    if (![searchController.searchBar.text isEqualToString:kEmpty]) {
        return YES;
    } else {
        return NO;
    }
}

/*
 * Convert Object String
 */
+ (nonnull NSString *)convertString:(nonnull NSString *)strWord {
    
    if (strWord.length > 0) {
        return strWord;
    } else {
        return kEmpty;
    }

}

+ (nonnull NSDictionary *)parseRawSearchToDict:(nonnull NSString *)original {
    original = [original stringByReplacingOccurrencesOfString:kFirstRawSearchReplace withString:kEmpty];
    original = [original stringByReplacingOccurrencesOfString:kSecondRawSearchReplace withString:kEmpty];
    original = [original stringByConvertingHTMLToPlainText];
    original = [original stringByReplacingOccurrencesOfString:kUnknownCharater1 withString:kEmpty];
    
    NSArray *objects = [original componentsSeparatedByString:@"',"];
    NSMutableDictionary *dictResponse = [[NSMutableDictionary alloc] init];
    for (NSString *objString in objects) {
        NSArray *arrayKeyValue = [objString componentsSeparatedByString:@":"];
        if (arrayKeyValue.count > 0) {
            NSString *key = arrayKeyValue[0];
            NSString *value = [arrayKeyValue[1] stringByReplacingOccurrencesOfString:kUnknownCharater2 withString:kEmpty];
            [dictResponse setObject:value forKey:key];
        }
    }
    return dictResponse;
}

+ (void)circleButton:(nonnull UIView *)btn {
    btn.layer.cornerRadius = btn.frame.size.height / 2;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = k11132201Color.CGColor;
    btn.layer.borderWidth = 1.0;
}

+ (void)borderView:(UIView *)btn {
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = k11132201Color.CGColor;
    btn.layer.borderWidth = 1.0;
}

+ (nonnull NSAttributedString *)convertStringToNSAttributeString:(nonnull NSString *)original {
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[original
                                                                                     dataUsingEncoding:NSUnicodeStringEncoding]
                                                                            options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                                 documentAttributes:nil error:nil];
    return attributedString;
}

/*
 * Get frame from string
 */
+ (CGRect)getRectFromAttributedString:(nonnull NSAttributedString *)message withWidth:(CGFloat)width {
    CGRect rect = CGRectMake(0,0,0,0);
    rect = [message boundingRectWithSize:CGSizeMake(width, 9999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                        context:nil];
    return rect;
}

/*
 * Get frame from string
 */
+ (CGRect)getRectFromString:(nonnull NSString *)string {
    CGRect rect = CGRectMake(0,0,0,0);
    NSAttributedString *attributedText =
    [[NSAttributedString alloc] initWithString:string
                                    attributes:@{NSFontAttributeName: fontMessage}];

    rect = [attributedText boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 9999)
                                 options:NSStringDrawingUsesLineFragmentOrigin
                                 context:nil];
    return rect;
}

/**
 * Show iToast message for informing.
 * @param message
 */
+ (void)showiToastMessage:(nonnull NSString *)message {
    iToastSettings *theSettings = [iToastSettings getSharedSettings];
    theSettings.duration = 300;
    
    // Prevent crash with null string
    if (message == (id)[NSNull null]) {
        message = kEmpty;
    }
    
    [[[[iToast makeText:message]
       setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
}

+ (void) reloadSectionDU:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation tableView:(UITableView *)tableView {
    NSRange range = NSMakeRange(section, 1);
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    [tableView reloadSections:sectionToReload withRowAnimation:rowAnimation];
}

/*
 * Show dialog
 */
+ (void)showDialogController:(nonnull UIViewController *)dialog withTag:(NSInteger)tag {
    dialog.view.tag = tag;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:dialog.view];
    
}

/*
 * Hide dialog
 */
+ (void)hideDialogController:(nonnull UIViewController *)dialog withTag:(NSInteger)tag {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [[window viewWithTag:tag] removeFromSuperview];
}

/*
 * Change root view controller
 */
+ (void)changeRootViewToTabBar:(UITabBarController *)tabbar andView:(UINavigationController *)controller isTabbar:(BOOL)isTabbar {
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    
    if (isTabbar) {
        
        [UIView transitionWithView:tabbar.view
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            app.window.rootViewController = tabbar;
                        }
                        completion:^(BOOL finished) {
                            
                        }];
    } else {
        
        [UIView transitionWithView:controller.view
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{
                            app.window.rootViewController = controller;
                        }
                        completion:^(BOOL finished) {
                            
                        }];
    }

}


@end
