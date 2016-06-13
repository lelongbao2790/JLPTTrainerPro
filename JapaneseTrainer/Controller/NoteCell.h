//
//  NoteCell.h
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/6/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@protocol NoteCellDelegate;

@interface NoteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbAddnote;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (strong, nonatomic) Note *aNote;
@property (weak, nonatomic) id<NoteCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csLeadingLbNote;

- (void)loadInformation;

@end


@protocol NoteCellDelegate<NSObject>
- (void)addNote;
- (void)removeNote:(Note *)noteRemove;
- (void)editNote:(Note *)noteEdit;
@end
