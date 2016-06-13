//
//  UIDelegate.h
//  HDOnline
//
//  Created by Bao (Brian) L. LE on 5/9/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#ifndef UIDelegate_h
#define UIDelegate_h
#import <Foundation/Foundation.h>
/*
 * Request Get List Grammar Delegate
 */
@protocol GetListGrammarDelegate
@optional
-(void) getListGrammarAPISuccess:(NSData *)response;
-(void) getListGrammarAPIFail:(NSString *)resultMessage;
@end

/*
 * Request Get Detail Grammar Delegate
 */
@protocol GetDetailGrammarDelegate
@optional
-(void) getDetailGrammarAPISuccess:(NSData *)response;
-(void) getDetailGrammarAPIFail:(NSString *)resultMessage;
@end

/*
 * Request Get Vocabulary Delegate
 */
@protocol GetVocabularyDelegate
@optional
-(void) getVocabularyAPISuccess:(NSData *)response;
-(void) getVocabularyAPIFail:(NSString *)resultMessage;
@end

/*
 * Request Search Vocabulary Delegate
 */
@protocol SearchWordDelegate
@optional
-(void) searchWordAPISuccess:(NSData *)response;
-(void) searchWordAPIFail:(NSString *)resultMessage;
@end

/*
 * Kanji Delegate
 */
@protocol KanjiDelegate
@optional
-(void) getKanjiAPISuccess:(NSData *)response;
-(void) getKanjiAPIFail:(NSString *)resultMessage;
@end

/*
 * Kanji Meaning Delegate
 */
@protocol KanjiMeaningDelegate
@optional
-(void) getKanjiMeaningAPISuccess:(NSData *)response;
-(void) getKanjiMeaningAPIFail:(NSString *)resultMessage;
@end


#endif /* UIDelegate_h */
