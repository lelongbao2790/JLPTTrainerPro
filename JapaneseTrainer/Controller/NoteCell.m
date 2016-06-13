//
//  NoteCell.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/6/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "NoteCell.h"

@implementation NoteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadInformation{
    self.lbAddnote.text = self.aNote.noteMessage;
    
    if ([self.aNote.noteMessage isEqualToString:kAddNote]) {
        [self.btnAdd setImage:[UIImage imageNamed:kAddImage] forState:UIControlStateNormal];
        self.csLeadingLbNote.constant = -self.btnEdit.frame.size.width;
        self.btnEdit.hidden = YES;
    } else {
        [self.btnAdd setImage:[UIImage imageNamed:kTrashImage] forState:UIControlStateNormal];
        self.csLeadingLbNote.constant = kLeadingConstantNote;
        self.btnEdit.hidden = NO;
    }
}

- (IBAction)btnAdd:(id)sender {
    
    if ([self.aNote.noteMessage isEqualToString:kAddNote]) {
        
        if ([self.delegate respondsToSelector:@selector(addNote)]) {
            [self.delegate addNote];
        }
        
    } else {
        if ([self.delegate respondsToSelector:@selector(removeNote:)]) {
            [self.delegate removeNote:self.aNote];
        }
    }
}

- (IBAction)btnEdit:(id)sender {
    
    if (![self.aNote.noteMessage isEqualToString:kAddNote]) {
        
        if ([self.delegate respondsToSelector:@selector(editNote:)]) {
            [self.delegate editNote:self.aNote];
        }
    }
}

@end
