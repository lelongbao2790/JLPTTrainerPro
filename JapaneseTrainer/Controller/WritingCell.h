//
//  WritingCell.h
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/27/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kanji.h"
@interface WritingCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbRomanji;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

- (void)setInformationCell:(BOOL)isHidden atIndexPath:(NSIndexPath *)indexPath andList:(NSArray *)list;

@end
