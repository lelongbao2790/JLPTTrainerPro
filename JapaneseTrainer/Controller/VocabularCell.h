//
//  VocabularCell.h
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/25/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VocabularCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbKanji;
@property (weak, nonatomic) IBOutlet UILabel *lbHiragana;
@property (weak, nonatomic) IBOutlet UILabel *lbEnglish;
@property (weak, nonatomic) IBOutlet UIButton *btnSound;
@property (strong, nonatomic) Vocabulary *aVocabulary;
@property (weak, nonatomic) IBOutlet UIView *subView;

- (void)loadInformation:(BOOL)isSearch;

@end
