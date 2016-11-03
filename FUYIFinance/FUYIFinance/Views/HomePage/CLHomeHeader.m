//
//  CLHomeHeader.m
//  CLZhongZi
//
//  Created by darren on 16/3/7.
//  Copyright © 2016年 shanku. All rights reserved.
//

#define CLMaxSections 100

#import "CLHomeHeader.h"
#import "CLAdCollectionCell.h"

@interface CLHomeHeader()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (nonatomic,weak) UICollectionView *collectionView;

/***/
@property (nonatomic,weak) UIImageView *placehoder;// 占位图

@end

@implementation CLHomeHeader

static NSString *ADID = @"adCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 64, 49)];
        imgView.image = [UIImage imageNamed:@"fuyi_hot"];//富谊头条
        [self addSubview:imgView];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(75, 5, 1, 58)];// 竖分割线
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:lineView];
       self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
// 新闻
- (NSArray *)newses
{
    if (_newses == nil) {
        self.newses = [NSArray array];
    }
    return _newses;
}
- (void)layoutSubviews // 头条右边的两个视图
{
    [super layoutSubviews];
    // 创建滚动视图
    if (!self.timer.isValid) {
        
        [self setupCollectionView];
        [self addTimer];
        [self.placehoder removeFromSuperview];
    }
   

}

/*创建自动滚动视图*/
- (void)setupCollectionView
{
    // 创建collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(80, 0, self.frame.size.width-80, self.frame.size.height) collectionViewLayout:layout];
    layout.itemSize = CGSizeMake(self.frame.size.width-80, self.frame.size.height);
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.scrollEnabled = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:collectionView];
    self.collectionView = collectionView;

    // 注册cell
    [self.collectionView registerClass:[CLAdCollectionCell class] forCellWithReuseIdentifier:ADID];
    // 默认显示最中间的那组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:CLMaxSections/2] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}

/**
 *  添加定时器
 */
- (void)addTimer
{
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
  
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    // 停止定时器
    [self.timer invalidate]; // 从运行循环中移除， 对运行循环的引用进行一次 release
    self.timer = nil;// 将销毁定时器
}

- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    // 马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:CLMaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    return currentIndexPathReset;
}

/**
 *  下一页
 */
- (void)nextPage
{
    // 1.马上显示回最中间那组的数据
    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.newses.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
  //  NSLog(@"********section %ld,row %ld*********",nextIndexPath.section,nextIndexPath.row);
    // 3.通过动画滚动到下一个位置
    if (nextIndexPath.row < self.newses.count) {
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }else{
      //  NSLog(@"fuking .....");
    }
   }

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.newses.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return CLMaxSections;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLAdCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ADID forIndexPath:indexPath];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    if (self.newses.count > 0) {
        cell.contentArray = self.newses[indexPath.row];
    }
    __weak CLHomeHeader *weakSelf = self;
    cell.clickLable1 = ^{
        weakSelf.cliclCelllable1();
    };
    cell.clickLable2 = ^{
        weakSelf.cliclCelllable2();
    };
    return cell;
}

#pragma mark  - UICollectionViewDelegate
/**
 *  当用户即将开始拖拽的时候就调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  当用户停止拖拽的时候就调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
@end
