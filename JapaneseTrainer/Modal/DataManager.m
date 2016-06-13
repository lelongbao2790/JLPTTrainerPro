//
//  DataManager.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/25/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
@synthesize getListGrammarDelegate, getDetailDelegate, getVocabularyDelegate, searchWordDelegate, kanjiDelegate, kanjiMeaningDelegate;

//*****************************************************************************
#pragma mark -
#pragma mark ** Singleton object **
+(DataManager *)shared
{
    static dispatch_once_t once;
    static DataManager *share;
    dispatch_once(&once, ^{
        share = [[self alloc] init];
    });
    return share;
}

/*
 * Create init method to init base url
 */
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.manager.requestSerializer setTimeoutInterval:20];
        [self.manager.requestSerializer setValue:@"text/plain"
                         forHTTPHeaderField:@"Content-Type"];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    
    return self;
}

//*****************************************************************************
#pragma mark -
#pragma mark ** Helper Method **

/*
 * GET DATA GRAMMAR
 *
 * @param strUrl url string request
 */
- (void)getGrammarWithUrl:(NSString *)strUrl {
    [self.manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [getListGrammarDelegate getListGrammarAPISuccess:(NSData *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [getListGrammarDelegate getListGrammarAPIFail:[error localizedDescription]];
    }];
}

/*
 * GET DETAIL GRAMMAR
 *
 * @param strUrl url string request
 */
- (void)getDetailGrammarWithUrl:(NSString *)strUrl {
    [self.manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [getDetailDelegate getDetailGrammarAPISuccess:(NSData *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [getDetailDelegate getDetailGrammarAPIFail:[error localizedDescription]];
    }];
}

/*
 * GET VOCABULARY
 *
 * @param strUrl url string request
 */
- (void)getVocabularyWithUrl:(NSString *)strUrl {
    [self.manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [getVocabularyDelegate getVocabularyAPISuccess:(NSData *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [getVocabularyDelegate getVocabularyAPIFail:[error localizedDescription]];
    }];
}

/*
 * SEARCH WORD
 *
 * @param strUrl url string request
 */
- (void)searchVocabularyWithUrl:(NSString *)strUrl {
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [searchWordDelegate searchWordAPISuccess:(NSData *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [searchWordDelegate searchWordAPIFail:[error localizedDescription]];
    }];
}

/*
 * GET KANJI
 *
 * @param strUrl url string request
 */
- (void)getKanjiWithUrl:(NSString *)strUrl {
    [self.manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [kanjiDelegate getKanjiAPISuccess:(NSData *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [kanjiDelegate getKanjiAPIFail:[error localizedDescription]];
    }];
}

/*
 * GET KANJI MEANING
 *
 * @param strUrl url string request
 */
- (void)getKanjiMeaningWithUrl:(NSString *)strUrl {
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [kanjiMeaningDelegate getKanjiMeaningAPISuccess:(NSData *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [kanjiMeaningDelegate getKanjiMeaningAPIFail:[error localizedDescription]];
    }];
}

@end
