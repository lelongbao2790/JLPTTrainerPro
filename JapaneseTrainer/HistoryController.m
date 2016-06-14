//
//  HistoryController.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/13/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "HistoryController.h"

@interface HistoryController ()<UITableViewDelegate, UITableViewDataSource, BookMarkCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbvHistory;
@property (strong, nonatomic) NSMutableArray *listHistoryGrammar;
@property (strong, nonatomic) NSMutableArray *listHistoryKanji;
@property (strong, nonatomic) NSMutableArray *listHistoryVocabulary;
@end

@implementation HistoryController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self config];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self reloadView];
}

- (IBAction)btnTrash:(id)sender {
    for (Kanji *kanji in self.listHistoryKanji) {
        kanji.isHistory = kValueBookMark0;
        [kanji commit];
    }
    for (Vocabulary *voca in self.listHistoryVocabulary) {
        voca.isHistory = kValueBookMark0;
        [voca commit];
    }
    for (Grammar *grammar in self.listHistoryGrammar) {
        grammar.isHistory = kValueBookMark0;
        [grammar commit];
    }
    
    [self reloadView];
}

#pragma mark - Helper Method
- (void)config {
    self.listHistoryGrammar = [[NSMutableArray alloc] init];
    self.listHistoryKanji = [[NSMutableArray alloc] init];
    self.listHistoryVocabulary = [[NSMutableArray alloc] init];
    
    [Utilities removeBlankFooterTableView:self.tbvHistory];
}

- (void)reloadView {
    self.listHistoryVocabulary = [[[DataAccess shared] listHistoryVocabulary] mutableCopy];
    self.listHistoryKanji = [[[DataAccess shared] listHistoryKanji] mutableCopy];
    self.listHistoryGrammar = [[[DataAccess shared] listHistoryGrammar] mutableCopy];
    [self.tbvHistory reloadData];
}

#pragma mark - Table View Data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case kSectionVoca:
            return self.listHistoryVocabulary.count;
            break;
            
        case kSectionKanji:
            return self.listHistoryKanji.count;
            break;
            
        case kSectionGrammar:
            return self.listHistoryGrammar.count;
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
            Vocabulary *aVoca = self.listHistoryVocabulary[indexPath.row];
            cell.voca = aVoca;
            cell.kanji = nil;
            cell.grammar = nil;
            [cell setInformation:aVoca.nameHiragana andImage:kImageVocabulary];
        }
            break;
            
        case kSectionKanji: {
            Kanji *aKanji = self.listHistoryKanji[indexPath.row];
            cell.kanji = aKanji;
            cell.voca = nil;
            cell.grammar = nil;
            [cell setInformation:aKanji.kanjiWord andImage:kImageKanji];
        }
            break;
            
        case kSectionGrammar: {
            Grammar *aGrammar = self.listHistoryGrammar[indexPath.row];
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
            Vocabulary *aVoca = self.listHistoryVocabulary[indexPath.row];
            DetailGrammarController *detailGrammar = InitStoryBoardWithIdentifier(kDetailGrammarStoryBoardID);
            detailGrammar.aVocabulary = aVoca;
            [self.navigationController pushViewController:detailGrammar animated:YES];
        }
            break;
            
        case kSectionKanji: {
            Kanji *aKanji = self.listHistoryKanji[indexPath.row];
            KanjiController *kanjiController = InitStoryBoardWithIdentifier(kKanjiController);
            kanjiController.word = aKanji;
            [Utilities showDialogController:kanjiController withTag:kTagWritingController];
        }
            break;
            
        case kSectionGrammar: {
            Grammar *aGrammar = self.listHistoryGrammar[indexPath.row];
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
            if (self.listHistoryVocabulary.count > 0) {
                return kVocabularyTitle;
            } else {
                return kEmpty;
            }
        }
            break;
            
        case kSectionKanji: {
            if (self.listHistoryKanji.count > 0) {
                return kKanjiTitle;
            } else {
                return kEmpty;
            }
        }
            break;
            
        case kSectionGrammar: {
            if (self.listHistoryGrammar.count > 0) {
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
    kanji.isHistory = kValueBookMark0;
    [self.listHistoryKanji removeObject:kanji];
    [kanji commit];
    [Utilities reloadSectionDU:kSectionKanji withRowAnimation:UITableViewRowAnimationNone tableView:self.tbvHistory];

}

- (void)removeBookMarkVocabulary:(Vocabulary *)vocabulary {
    vocabulary.isHistory = kValueBookMark0;
    [vocabulary commit];
    [self.listHistoryVocabulary removeObject:vocabulary];
    [Utilities reloadSectionDU:kSectionVoca withRowAnimation:UITableViewRowAnimationNone tableView:self.tbvHistory];
}

- (void)removeBookMarkGrammar:(Grammar *)grammar {
    grammar.isHistory = kValueBookMark0;
    [self.listHistoryGrammar removeObject:grammar];
    [grammar commit];
    [Utilities reloadSectionDU:kSectionGrammar withRowAnimation:UITableViewRowAnimationNone tableView:self.tbvHistory];
}
@end
