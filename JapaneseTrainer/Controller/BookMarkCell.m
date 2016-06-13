//
//  BookMarkCell.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/8/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "BookMarkCell.h"

@implementation BookMarkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInformation:(NSString *)name andImage:(NSString *)imgKey {
    self.lbBookMarkName.text = name;
    [self.imgLeft setImage:[UIImage imageNamed:imgKey]];

}

- (IBAction)btnTrash:(id)sender {
    
    if (self.grammar) {
        if ([self.delegate respondsToSelector:@selector(removeBookMarkGrammar:)]) {
            [self.delegate removeBookMarkGrammar:self.grammar];
        }
    } else if (self.voca) {
        if ([self.delegate respondsToSelector:@selector(removeBookMarkVocabulary:)]) {
            [self.delegate removeBookMarkVocabulary:self.voca];
        }
        
    } else if (self.kanji) {
        if ([self.delegate respondsToSelector:@selector(removeBookMarkKanji:)]) {
            [self.delegate removeBookMarkKanji:self.kanji];
        }
    }
    
}

@end
