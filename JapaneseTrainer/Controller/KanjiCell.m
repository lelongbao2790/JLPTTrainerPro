//
//  KanjiCell.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/7/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "KanjiCell.h"

@implementation KanjiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadInformation:(Kanji *)kanji {
    self.lbKunyomi.text = kanji.kunyomi;
    
    NSMutableAttributedString *englishHtml = [[NSMutableAttributedString alloc] initWithData:[[kanji.example stringByAppendingString:kHTMLFontSize15] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [englishHtml addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:1.0] range:NSMakeRange(0, englishHtml.length)];
    self.lbExample.attributedText = englishHtml;
}

@end
