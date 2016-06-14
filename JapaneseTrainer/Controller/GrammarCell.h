//
//  GrammarCell.h
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/6/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrammarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbNameGrammar;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberCell;
@property (weak, nonatomic) IBOutlet UIView *subView;

@end
