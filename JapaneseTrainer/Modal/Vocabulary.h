//
//  Vocabulary.h
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/25/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vocabulary : DBObject

@property (strong, nonatomic) NSString *nameHiragana;
@property (strong, nonatomic) NSString *nameKanji;
@property (strong, nonatomic) NSString *nameEnglish;
@property (strong, nonatomic) NSString *read;
@property (strong, nonatomic) NSString *href;
@property (strong, nonatomic) NSString *rawExample;
@property (strong, nonatomic) NSString *contentExample;
@property (assign, nonatomic) NSInteger level;
@property (strong, nonatomic) NSString *statusWord;
@property (strong, nonatomic) NSString *nameVocabularyRelated;
@property (assign, nonatomic) NSInteger isBookmark;

@end
