//
//  NoteController.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/7/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "NoteController.h"

@interface NoteController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UITextView *tvNote;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end

@implementation NoteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self config];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)config {
    [Utilities borderView:self.btnSave];
    [Utilities borderView:self.tvNote];
    [Utilities borderView:self.subView];
    self.tvNote.text = kEmpty;
    
    if (self.aNote && ![self.aNote.noteMessage isEqualToString:kAddNote]) {
        self.tvNote.text = self.aNote.noteMessage;
    } else {
        self.tvNote.text = kEmpty;
    }
    
    // Tap gesture
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
}


//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

- (IBAction)btnSave:(id)sender {
    [self handleSingleTap:nil];
    
    if (self.tvNote.text.length > 0) {

        if (!self.aNote) {
            self.aNote = [Note new];
        }
        
        self.aNote.noteMessage = self.tvNote.text;
        self.aNote.nameRelate = self.nameRelate;
        [self.aNote commit];
        
        
        [Utilities showiToastMessage:kNoteSuccess];
        [self btnDelete:nil];
    } else {
        [Utilities showiToastMessage:kErrorInputNote];
    }
    
}

- (IBAction)btnDelete:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(dismissNote:)]) {
        [self.delegate dismissNote:self];
    }
}

#pragma mark Text View Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
