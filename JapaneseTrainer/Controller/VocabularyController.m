//
//  VocabularyController.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/23/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "VocabularyController.h"

@interface VocabularyController () <UITableViewDelegate, UITableViewDataSource, GetVocabularyDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,SearchWordDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segLevel;
@property (strong, nonatomic) NSMutableArray *listVocabulary;
@property (strong, nonatomic) NSMutableArray *listSearch;
@property (weak, nonatomic) IBOutlet UITableView *tbvVocabulary;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation VocabularyController

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
    [DataManager shared].getVocabularyDelegate = self;
    [DataManager shared].searchWordDelegate = self;
    [self segLevel:nil];
}

- (void)requestGetVocabulary:(NSArray *)listVoca andLevel:(NSString *)level {
    [self.listVocabulary removeAllObjects];
    [self.tbvVocabulary reloadData];
    
    NSArray *listVocabularyLocal = [[NSArray alloc] init];
    listVocabularyLocal = [[DataAccess shared] listVocabularyByLevel:self.segLevel.selectedSegmentIndex + 1];
    if (listVocabularyLocal.count > 0) {
        self.listVocabulary = [listVocabularyLocal mutableCopy];
        [self.tbvVocabulary reloadData];
    } else {
        for (NSDictionary *dictVoca in listVoca) {
            NSString *name = [dictVoca objectForKey:kName];
            NSString *link = [dictVoca objectForKey:kLink];
            if ([name isEqualToString:level]) {
                ProgressBarShowLoading(kLoading);
                [[DataManager shared] getVocabularyWithUrl:link];
                break;
            }
        }
    }
}

#pragma mark - Helper Method

/*
 * Init search controller
 */
- (void)initSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = kSearchWord;
    self.searchController.searchBar.scopeButtonTitles = [NSArray array];
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    self.searchController.searchBar.barTintColor = k11132201Color;
    self.tbvVocabulary.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
}


- (void)config {
    
    self.listVocabulary = [[NSMutableArray alloc] init];
    self.listSearch = [[NSMutableArray alloc] init];
    [self initSearchController];
    [Utilities removeBlankFooterTableView:self.tbvVocabulary];
    
}

- (IBAction)segLevel:(id)sender {
    
    NSDictionary *dTmp = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kNamePlist ofType:kPlist]];
    NSArray *listTmp = [dTmp valueForKey:kObjects];
    NSMutableArray *listObjects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictItem in listTmp) {
        if ([[dictItem objectForKey:kName] isEqualToString:kVocabulary]) {
            [listObjects addObjectsFromArray:[dictItem valueForKey:kObjects]];
            break;
        }
    }
    
    // Switch level
    switch (self.segLevel.selectedSegmentIndex) {
            
        case kSegLevelN1: {
            [self requestGetVocabulary:listObjects andLevel:kVocabularyLevelN1];
        }
            break;
         
        case kSegLevelN2: {
            [self requestGetVocabulary:listObjects andLevel:kVocabularyLevelN2];
        }
            break;
            
        case kSegLevelN3: {
            [self requestGetVocabulary:listObjects andLevel:kVocabularyLevelN3];
        }
            break;
            
        case kSegLevelN4: {
            [self requestGetVocabulary:listObjects andLevel:kVocabularyLevelN4];
        }
            break;
            
        case kSegLevelN5: {
            [self requestGetVocabulary:listObjects andLevel:kVocabularyLevelN5];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Table View Data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([Utilities isSearchController:self.searchController]) {
        
       return self.listSearch.count;
        
    } else {
        
       return self.listVocabulary.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VocabularCell  *cell = [tableView dequeueReusableCellWithIdentifier:kVocabularyIdentifier];
    if(!cell) { cell = [[VocabularCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kVocabularyIdentifier];}
    
    if ([Utilities isSearchController:self.searchController]) {
        cell.aVocabulary = self.listSearch[indexPath.row];
        [cell loadInformation:YES];
        
    } else {
        cell.aVocabulary = self.listVocabulary[indexPath.row];
        [cell loadInformation:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailGrammarController *detailGrammar = InitStoryBoardWithIdentifier(kDetailGrammarStoryBoardID);
    detailGrammar.title = [self.segLevel titleForSegmentAtIndex:self.segLevel.selectedSegmentIndex];
    Vocabulary *wordAtIndex = nil;
    if ([Utilities isSearchController:self.searchController]) {
        
        wordAtIndex = self.listSearch[indexPath.row];
        
    } else {
        
        wordAtIndex = self.listVocabulary[indexPath.row];
    }
    
    detailGrammar.aVocabulary = wordAtIndex;
    
    [self.navigationController pushViewController:detailGrammar animated:YES];

}

#pragma mark - Get Vocabulary Delegate
- (void)getVocabularyAPISuccess:(NSData *)response {
    ProgressBarDismissLoading(kEmpty);
    
    NSString *final = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    final = [final stringByReplacingOccurrencesOfString:kTagTdEmpty withString:kTagTdReplace];
    NSData *data = [final dataUsingEncoding:NSUTF8StringEncoding];
    
    // Parse Data from HTML
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:data];
    NSArray *grammarNode = [tutorialsParser searchWithXPathQuery:kQueryListVocabulary];
    NSMutableArray *newTutorials = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < grammarNode.count - 3; i = i+3) {
        NSLog(@"%d",i);
        TFHppleElement *element1 = grammarNode[i];
        TFHppleElement *element2 = grammarNode[i+1];
        TFHppleElement *element3 = grammarNode[i+2];
        Vocabulary *newVoca = [Vocabulary new];
        newVoca.nameHiragana = [Utilities removeAlphabeFromJapaneseString:[[element2 firstChild] content]];
        newVoca.nameEnglish = [Utilities removeAlphabeFromJapaneseString:[[element3 firstChild] content]];
        newVoca.nameKanji = [Utilities removeAlphabeFromJapaneseString:[[element1 firstChild] content]];
        newVoca.href = [element1 objectForKey:kHref];
        newVoca.level = self.segLevel.selectedSegmentIndex + 1;
        [newVoca commit];
        [newTutorials addObject:newVoca];
        NSLog(@"%@",newVoca.nameHiragana);

    }
    
    self.listVocabulary = [newTutorials mutableCopy];
    [self.tbvVocabulary reloadData];
    
}

- (void)getVocabularyAPIFail:(NSString *)resultMessage {
    ProgressBarDismissLoading(kEmpty);
}

#pragma mark - Search Word Delegate
- (void)searchWordAPISuccess:(NSData *)response {
    ProgressBarDismissLoading(kEmpty);
    
    // Parse Data from HTML
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:response];
    NSArray *searchNode = [tutorialsParser searchWithXPathQuery:kQuerySearch];
    NSMutableArray *listWordSearch = [[NSMutableArray alloc] init];
    for (TFHppleElement *element in searchNode) {
        
        Vocabulary *newVoca = [Vocabulary new];
        for (TFHppleElement *childElement  in element.children) {
            
            if ([[childElement tagName] isEqualToString:@"dd"]) {
                NSString *rawD = [childElement raw];
                newVoca.rawExample = rawD;
            }
            if ([[childElement tagName] isEqualToString:@"a"]) {
                NSString *rawA = [childElement raw];
                NSDictionary *dictResponse = [Utilities parseRawSearchToDict:rawA];
                
                if (dictResponse.count > 0) {
                    newVoca.nameKanji = [Utilities convertString:[dictResponse objectForKey:kW]];
                    newVoca.nameHiragana = [Utilities convertString:[dictResponse objectForKey:kK]];
                    newVoca.nameEnglish = [Utilities convertString:[dictResponse objectForKey:kM]];
                    newVoca.read = [Utilities convertString:[dictResponse objectForKey:kR]];
                }
            }
            NSLog(@"%@", childElement);
        }
        [listWordSearch addObject:newVoca];
    }
    
    [self.listSearch addObjectsFromArray: listWordSearch];
    [self.tbvVocabulary reloadData];
    
}

- (void)searchWordAPIFail:(NSString *)resultMessage {
    ProgressBarDismissLoading(kEmpty);
}

#pragma mark - Search Method
- (void)searchWord:(NSString *)word {
    ProgressBarShowLoading(kLoading);
    [self.listSearch removeAllObjects];
    [self.tbvVocabulary reloadData];
    
    NSString *searchUrl = [NSString stringWithFormat:@"%@%@",kSearchUrl,word];
    [[DataManager shared] searchVocabularyWithUrl:searchUrl];
    
    // Load more
    NSString *searchMoreUrl = [NSString stringWithFormat:kSearchMoreResult,word];
    [[DataManager shared] searchVocabularyWithUrl:searchMoreUrl];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self.navigationController popToViewController:self animated:YES];
    [self.tbvVocabulary reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self searchWord:searchBar.text];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}


@end
