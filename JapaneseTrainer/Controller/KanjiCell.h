//
//  KanjiCell.h
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/7/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KanjiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbKunyomi;
@property (weak, nonatomic) IBOutlet UILabel *lbExample;

- (void)loadInformation:(Kanji *)kanji;

@end
