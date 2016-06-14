//
//  GrammarCell.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/6/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "GrammarCell.h"

@implementation GrammarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.subView.layer.cornerRadius = 20;
    self.subView.layer.masksToBounds = YES;
    self.subView.layer.borderColor = k11132201Color.CGColor;
    self.subView.layer.borderWidth = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
