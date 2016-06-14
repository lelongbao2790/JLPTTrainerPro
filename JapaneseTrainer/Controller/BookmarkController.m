//
//  BookmarkController.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/8/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "BookmarkController.h"

@interface BookmarkController ()<UITableViewDelegate, UITableViewDataSource, BookMarkCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbNoBookMark;
@property (weak, nonatomic) IBOutlet UITableView *tbvBookmark;
@property (strong, nonatomic) NSMutableArray *listBookMarkGrammar;
@property (strong, nonatomic) NSMutableArray *listBookMarkKanji;
@property (strong, nonatomic) NSMutableArray *listBookMarkVocabulary;
@end

@implementation BookmarkController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self config];
}

- (void)viewDidAppear:(BOOL)animated {
    [self reloadView];
}

- (void)config {
    [Utilities borderView:self.lbNoBookMark];
    self.listBookMarkGrammar = [[NSMutableArray alloc] init];
    self.listBookMarkKanji = [[NSMutableArray alloc] init];
    self.listBookMarkVocabulary = [[NSMutableArray alloc] init];
    
    [Utilities removeBlankFooterTableView:self.tbvBookmark];
}

- (void)reloadView {
    self.listBookMarkVocabulary = [[[DataAccess shared] listBookMarkVocabulary] mutableCopy];
    self.listBookMarkKanji = [[[DataAccess shared] listBookMarkKanji] mutableCopy];
    self.listBookMarkGrammar = [[[DataAccess shared] listBookMarkGrammar] mutableCopy];
    [self.tbvBookmark reloadData];
    
    [self checkBookMark];
}

- (void)checkBookMark {
    if (self.listBookMarkGrammar.count > 0 || self.listBookMarkKanji.count > 0 || self.listBookMarkVocabulary.count > 0) {
        self.lbNoBookMark.hidden = YES;
        self.tbvBookmark.hidden = NO;
    } else if (self.listBookMarkGrammar.count == 0 && self.listBookMarkKanji.count == 0 && self.listBookMarkVocabulary.count == 0) {
        self.lbNoBookMark.hidden = NO;
        self.tbvBookmark.hidden = YES;
    } else {
        self.lbNoBookMark.hidden = YES;
        self.tbvBookmark.hidden = NO;
    }
}

- (IBAction)btnTrash:(id)sender {
    
    for (Kanji *kanji in self.listBookMarkKanji) {
        kanji.isBookmark = kValueBookMark0;
        [kanji commit];
    }
    for (Vocabulary *voca in self.listBookMarkVocabulary) {
        voca.isBookmark = kValueBookMark0;
        [voca commit];
    }
    for (Grammar *grammar in self.listBookMarkGrammar) {
        grammar.isBookmark = kValueBookMark0;
        [grammar commit];
    }
    
    [self reloadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case kSectionVoca:
            return self.listBookMarkVocabulary.count;
            break;
         
        case kSectionKanji:
            return self.listBookMarkKanji.count;
            break;
        
        case kSectionGrammar:
            return self.listBookMarkGrammar.count;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookMarkCell  *cell = [tableView dequeueReusableCellWithIdentifier:kBookMarkIdentifier];
    if(!cell) { cell = [[BookMarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kBookMarkIdentifier];}
    
    switch (indexPath.section) {
        case kSectionVoca: {
            Vocabulary *aVoca = self.listBookMarkVocabulary[indexPath.row];
            cell.voca = aVoca;
            cell.kanji = nil;
            cell.grammar = nil;
            [cell setInformation:aVoca.nameHiragana andImage:kImageVocabulary];
        }
            break;
            
        case kSectionKanji: {
            Kanji *aKanji = self.listBookMarkKanji[indexPath.row];
            cell.kanji = aKanji;
            cell.voca = nil;
            cell.grammar = nil;
            [cell setInformation:aKanji.kanjiWord andImage:kImageKanji];
        }
            break;
            
        case kSectionGrammar: {
            Grammar *aGrammar = self.listBookMarkGrammar[indexPath.row];
            cell.grammar = aGrammar;
            cell.voca = nil;
            cell.kanji = nil;
            [cell setInformation:aGrammar.name andImage:kImageGrammar];
        }
            break;
    }
    
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case kSectionVoca: {
            Vocabulary *aVoca = self.listBookMarkVocabulary[indexPath.row];
            DetailGrammarController *detailGrammar = InitStoryBoardWithIdentifier(kDetailGrammarStoryBoardID);
            detailGrammar.aVocabulary = aVoca;
            [self.navigationController pushViewController:detailGrammar animated:YES];
        }
            break;
            
        case kSectionKanji: {
            Kanji *aKanji = self.listBookMarkKanji[indexPath.row];
            KanjiController *kanjiController = InitStoryBoardWithIdentifier(kKanjiController);
            kanjiController.word = aKanji;
            [Utilities showDialogController:kanjiController withTag:kTagWritingController];
        }
            break;
            
        case kSectionGrammar: {
            Grammar *aGrammar = self.listBookMarkGrammar[indexPath.row];
            DetailGrammarController *detailGrammar = InitStoryBoardWithIdentifier(kDetailGrammarStoryBoardID);
            detailGrammar.aGrammar = aGrammar;
            [self.navigationController pushViewController:detailGrammar animated:YES];
        }
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case kSectionVoca: {
            if (self.listBookMarkVocabulary.count > 0) {
                return kVocabularyTitle;
            } else {
                return kEmpty;
            }
        }
            break;
            
        case kSectionKanji: {
            if (self.listBookMarkKanji.count > 0) {
                return kKanjiTitle;
            } else {
                return kEmpty;
            }
        }
            break;
            
        case kSectionGrammar: {
            if (self.listBookMarkGrammar.count > 0) {
                return kGrammarTitle;
            } else {
                return kEmpty;
            }
        }
            break;
            
        default:
            return kEmpty;
            break;
    }
}

#pragma mark - Book Mark Delegate
- (void)removeBookMarkKanji:(Kanji *)kanji {
    kanji.isBookmark = kValueBookMark0;
    [self.listBookMarkKanji removeObject:kanji];
    [kanji commit];
    [Utilities reloadSectionDU:kSectionKanji withRowAnimation:UITableViewRowAnimationNone tableView:self.tbvBookmark];
    
     [self checkBookMark];
}

- (void)removeBookMarkVocabulary:(Vocabulary *)vocabulary {
    vocabulary.isBookmark = kValueBookMark0;
    [vocabulary commit];
    [self.listBookMarkVocabulary removeObject:vocabulary];
    
     [Utilities reloadSectionDU:kSectionVoca withRowAnimation:UITableViewRowAnimationNone tableView:self.tbvBookmark];
    
     [self checkBookMark];
}

- (void)removeBookMarkGrammar:(Grammar *)grammar {
    grammar.isBookmark = kValueBookMark0;
    [self.listBookMarkGrammar removeObject:grammar];
    [grammar commit];
    [Utilities reloadSectionDU:kSectionGrammar withRowAnimation:UITableViewRowAnimationNone tableView:self.tbvBookmark];
    
     [self checkBookMark];
}

@end
