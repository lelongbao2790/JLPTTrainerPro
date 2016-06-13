//
//  DataManager.h
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/25/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject {
    NSObject<GetListGrammarDelegate> *getListGrammarDelegate;
    NSObject<GetDetailGrammarDelegate> *getDetailDelegate;
    NSObject<GetVocabularyDelegate> *getVocabularyDelegate;
    NSObject<SearchWordDelegate> *searchWordDelegate;
    NSObject<KanjiDelegate> *kanjiDelegate;
    NSObject<KanjiMeaningDelegate> *kanjiMeaningDelegate;
}

// Init request operation manager
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong, nonatomic) NSObject *getListGrammarDelegate;
@property (strong, nonatomic) NSObject *getDetailDelegate;
@property (strong, nonatomic) NSObject *getVocabularyDelegate;
@property (strong, nonatomic) NSObject *searchWordDelegate;
@property (strong, nonatomic) NSObject *kanjiDelegate;
@property (strong, nonatomic) NSObject *kanjiMeaningDelegate;

//*****************************************************************************
#pragma mark -
#pragma mark ** Singleton object **
+ (DataManager *)shared;

//*****************************************************************************
#pragma mark -
#pragma mark ** Helper Method **

/*
 * GET DATA GRAMMAR
 *
 * @param strUrl url string request
 */
- (void)getGrammarWithUrl:(NSString *)strUrl;

/*
 * GET DETAIL GRAMMAR
 *
 * @param strUrl url string request
 */
- (void)getDetailGrammarWithUrl:(NSString *)strUrl;

/*
 * GET VOCABULARY
 *
 * @param strUrl url string request
 */
- (void)getVocabularyWithUrl:(NSString *)strUrl;

/*
 * SEARCH WORD
 *
 * @param strUrl url string request
 */
- (void)searchVocabularyWithUrl:(NSString *)strUrl;

/*
 * GET KANJI
 *
 * @param strUrl url string request
 */
- (void)getKanjiWithUrl:(NSString *)strUrl;

/*
 * GET KANJI MEANING
 *
 * @param strUrl url string request
 */
- (void)getKanjiMeaningWithUrl:(NSString *)strUrl;

@end
