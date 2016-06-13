//
//  KanjiController.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/30/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "KanjiController.h"

@interface KanjiController ()<KanjiMeaningDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lbKanji;
@property (weak, nonatomic) IBOutlet UILabel *lbReading;
@property (weak, nonatomic) IBOutlet UILabel *lbMeaning;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UIWebView *webviewWritingKanji;
@property (weak, nonatomic) IBOutlet UIView *viewInformation;
@property (weak, nonatomic) IBOutlet UISegmentedControl *btnSeg;
@property (weak, nonatomic) IBOutlet UIButton *btnSound;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csTopSubView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csBottomSubView;
@property (strong, nonatomic) NSMutableArray *listExampleKanji;
@property (weak, nonatomic) IBOutlet UITableView *tbvExample;

@property (weak, nonatomic) IBOutlet UIButton *btnBookmark;
@end

@implementation KanjiController

#pragma mark Life Cycle

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
    [DataManager shared].kanjiMeaningDelegate = self;
    [self setInformation];
}

- (void)viewDidAppear:(BOOL)animated {
}

#pragma mark Helper Method

- (void)config {
    self.listExampleKanji = [[NSMutableArray alloc] init];
    
    // Kanji
    self.btnSeg.hidden = NO;
    self.viewInformation.hidden = NO;
    self.lbKanji.hidden = NO;
    [Utilities borderView:self.lbKanji];
    
    // Border subview layer
    self.subView.layer.cornerRadius = 5.0;
    self.subView.layer.masksToBounds = YES;
    self.webviewWritingKanji.scrollView.scrollEnabled = NO;
    self.webviewWritingKanji.scrollView.bounces = NO;
    [Utilities circleButton:self.btnSound];
    [Utilities removeBlankFooterTableView:self.tbvExample];
}

- (void)changeBookmark {
    if (self.word.isBookmark == kValueBookMark1) {
        [self.btnBookmark setImage:[UIImage imageNamed:kHeartIconSelected] forState:UIControlStateNormal];
        
    } else {
        [self.btnBookmark setImage:[UIImage imageNamed:kHeartIconNotSelected] forState:UIControlStateNormal];
    }
}

- (void)requestMeaningKanji {
    
    if ([[DataAccess shared] listKanjiRelated:self.word.kanjiWord].count > 0) {
        [self loadInformationFromData];
        
    } else {
        ProgressBarShowLoading(kLoading);
        NSString *url = [NSString stringWithFormat:kKanjiTangori,self.word.kanjiWord];
        [[DataManager shared] getKanjiMeaningWithUrl:url];
    }
}

- (void)loadInformationFromData {
    // Reading
    
    // Show meaning html
    NSMutableAttributedString *kanjiHtml = [[NSMutableAttributedString alloc] initWithData:[[self.word.kanjiReading stringByAppendingString:kHTMLFontSize16] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [kanjiHtml addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, kanjiHtml.length)];

    self.lbReading.attributedText = kanjiHtml;
    self.lbMeaning.text = self.word.englishMeaning;
    
    // Example
    self.listExampleKanji = [[[DataAccess shared] listKanjiRelated:self.word.kanjiWord] mutableCopy];
    [self.tbvExample reloadData];
    [self.webviewWritingKanji loadHTMLString:self.word.kanjiDrawing baseURL:nil];
    
}

- (IBAction)btnDelete:(id)sender {
    [Utilities hideDialogController:self withTag:kTagWritingController];
}

- (void)setInformation {
    self.lbKanji.text = self.word.kanjiWord;
    [self requestMeaningKanji];
    
    // Set button bookmark
    [self changeBookmark];
}

- (IBAction)btnSeg:(id)sender {
    
    switch (self.btnSeg.selectedSegmentIndex) {
        case kSegInforKanji: {
            self.webviewWritingKanji.hidden = YES;
            self.viewInformation.hidden = NO;
        }
            break;
            
        default: {
            self.webviewWritingKanji.hidden = NO;
            self.viewInformation.hidden = YES;
        }
            break;
    }
    
}
- (IBAction)btnSound:(id)sender {
     [[Sound shared] playSoundWithText:self.lbKanji.text];
}

- (IBAction)btnBookmark:(id)sender {
    if (self.word.isBookmark == kValueBookMark1) {
        self.word.isBookmark = kValueBookMark0;
        [self.btnBookmark setImage:[UIImage imageNamed:kHeartIconNotSelected] forState:UIControlStateNormal];
        
    } else {
        self.word.isBookmark = kValueBookMark1;
        [self.btnBookmark setImage:[UIImage imageNamed:kHeartIconSelected] forState:UIControlStateNormal];
    }
    [self.word commit];
}

#pragma mark Table View Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KanjiCell  *exampleCell = [tableView dequeueReusableCellWithIdentifier:kKanjiCellIdentifier];
    if(!exampleCell) { exampleCell = [[KanjiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kKanjiCellIdentifier];}
    
    Kanji *objKanji = self.listExampleKanji[indexPath.row];
    [exampleCell loadInformation:objKanji];
    return exampleCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.listExampleKanji.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KanjiCell  *exampleCell = [tableView dequeueReusableCellWithIdentifier:kKanjiCellIdentifier];
    Kanji *objKanji = self.listExampleKanji[indexPath.row];
    CGRect rectKanji = [Utilities getRectFromAttributedString:[Utilities convertStringToNSAttributeString:[objKanji.example stringByAppendingString:kHTMLFontSize18]] withWidth:self.view.frame.size.width - exampleCell.lbKunyomi.frame.size.width - kWidthImage];
    return rectKanji.size.height + kWidthImage;
}

#pragma mark Kanji Meaning Delegate

- (void)getKanjiMeaningAPISuccess:(NSData *)response {
    ProgressBarDismissLoading(kEmpty);
    
    // Parse Data from HTML
    TFHpple *kanjiParser = [TFHpple hppleWithHTMLData:response];
    NSArray *kanjiReadingNode = [kanjiParser searchWithXPathQuery:kReadingKanjiTag];
    NSArray *kanjiMeaningNode = [kanjiParser searchWithXPathQuery:kMeaningKanjiTag];
    NSArray *kanjiDrawNode = [kanjiParser searchWithXPathQuery:kDrawKanjiTag];
    NSArray *kanjiExampleNode = [kanjiParser searchWithXPathQuery:kExampleKanjiTag];
    
    for (TFHppleElement *elementReading in kanjiReadingNode) {
        NSString *kanjiReading = [elementReading content];
        kanjiReading = [kanjiReading stringByAppendingString:kHTMLFontSize15];
        kanjiReading = [kanjiReading stringByReplacingOccurrencesOfString:@"/    " withString:@"<br>"];
        self.word.kanjiReading = kanjiReading;
        break;
    }
    for (TFHppleElement *elementMeaning in kanjiMeaningNode) {
        NSString *kanjiMeaning = [elementMeaning content];
        kanjiMeaning = [kanjiMeaning stringByAppendingString:kHTMLFontSize15];
        self.word.kanjiMeaning = kanjiMeaning;
        break;
    }
    for (TFHppleElement *elementExample in kanjiExampleNode) {
        Kanji *newKanji = [Kanji new];
        
        NSArray *listChildElement = [elementExample childrenWithTagName:@"td"];
        
        if (listChildElement.count > 1) {
            TFHppleElement *child1 = listChildElement[0];
            TFHppleElement *child2 = listChildElement[1];
            newKanji.kunyomi = [child1 content];
            newKanji.example = [child2 raw];
            NSLog(@"%@",newKanji.kunyomi);
            NSLog(@"%@",newKanji.example);
        }
        newKanji.nameKanjiRelated = self.word.kanjiWord;
        [newKanji commit];
    }
    
    for (TFHppleElement *elementKanji in kanjiDrawNode) {
        NSString *kanjiSVG= [elementKanji raw];
        [kanjiSVG stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        [kanjiSVG stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        self.word.kanjiDrawing = kanjiSVG;
        break;
    }
    
    [self.word commit];
    
    [self loadInformationFromData];
}

- (void)getKanjiMeaningAPIFail:(NSString *)resultMessage {
    ProgressBarDismissLoading(kEmpty);
}

@end
