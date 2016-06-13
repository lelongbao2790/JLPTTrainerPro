//
//  NoteController.h
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/7/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NoteControllerDelegate;

@interface NoteController : UIViewController

@property (strong, nonatomic) NSString *nameRelate;
@property (strong, nonatomic) Note *aNote;
@property (weak, nonatomic) id<NoteControllerDelegate> delegate;

@end

@protocol NoteControllerDelegate<NSObject>

- (void)dismissNote:(UIViewController *)controller;

@end
