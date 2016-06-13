//
//  WritingCell.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/27/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "WritingCell.h"

@implementation WritingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if ( kDeviceIpad ) {
        /* do something specifically for iPad. */
        self.lbTitle.font = [UIFont systemFontOfSize:40];
    } else {
        /* do something specifically for iPhone or iPod touch. */
        self.lbTitle.font = [UIFont systemFontOfSize:30];
    }
    
}

- (void)setInformationCell:(BOOL)isHidden atIndexPath:(NSIndexPath *)indexPath andList:(NSArray *)list {
    if (isHidden) {
        NSDictionary *dict = list[indexPath.row];
        NSString *hiraganaText = [dict objectForKey:kHiraganaKey];
        
        if (![hiraganaText isEqualToString:kStringEmpty]) {
            self.lbTitle.text = hiraganaText;
            self.lbRomanji.text = [dict objectForKey:kRomanjiKey];
            self.lbRomanji.backgroundColor = [UIColor groupTableViewBackgroundColor];
        } else {
            self.lbTitle.text = kEmpty;
            self.lbRomanji.text = kEmpty;
            self.lbRomanji.backgroundColor = [UIColor clearColor];
        }
        
    } else {
        Kanji *kanji = list[indexPath.row];
        self.lbTitle.text = kanji.kanjiWord;
        self.lbRomanji.text = kEmpty;
        self.lbRomanji.backgroundColor = [UIColor clearColor];
    }
}

@end
