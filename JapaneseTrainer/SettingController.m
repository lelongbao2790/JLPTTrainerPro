//
//  SettingController.m
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/13/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()
@property (weak, nonatomic) IBOutlet UISlider *slideVolumn;
@property (weak, nonatomic) IBOutlet UILabel *lbNameExample;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UILabel *lbSpeedText;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnSound;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utilities borderView:self.subView];
    [Utilities borderView:self.btnSave];
    [Utilities circleButton:self.btnSound];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.slideVolumn.value = [Sound shared].speedValue;
    self.lbSpeedText.text = [NSString stringWithFormat:@"%0.2f",self.slideVolumn.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnDelete:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnSlideVolume:(UISlider *)sender {
    
    [Sound shared].speedValue = sender.value;
    [self.slideVolumn setValue:sender.value];
    
    self.lbSpeedText.text = [NSString stringWithFormat:@"%0.2f",sender.value];
}

- (IBAction)btnSave:(id)sender {
    [Sound shared].speedValue = self.slideVolumn.value;
    [Utilities showiToastMessage:@"Sound saved successfully"];
}

- (IBAction)btnSound:(id)sender {
    [[Sound shared] playSoundWithText:self.lbNameExample.text];
}

@end
