//
//  AlphabetController.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/23/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "AlphabetController.h"
#import "CustomWritingLayout.h"

@interface AlphabetController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, KanjiDelegate>
@property (strong, nonatomic) NSMutableArray *listWriting;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segWriting;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionWriting;
@property (weak, nonatomic) IBOutlet UISegmentedControl *btnSegLevel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csTopCollection;
@end

@implementation AlphabetController

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
    [DataManager shared].kanjiDelegate = self;
    
    [self btnSeg:nil];
}

# pragma mark  Helper Method

- (void)config {
    self.listWriting = [[NSMutableArray alloc] init];
    self.collectionWriting.collectionViewLayout = [[CustomWritingLayout alloc] init];
    [self.collectionWriting registerClass:[WritingCell class] forCellWithReuseIdentifier:kWritingCell];
    [self.collectionWriting reloadData];
    self.csTopCollection.constant = kTopConstantCollectionDefault;
}

- (void)handleContent:(NSString *)key {
    self.csTopCollection.constant = kTopConstantCollectionDefault;
    self.btnSegLevel.hidden = YES;
    [self.listWriting removeAllObjects];
    NSDictionary *dTmp = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:kNamePlist ofType:kPlist]];
    NSArray *listTmp = [dTmp valueForKey:key];
    
    for (int i=0; i<listTmp.count; i++) {
        NSDictionary *dictI = listTmp[i];
        [self.listWriting addObject:dictI];
    }
    
    [self.collectionWriting reloadData];
}

- (IBAction)btnSeg:(id)sender {
    
    // Switch level
    switch (self.segWriting.selectedSegmentIndex) {
            
        case kHiraganaSeg:
          [self handleContent:kHiragana];
          break;
            
        case kKataganaSeg:
          [self handleContent:kKatagana];
          break;
        
        case kKanjiSeg: {
            [self requestKanjiWord:kUrlKanjiN5];
        }
            break;
            
        default:
            [self handleContent:kHiragana];
            break;
    }
    
}
- (IBAction)btnSegLevel:(id)sender {
    // Switch level
    switch (self.btnSegLevel.selectedSegmentIndex) {
            
        case kSegLevelN1: {
            [self requestKanjiWord:kUrlKanjiN1];
        }
            break;
            
        case kSegLevelN2: {
            [self requestKanjiWord:kUrlKanjiN2];
        }
            break;
            
        case kSegLevelN3: {
            [self requestKanjiWord:kUrlKanjiN3];
        }
            break;
            
        case kSegLevelN4: {
            [self requestKanjiWord:kUrlKanjiN4];
        }
            break;
            
        case kSegLevelN5: {
            [self requestKanjiWord:kUrlKanjiN5];
        }
            break;
            
        default:
            break;
    }
}

- (void)requestKanjiWord:(NSString *)urlKanjiLevel {
    self.csTopCollection.constant = kTopConstantCollectionKanji;
    self.btnSegLevel.hidden = NO;
    [self.listWriting removeAllObjects];
    [self.collectionWriting reloadData];
    
    NSArray *listKanjiLocal = [[NSArray alloc] init];
    listKanjiLocal = [[DataAccess shared] listKanjiByLevel:self.btnSegLevel.selectedSegmentIndex + 1];
    if (listKanjiLocal.count > 0) {
        self.listWriting = [listKanjiLocal mutableCopy];
        [self.collectionWriting reloadData];
    } else {
        ProgressBarShowLoading(kLoading);
        [[DataManager shared] getKanjiWithUrl:urlKanjiLevel];
    }
    
    
}

# pragma mark  UICollection Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listWriting.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
    WritingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWritingCellIdentifier forIndexPath:indexPath];
    
    [cell setInformationCell:self.btnSegLevel.hidden atIndexPath:indexPath andList:self.listWriting];
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KanjiController *kanjiController = InitStoryBoardWithIdentifier(kKanjiController);
    
    if (self.btnSegLevel.hidden) {
        NSDictionary *dictCell = self.listWriting[indexPath.row];
        [[Sound shared] playSoundWithText:[dictCell objectForKey:kHiraganaKey]];
    }
    else {
        kanjiController.word = self.listWriting[indexPath.row];
        [Utilities showDialogController:kanjiController withTag:kTagWritingController];
    }
    
}

# pragma mark  Kanji Delegate
- (void)getKanjiAPISuccess:(NSData *)response {
    ProgressBarDismissLoading(kEmpty);
    
    // Parse Data from HTML
    TFHpple *tutorialsParser = [TFHpple hppleWithHTMLData:response];
    NSArray *kanjiNode = [tutorialsParser searchWithXPathQuery:kQueryListVocabulary];
    NSMutableArray *newListKanji = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < kanjiNode.count - 4; i = i+4) {
        NSLog(@"%d",i);
        TFHppleElement *element1 = kanjiNode[i];
        TFHppleElement *element2 = kanjiNode[i+1];
        TFHppleElement *element3 = kanjiNode[i+2];
        TFHppleElement *element4 = kanjiNode[i+3];
        Kanji *newKanji = [Kanji new];
        newKanji.kanjiWord = [[element1 firstChild] content];
        newKanji.onyomi = [Utilities convertString:[[element2 firstChild] content]];
        newKanji.kunyomi = [Utilities convertString:[[element3 firstChild] content]];
        newKanji.englishMeaning = [Utilities convertString:[[element4 firstChild] content]];
        newKanji.level = self.btnSegLevel.selectedSegmentIndex + 1;
        [newKanji commit];
        [newListKanji addObject:newKanji];
        NSLog(@"%@",newKanji.kanjiWord);
        
    }
    
    self.listWriting = [newListKanji mutableCopy];
    [self.collectionWriting reloadData];
}

- (void)getKanjiAPIFail:(NSString *)resultMessage {
    ProgressBarDismissLoading(kEmpty);
}
@end
