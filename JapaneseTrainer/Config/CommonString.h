//
//  CommonString.h
//  HDOnline
//
//  Created by Bao (Brian) L. LE on 5/6/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#ifndef CommonString_h
#define CommonString_h

// Font
#define fontMessage [UIFont fontWithName:@"Helvetica" size:17]

// List Content
static NSString *kContentCellIdentifier = @"ContentCellIdentifier";
static NSString *kIdentifierGrammar = @"grammarIdentifier";
static NSString *kIdentifierListGrammar = @"listGrammarIdentifier";
static NSString *kVocabularyIdentifier = @"VocabularCellIdentifier";
static NSString *kMeaningCellIdentifier = @"MeaningCellIdentifier";
static NSString *kExampleCellIdentifier = @"ExampleCellIdentifier";
static NSString *kNoteIdentifier = @"NoteIdentifier";
static NSString *kKanjiCellIdentifier = @"KanjiCellIdentifier";
static NSString *kBookMarkIdentifier = @"BookMarkCellIdentifier";

// Vocabulary
static NSString *kVocabularyLevelN5 = @"JLPT Level N5";
static NSString *kVocabularyLevelN4 = @"JLPT Level N4";
static NSString *kVocabularyLevelN3 = @"JLPT Level N3";
static NSString *kVocabularyLevelN2 = @"JLPT Level N2";
static NSString *kVocabularyLevelN1 = @"JLPT Level N1";
static NSString *kSearchWord = @"Search word";
static NSString *kBookMarkSaved = @"Bookmarks have saved";
static NSString *kBookMarknotSaved = @"Bookmarks have removed";
static NSString *kVocabularyTitle = @"VOCABULARY";
static NSString *kGrammarTitle = @"GRAMMAR";
static NSString *kKanjiTitle = @"KANJI";

// PLIST
static NSString *kObjects = @"Objects";
static NSString *kName = @"Name";
static NSString *kGrammar = @"grammar";
static NSString *kVocabulary = @"vocabulary";
static NSString *kListening = @"listening";
static NSString *kWriting = @"writing";
static NSString *kNamePlist = @"listcontent";
static NSString *kPlist = @"plist";
static NSString *kNameDB = @"dbJapaneseTrainer";
static NSString *kLink = @"Link";
static NSString *kLoading = @"Loading";
static NSString *kEmpty = @"";
static NSString *kStringEmpty = @"emptyString";
static NSString *kHiragana = @"Hiragana";
static NSString *kKatagana = @"Katagana";
static NSString *kHiraganaKey = @"hiragana";
static NSString *kRomanjiKey = @"romanji";
static NSString *kImageKey = @"image";
static NSString *kAddNote = @"Add note";
static NSString *kErrorInputNote = @"Please input notes";
static NSString *kNoteSuccess = @"Your note has been successfully saved";
// Detail grammar
static NSString *kMeaningTitle = @"MEANING";
static NSString *kNoteTitle = @"NOTES";
static NSString *kExampleTitle = @"EXAMPLES";

// Fixed auto layout for multiple device
static NSString *kFixAutoLayoutForIp4 = @"fixAutolayoutFor35";
static NSString *kFixAutoLayoutForIp5 = @"fixAutolayoutFor40";
static NSString *kFixAutoLayoutForIp6 = @"fixAutolayoutFor47";
static NSString *kFixAutoLayoutForIp6Plus = @"fixAutolayoutFor55";
static NSString *kFixAutoLayoutForIpad = @"fixAutolayoutForIpad";

// Parse HTMl
static NSString *kHref = @"href";
static NSString *kQueryListGrammar = @"//a[@class='nounderline']";
static NSString *kQueryListVocabulary = @"//a[@class='nounderline']";
static NSString *kQueryDetailGrammar = @"//div[@id='contentright']/ul/li";
static NSString *kTagTdEmpty = @"<td></td>";
static NSString *kTagTdReplace = @"<td><a class=\"nounderline\" href=\"/jlpt/skills/vocab/sentences/?vocabid=77206\">emptyString</a></td>";


static NSString *kMeaningKanjiTag = @"//p[@class='k-meaning']";
static NSString *kReadingKanjiTag = @"//p[@class='k-readings']";
static NSString *kDrawKanjiTag = @"//div[@class='k-sod']";
static NSString *kExampleKanjiTag = @"//table[@class='k-compounds-table']/tbody/tr";
static NSString *kListDetailGrammarTag = @"//a[@class='btn btn-link entry-menu'";
static NSString *kKanjiSpanKana = @"//span[@class='kana']/b";

//static NSString *kQuerySearch = @"//a[@class='btn btn-link entry-menu']";
static NSString *kQuerySearch = @"//div[@class='entry']";
static NSString *kSpanPos = @"//span[@class='pos']";
static NSString *kFirstRawSearchReplace = @"<a class=\"btn btn-link entry-menu\" onclick=\"entryMenu(this,{";
static NSString *kSecondRawSearchReplace = @"},&#10;&#9;&#9;this);\"><i class=\"icon-plus-sign\"/></a>";
static NSString *kUnknownCharater1 = @"\n\t\t";
static NSString *kUnknownCharater2 = @"'";

// Regex
static NSString *kRegExAZ = @"()";
static NSString *kFeedbackTitle = @"Feedback";
static NSString *kJLPTProTitle = @"JLPT Trainer Pro";
static NSString *kEmailAuthor = @"lelongbao2790@gmail.com";
static NSString *kMessageAlert = @"Do you want to attach screenshot image for feedback.";
static NSString *kOK = @"YES";
static NSString *kCancel = @"NO";
static NSString *kAppID = @"1123870559";
#define kItune @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
#define kItune7 @"itms-apps://itunes.apple.com/app/id%@"

// Search Parse
static NSString *kW = @"w";
static NSString *kK = @"k";
static NSString *kM = @"m";
static NSString *kR = @"r";
static NSString *kDD =  @"dd";
static NSString *kA =  @"a";

#endif /* CommonString_h */
