//
//  Enumeration.h
//  HDOnline
//
//  Created by Bao (Brian) L. LE on 5/6/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#ifndef Enumeration_h
#define Enumeration_h

typedef NS_ENUM(NSInteger, VocabularyLevel) {

    kSegLevelN1 = 0,
    kSegLevelN2 = 1,
    kSegLevelN3 = 2,
    kSegLevelN4 = 3,
    kSegLevelN5 = 4,
};

typedef NS_ENUM(NSInteger, DetailViewText) {
    
    kHeightConstantGrammar = 60,
    kHeightConstantVocabulary = 95,
};

typedef NS_ENUM(NSInteger, WritingSeg) {
    
    kHiraganaSeg = 0,
    kKataganaSeg = 1,
    kKanjiSeg = 2,
    kTopConstantCollectionDefault = 0,
    kTopConstantCollectionKanji = 37,

};

typedef NS_ENUM(NSInteger, KanjiControllerTag) {
    
    kSegInforKanji = 0,
    kSegHowToWrite = 1,
    kConstantSubViewHiragana = 140,
    kConstantSubViewKanji = 15,
};

typedef NS_ENUM(NSInteger, DetailGrammarTag) {
    
    kSectionMeaning = 0,
    kSectionExample = 2,
    kSectionNote = 1,
    kNumberOfSectionDetailGrammar = 3,
    kConstantBetweenTwoTextMeaning = 23,
    kConstantBetweenTwoTextExample = 10,
    kWidthImage = 30,
    kLeadingConstantNote = 10,
};

typedef NS_ENUM(NSInteger, BookMarkTag) {
    kValueBookMark1 = 1,
    kValueBookMark0 = 0,
    kSectionVoca = 0,
    kSectionGrammar = 2,
    kSectionKanji = 1,
    kTagWritingController = 100,
};

#endif /* Enumeration_h */
