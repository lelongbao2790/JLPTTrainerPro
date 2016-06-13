//
//  VocabularCell.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/25/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "VocabularCell.h"
#import "NSMutableAttributedString+Color.h"

@implementation VocabularCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.subView.layer.cornerRadius = 5.0;
    self.subView.layer.masksToBounds = NO;
    self.subView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.subView.layer.shadowOffset = CGSizeMake(3, 3);
    self.subView.layer.shadowOpacity = 1;
    self.subView.layer.shadowRadius = 1.0;
    [Utilities circleButton:self.btnSound];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadInformation:(BOOL)isSearch {
    if (isSearch) {
        self.lbHiragana.text = [NSString stringWithFormat:@"Read: %@", [self.aVocabulary.read lowercaseString]];
        
        // Show kanji string
        NSMutableAttributedString *kanjiString;
        if (self.aVocabulary.nameKanji.length > 0) {
            kanjiString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@【 %@ 】", self.aVocabulary.nameHiragana, self.aVocabulary.nameKanji]];
        } else {
            kanjiString = [[NSMutableAttributedString alloc] initWithString:self.aVocabulary.nameHiragana];
        }
        
        [kanjiString setColorForText:self.aVocabulary.nameKanji withColor:kBrownColor];
        self.lbKanji.attributedText = kanjiString;
        
    } else {
        self.lbKanji.text = self.aVocabulary.nameHiragana;
        self.lbHiragana.text = [NSString stringWithFormat:@"Kanji: %@", self.aVocabulary.nameKanji];
    }
    
    NSString *english = [NSString stringWithFormat:@"Meaning: %@", [self.aVocabulary.nameEnglish stringByAppendingString:kHTMLFontSize17]];
    NSMutableAttributedString *englishHtml = [[NSMutableAttributedString alloc] initWithData:[english dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [englishHtml addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, englishHtml.length)];
    self.lbEnglish.attributedText = englishHtml;
    
}
- (IBAction)btnSound:(id)sender {
    [[Sound shared] playSoundWithText:self.aVocabulary.nameHiragana];
}

@end
