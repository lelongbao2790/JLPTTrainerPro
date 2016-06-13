//
//  NSMutableAttributedString+Color.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/26/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "NSMutableAttributedString+Color.h"

@implementation NSMutableAttributedString (Color)
-(void)setColorForText:(NSString*) textToFind withColor:(UIColor*) color
{
    NSRange range = [self.mutableString rangeOfString:textToFind options:NSCaseInsensitiveSearch];
    
    if (range.location != NSNotFound) {
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
}
@end
