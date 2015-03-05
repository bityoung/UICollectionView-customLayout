//
//  YZCollectionViewStackLayout.m
//  UICollectionView&customLayout
//
//  Created by yang on 15/3/5.
//  Copyright (c) 2015年 yangzhiqiang. All rights reserved.
//

#import "YZCollectionViewStackLayout.h"

@implementation YZCollectionViewStackLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rectn {
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [array addObject:attrs];
    }
    
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(100, 100);
    attrs.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    if (indexPath.item >= 4) {
        attrs.hidden = YES;
    } else {
        attrs.transform = CGAffineTransformMakeRotation(M_PI_4 * 0.5 * indexPath.item);
        
    }
    attrs.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
    
    return attrs;
}

@end
