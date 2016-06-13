//
//  NSMutableAttributedString+Color.h
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/26/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSMutableAttributedString (Color)
-(void)setColorForText:(NSString*) textToFind withColor:(UIColor*) color;
@end
