//
//  MeaningCell.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/6/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "MeaningCell.h"

@implementation MeaningCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadInformationMeaning:(Vocabulary *)voca {
    self.lbStatus.text = voca.statusWord;
    self.lbHiragana.text = voca.nameHiragana;
    self.lbEnglishMeaning.attributedText = [Utilities convertStringToNSAttributeString:[voca.nameEnglish stringByAppendingString:kHTMLFontSize17]];
}

@end
