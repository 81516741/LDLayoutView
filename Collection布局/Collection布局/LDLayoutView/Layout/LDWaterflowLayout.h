//
//  LDWaterflowLayout.h
//  04-瀑布流
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDWaterflowLayout;

@protocol LDWaterflowLayoutDelegate <NSObject>
/**
 *  代理方法
 *
 *  @param waterflowLayout 布局本身
 *  @param width           item的宽度
 *  @param indexPath       item的位置
 *
 *  @return 根据比例和给的宽度计算出高度（高度=scale * 宽度）
 */
- (CGFloat)waterflowLayout:(LDWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface LDWaterflowLayout : UICollectionViewLayout
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) int columnsCount;

@property (nonatomic, weak) id<LDWaterflowLayoutDelegate> delegate;

@end
