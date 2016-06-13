//
//  Grammar.h
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/25/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Grammar : DBObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *href;
@property (assign, nonatomic) NSInteger level;
@property (strong, nonatomic) NSString *rawExample;
@property (strong, nonatomic) NSString *nameGrammarRelated;
@property (assign, nonatomic) NSInteger isBookmark;

@end
