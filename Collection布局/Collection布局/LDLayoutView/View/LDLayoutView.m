//
//  LDLayoutView.m
//  Collection布局
//
//  Created by ld on 16/1/21.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDLayoutView.h"
#import "LDWaterflowLayout.h"
#import "LDLineLayout.h"
#import "LDCircleLayout.h"
#import "LDStackLayout.h"
#import "LDImageCell.h"

static NSString * const kLDImageCell = @"LDImageCell";

@interface LDLayoutView()<UICollectionViewDataSource,UICollectionViewDelegate,LDWaterflowLayoutDelegate>
{
    NSMutableArray * _pictures;
    NSArray * _HWScales;
    LDLayoutViewLayoutType _layoutType;
}
@property (weak, nonatomic)  UICollectionView *collectionView;

@end

@implementation LDLayoutView
/**
 *  快速回去LDLayoutView对象
 */
+(instancetype)layoutView
{
    LDLayoutView * view = [[[NSBundle mainBundle]loadNibNamed:@"LDLayoutView" owner:self options:nil]lastObject];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
/**
 *  是否显示水平和垂直指示条
 */
-(void)showHorizontal:(BOOL)showHorizontal showVertical:(BOOL)showVertical
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _collectionView.showsHorizontalScrollIndicator = showHorizontal;
        _collectionView.showsVerticalScrollIndicator = showHorizontal;
    });
}
/**
 *  设置数据和布局方式
 */
-(void)layoutPictures:(NSMutableArray *)pictures withHWScales:(NSArray *)HWScales andLayoutType:(LDLayoutViewLayoutType)layoutType
{
    _pictures = pictures;
    _HWScales = HWScales;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:[self layoutWithType:layoutType]];
    _collectionView = collectionView;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:kLDImageCell bundle:nil] forCellWithReuseIdentifier:kLDImageCell];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
}

/**
 *  根据布局类型设置基本属性，并返回布局对象
 */
-(UICollectionViewLayout *)layoutWithType:(LDLayoutViewLayoutType)layoutType
{
    CGFloat minWH = MIN(self.bounds.size.height, self.bounds.size.width);
    if (layoutType == LDLayoutViewLayoutTypeWaterFlow) {
        LDWaterflowLayout * layout = [LDWaterflowLayout new];
        layout.delegate = self;
        return layout;
    }else if (layoutType == LDLayoutViewLayoutTypeLine){
        LDLineLayout * layout = [LDLineLayout new];
        layout.itemSize = CGSizeMake(minWH * 0.6, minWH * 0.6);
        _collectionView.showsHorizontalScrollIndicator = NO;
        return layout;
    }else if (layoutType == LDLayoutViewLayoutTypeCircle){
        LDCircleLayout * layout = [LDCircleLayout new];
        layout.itemSize = CGSizeMake(minWH * 0.3, minWH * 0.3);
        return layout;
    }else if (layoutType == LDLayoutViewLayoutTypeStack){
        LDStackLayout * layout = [LDStackLayout new];
        layout.itemSize = CGSizeMake(minWH * 0.7, minWH * 0.7);
        return layout;
    }else{
        NSLog(@"未设置布局模式");
        return nil;
    }
    
}

#pragma mark - collection的代理方法
#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _pictures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLDImageCell forIndexPath:indexPath];
    cell.image = _pictures[indexPath.item];
    return cell;
}
/**
 *  代理方法，传递点中位置
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegete respondsToSelector:@selector(layoutView:didSelectedItemAtIndexPath:)]) {
        [self.delegete layoutView:self didSelectedItemAtIndexPath:indexPath];
    }
}

/**
 *  瀑布流时，需要根据item的宽度 * 高宽比  计算item高度
 */
-(CGFloat)waterflowLayout:(LDWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    return width * [_HWScales[indexPath.item] doubleValue];
}

@end
