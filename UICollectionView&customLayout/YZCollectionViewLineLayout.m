//
//  YZCollectionViewLineLayout.m
//  UICollectionView&customLayout
//
//  Created by yang on 15/3/4.
//  Copyright (c) 2015年 yangzhiqiang. All rights reserved.
//

#import "YZCollectionViewLineLayout.h"

#define COLLECTION_VIEW_HALF_WIDTH (self.collectionView.frame.size.width * 0.5)

static CGFloat const itemW = 100;
static CGFloat const scaleRatio = 0.7;

@implementation YZCollectionViewLineLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(itemW, itemW);
    self.minimumLineSpacing = itemW;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat verticalInset = (self.collectionView.frame.size.height - self.itemSize.height) * 0.5;
    CGFloat horizontalInset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(verticalInset, horizontalInset, verticalInset, horizontalInset);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    CGRect scaleZone;
    scaleZone.origin = self.collectionView.contentOffset;
    scaleZone.size = self.collectionView.frame.size;
    
    CGFloat centerX = self.collectionView.contentOffset.x + COLLECTION_VIEW_HALF_WIDTH;
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
        if (!CGRectIntersectsRect(scaleZone, attrs.frame)) continue;
        
        CGFloat itemCenterX = attrs.center.x;
        CGFloat scale = 1 + scaleRatio * (1 - ABS(itemCenterX - centerX) / COLLECTION_VIEW_HALF_WIDTH);
        
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGRect stopZone;
    stopZone.origin = proposedContentOffset;
    stopZone.size = self.collectionView.frame.size;
    
    CGFloat centerX = proposedContentOffset.x + COLLECTION_VIEW_HALF_WIDTH;
    
    NSArray *array = [self layoutAttributesForElementsInRect:stopZone];
    
    CGFloat adjustedX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x - centerX) < ABS(adjustedX)) {
            adjustedX = attrs.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + adjustedX, proposedContentOffset.y);
}

@end
