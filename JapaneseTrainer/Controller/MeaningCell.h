//
//  MeaningCell.h
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/6/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeaningCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbHiragana;
@property (weak, nonatomic) IBOutlet UILabel *lbEnglishMeaning;

- (void)loadInformationMeaning:(Vocabulary *)voca;

@end
