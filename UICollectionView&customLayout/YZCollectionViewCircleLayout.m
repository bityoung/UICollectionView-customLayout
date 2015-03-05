//
//  YZCollectionViewCircleLayout.m
//  UICollectionView&customLayout
//
//  Created by yang on 15/3/5.
//  Copyright (c) 2015年 yangzhiqiang. All rights reserved.
//

#import "YZCollectionViewCircleLayout.h"

@implementation YZCollectionViewCircleLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat angle = M_PI * 2 / count;
    CGPoint center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    CGFloat radius = 100;
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.size = CGSizeMake(100, 100);
    attrs.center = CGPointMake(center.x + radius * cos(angle * indexPath.item), center.y + radius * sin(angle * indexPath.item));
    attrs.zIndex = count - indexPath.item;
    
    return attrs;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [array addObject:attrs];
    }
    return array;
}

@end
