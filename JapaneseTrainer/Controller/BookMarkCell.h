//
//  BookMarkCell.h
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/8/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BookMarkCellDelegate;

@interface BookMarkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbBookMarkName;
@property (weak, nonatomic) IBOutlet UIImageView *imgLeft;
@property (weak, nonatomic) id<BookMarkCellDelegate> delegate;
@property (strong, nonatomic) Vocabulary *voca;
@property (strong, nonatomic) Grammar *grammar;
@property (strong, nonatomic) Kanji *kanji;

- (void)setInformation:(NSString *)name andImage:(NSString *)imgKey;

@end

@protocol BookMarkCellDelegate<NSObject>
- (void)removeBookMarkGrammar:(Grammar *)grammar;
- (void)removeBookMarkKanji:(Kanji *)kanji;
- (void)removeBookMarkVocabulary:(Vocabulary *)vocabulary;
@end