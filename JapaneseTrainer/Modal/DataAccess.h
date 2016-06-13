//
//  DataAccess.h
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 5/31/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataAccess : NSObject

//*****************************************************************************
#pragma mark -
#pragma mark ** Singleton object **
+ (DataAccess *)shared;

- (NSArray *)listVocabularyByLevel:(NSInteger)level;

- (NSArray *)listVocabularyRelated:(NSString *)nameRelated;

- (NSArray *)listGrammarRelated:(NSString *)nameRelated;

- (NSArray *)listKanjiRelated:(NSString *)nameRelated;

- (NSArray *)listNoteRelated:(NSString *)nameRelated;

- (NSArray *)listBookMarkVocabulary;

- (NSArray *)listBookMarkGrammar;

- (NSArray *)listBookMarkKanji;

- (NSArray *)listGrammarByLevel:(NSInteger)level;

- (NSArray *)listKanjiByLevel:(NSInteger)level;

@end
