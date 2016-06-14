//
//  DataAccess.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 5/31/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "DataAccess.h"

@implementation DataAccess

//*****************************************************************************
#pragma mark -
#pragma mark ** Singleton object **
+ (DataAccess *)shared {
    static dispatch_once_t once;
    static DataAccess *share;
    dispatch_once(&once, ^{
        share = [[self alloc] init];
    });
    return share;
}

- (NSArray *)listVocabularyByLevel:(NSInteger)level {
    NSMutableArray *listVoca = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Vocabulary query]
                        whereWithFormat:@"level = %d", (int)level]
                      fetch];
    
    if (r.count > 0) {
        
        for (Vocabulary *voca in r) {
            [listVoca addObject:voca];
        }
        
        return listVoca;
    }
    else
        return nil;
}

- (NSArray *)listVocabularyRelated:(NSString *)nameRelated {
    NSMutableArray *listVoca = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Vocabulary query]
                       whereWithFormat:@"nameVocabularyRelated = %@", nameRelated]
                      fetch];
    
    if (r.count > 0) {
        for (Vocabulary *voca in r) {
            [listVoca addObject:voca];
        }
        
        return listVoca;
    }
    else
        return nil;
}


- (NSArray *)listGrammarRelated:(NSString *)nameRelated {
    NSMutableArray *listGrammar = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Grammar query]
                       whereWithFormat:@"nameGrammarRelated = %@", nameRelated]
                      fetch];
    
    if (r.count > 0) {
        for (Grammar *voca in r) {
            [listGrammar addObject:voca];
        }
        
        return listGrammar;
    }
    else
        return nil;
}

- (NSArray *)listKanjiRelated:(NSString *)nameRelated {
    NSMutableArray *listKanji= [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Kanji query]
                       whereWithFormat:@"nameKanjiRelated = %@", nameRelated]
                      fetch];
    
    if (r.count > 0) {
        for (Kanji *voca in r) {
            [listKanji addObject:voca];
        }
        
        return listKanji;
    }
    else
        return nil;
}

- (NSArray *)listNoteRelated:(NSString *)nameRelated {
    NSMutableArray *listNote = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Note query]
                       whereWithFormat:@"nameRelate = %@", nameRelated]
                      fetch];
    
    if (r.count > 0) {
        for (Note *voca in r) {
            [listNote addObject:voca];
        }
        
        return listNote;
    }
    else
        return nil;
}

- (NSArray *)listBookMarkVocabulary {
     NSMutableArray *listVoca = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Vocabulary query]
                       whereWithFormat:@"isBookmark = 1"]
                      fetch];
    
    if (r.count > 0) {
        for (Vocabulary *voca in r) {
            [listVoca addObject:voca];
        }
        
        return listVoca;
    }
    else
        return nil;
}

- (NSArray *)listBookMarkGrammar {
    NSMutableArray *listGrammar = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Grammar query]
                       whereWithFormat:@"isBookmark = 1"]
                      fetch];
    
    if (r.count > 0) {
        for (Grammar *voca in r) {
            [listGrammar addObject:voca];
        }
        
        return listGrammar;
    }
    else
        return nil;
}

- (NSArray *)listBookMarkKanji {
    NSMutableArray *listKanji = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Kanji query]
                       whereWithFormat:@"isBookmark = 1"]
                      fetch];
    
    if (r.count > 0) {
        for (Kanji *voca in r) {
            [listKanji addObject:voca];
        }
        
        return listKanji;
    }
    else
        return nil;
}

- (NSArray *)listHistoryVocabulary {
    NSMutableArray *listVoca = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Vocabulary query]
                       whereWithFormat:@"isHistory = 1"]
                      fetch];
    
    if (r.count > 0) {
        for (Vocabulary *voca in r) {
            [listVoca addObject:voca];
        }
        
        return listVoca;
    }
    else
        return nil;
}

- (NSArray *)listHistoryGrammar {
    NSMutableArray *listGrammar = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Grammar query]
                       whereWithFormat:@"isHistory = 1"]
                      fetch];
    
    if (r.count > 0) {
        for (Grammar *voca in r) {
            [listGrammar addObject:voca];
        }
        
        return listGrammar;
    }
    else
        return nil;
}

- (NSArray *)listHistoryKanji {
    NSMutableArray *listKanji = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Kanji query]
                       whereWithFormat:@"isHistory = 1"]
                      fetch];
    
    if (r.count > 0) {
        for (Kanji *voca in r) {
            [listKanji addObject:voca];
        }
        
        return listKanji;
    }
    else
        return nil;
}

- (NSArray *)listGrammarByLevel:(NSInteger)level {
    NSMutableArray *listGrammar = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Grammar query]
                       whereWithFormat:@"level = %d", (int)level]
                      fetch];
    
    if (r.count > 0) {
        for (Grammar *voca in r) {
            [listGrammar addObject:voca];
        }
        
        return listGrammar;
    }
    else
        return nil;
}

- (NSArray *)listKanjiByLevel:(NSInteger)level {
    NSMutableArray *listKanji = [[NSMutableArray alloc] init];
    DBResultSet* r = [[[Kanji query]
                       whereWithFormat:@"level = %d", (int)level]
                      fetch];
    
    if (r.count > 0) {
        for (Kanji *voca in r) {
            [listKanji addObject:voca];
        }
        
        return listKanji;
    }
    else
        return nil;
}

@end
