//
//  ViewController.m
//  UICollectionView&customLayout
//
//  Created by yang on 15/3/4.
//  Copyright (c) 2015年 yangzhiqiang. All rights reserved.
//

#import "ViewController.h"
#import "YZCollectionViewFlowLayout.h"
#import "YZCollectionViewLineLayout.h"
#import "YZCollectionViewStackLayout.h"
#import "YZCollectionViewCircleLayout.h"

#define RANDOM_COLOR [UIColor colorWithRed:(arc4random_uniform(255) / 255.0) green:(arc4random_uniform(255) / 255.0) blue:(arc4random_uniform(255) / 255.0) alpha:1.0];

static NSString *const ID = @"cell";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *colorArray;
@property (nonatomic, strong) NSMutableArray *deletedIndexPaths;
@property (nonatomic, strong) NSMutableArray *deletedColors;
@end

@implementation ViewController

- (NSMutableArray *)deletedIndexPaths {
    if (!_deletedIndexPaths) {
        _deletedIndexPaths = [NSMutableArray array];
    }
    return _deletedIndexPaths;
}

- (NSMutableArray *)deletedColors {
    if (!_deletedColors) {
        _deletedColors = [NSMutableArray array];
    }
    return _deletedColors;
}

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            UIColor *color = RANDOM_COLOR;
            [_colorArray addObject:color];
        }
    }
    return _colorArray;
}

- (IBAction)changeLayout:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self.collectionView setCollectionViewLayout:[[YZCollectionViewFlowLayout alloc] init] animated:YES];
            break;
            
        case 1:
            [self.collectionView setCollectionViewLayout:[[YZCollectionViewLineLayout alloc] init] animated:YES];
            break;
            
        case 2:
            [self.collectionView setCollectionViewLayout:[[YZCollectionViewStackLayout alloc] init] animated:YES];
            break;
            
        case 3:
            [self.collectionView setCollectionViewLayout:[[YZCollectionViewCircleLayout alloc] init] animated:YES];
            break;
    }
}

- (IBAction)recover {
    
    if (!self.deletedColors || !self.deletedIndexPaths) return;
    if (self.deletedColors.count == 0 || self.deletedIndexPaths.count == 0 ) return;
    
    UIColor *recovingColor = [self.deletedColors lastObject];
    NSIndexPath *recoveringIndexPath = [self.deletedIndexPaths lastObject];
    
    [self.colorArray insertObject:recovingColor atIndex:recoveringIndexPath.item];
    [self.collectionView insertItemsAtIndexPaths:@[recoveringIndexPath]];
    
    [self.deletedColors removeLastObject];
    [self.deletedIndexPaths removeLastObject];
}

- (void)viewDidLoad {
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width) collectionViewLayout:[[YZCollectionViewFlowLayout alloc] init]];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colorArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.backgroundColor = self.colorArray[indexPath.item];
    cell.layer.borderWidth = 3;
    cell.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds  = YES;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // first addObject, then removeObject.
    [self.deletedIndexPaths addObject:indexPath];
    [self.deletedColors addObject:self.colorArray[indexPath.item]];
    
    [self.colorArray removeObject:self.colorArray[indexPath.item]];
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
