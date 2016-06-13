//
//  GrammarController.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/23/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "GrammarController.h"
#import "GrammarCell.h"

@interface GrammarController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *listGrammar;
@property (weak, nonatomic) IBOutlet UITableView *tbvGrammar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *btnSegLevel;

@end

@implementation GrammarController

# pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [DataManager shared].getListGrammarDelegate = self;
    [self config];
}

# pragma mark Helper Method

- (void)config {
    
    self.listGrammar = [[NSMutableArray alloc] init];
    [Utilities removeBlankFooterTableView:self.tbvGrammar];
    [self btnGrammar:nil];
}

- (IBAction)btnGrammar:(id)sender {
    
    NSDictionary *dTmp = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kNamePlist ofType:kPlist]];
    NSArray *listTmp = [dTmp valueForKey:kObjects];
    NSMutableArray *listObjects = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictItem in listTmp) {
        if ([[dictItem objectForKey:kName] isEqualToString:kGrammar]) {
            [listObjects addObjectsFromArray:[dictItem valueForKey:kObjects]];
            break;
        }
    }
    
    // Switch level
    switch (self.btnSegLevel.selectedSegmentIndex) {
            
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

- (void)requestGetVocabulary:(NSArray *)listVoca andLevel:(NSString *)level {
    [self.listGrammar removeAllObjects];
    [self.tbvGrammar reloadData];
    
    NSArray *listVocabularyLocal = [[NSArray alloc] init];
    listVocabularyLocal = [[DataAccess shared] listGrammarByLevel:self.btnSegLevel.selectedSegmentIndex + 1];
    if (listVocabularyLocal.count > 0) {
        
        self.listGrammar = [listVocabularyLocal mutableCopy];
        NSLog(@"%d",(int)self.listGrammar.count);
        [self.tbvGrammar reloadData];
    } else {
        for (NSDictionary *dictVoca in listVoca) {
            NSString *name = [dictVoca objectForKey:kName];
            NSString *link = [dictVoca objectForKey:kLink];
            if ([name isEqualToString:level]) {
                ProgressBarShowLoading(kLoading);
                [[DataManager shared] getGrammarWithUrl:link];
                break;
            }
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listGrammar.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GrammarCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierGrammar forIndexPath:indexPath];
    if(!cell) { cell = [[GrammarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentifierGrammar];}
    Grammar *aGrammar = self.listGrammar[indexPath.section];
    cell.lbNameGrammar.text = aGrammar.name;
    cell.lbNumberCell.text = [NSString stringWithFormat:@"%d",(int)indexPath.section + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailGrammarController *detailGrammar = InitStoryBoardWithIdentifier(kDetailGrammarStoryBoardID);
    detailGrammar.title = [self.btnSegLevel titleForSegmentAtIndex:self.btnSegLevel.selectedSegmentIndex];
    Grammar *aGrammar = self.listGrammar[indexPath.section];
    detailGrammar.aGrammar = aGrammar;
    [self.navigationController pushViewController:detailGrammar animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.; // you can have your own choice, of course
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (GrammarCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
//    if(indexPath.section % 2 == 0) {
//        cell.backgroundColor = k195232251Color;
//    }
//    else {
//        cell.backgroundColor = [UIColor whiteColor];
//    }
    
}

# pragma mark Get List Grammar
- (void)getListGrammarAPISuccess:(NSData *)response {
    ProgressBarDismissLoading(kEmpty);
    
    // Parse Data from HTML
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:response];
    NSArray *grammarNode = [tutorialsParser searchWithXPathQuery:kQueryListGrammar];
    NSMutableArray *newTutorials = [[NSMutableArray alloc] init];
    for (TFHppleElement *element in grammarNode) {
        Grammar *newGrammar = [Grammar new];
        newGrammar.name = [Utilities removeAlphabeFromJapaneseString:[[element firstChild] content]];
        newGrammar.href = [element objectForKey:kHref];
        newGrammar.level = self.btnSegLevel.selectedSegmentIndex + 1;
        [newGrammar commit];
        [newTutorials addObject:newGrammar];
        NSLog(@"%@",newGrammar.name);
    }
    
    [self.listGrammar addObjectsFromArray:newTutorials];
    [self.tbvGrammar reloadData];
}

- (void)getListGrammarAPIFail:(NSString *)resultMessage {
    ProgressBarDismissLoading(kEmpty);
}


@end
