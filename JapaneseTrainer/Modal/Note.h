//
//  Note.h
//  JLPTTrainer
//
//  Created by Bao (Brian) L. LE on 6/7/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import <DBAccess/DBAccess.h>

@interface Note : DBObject

@property (strong, nonatomic) NSString *noteMessage;
@property (strong, nonatomic) NSString *nameRelate;
@end
