//
//  Sound.h
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/26/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sound : NSObject

//*****************************************************************************
#pragma mark -
#pragma mark ** Singleton object **
+ (Sound *)shared;

- (void)playSoundWithText:(NSString *)text;

@end
