//
//  CustomWritingLayout.m
//  JapaneseTrainer
//
//  Created by Bao (Brian) L. LE on 5/27/16.
//  Copyright © 2016 LongBao. All rights reserved.
//

#import "CustomWritingLayout.h"

@implementation CustomWritingLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.minimumLineSpacing = 1.0;
        self.minimumInteritemSpacing = 1.0;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (CGSize)itemSize
{
    NSInteger numberOfColumns = kNumberOfColumInLine;
    
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - (numberOfColumns - 1)) / numberOfColumns;
    return CGSizeMake(itemWidth, itemWidth);
}

@end
