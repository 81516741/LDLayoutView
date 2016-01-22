//
//  LDLayoutView.h
//  Collection布局
//
//  Created by ld on 16/1/21.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDLayoutView;
typedef enum {
    LDLayoutViewLayoutTypeWaterFlow,//瀑布流
    LDLayoutViewLayoutTypeLine,//直线
    LDLayoutViewLayoutTypeCircle,//圆形
    LDLayoutViewLayoutTypeStack//堆叠
}LDLayoutViewLayoutType;

@protocol LDLayoutViewDelegate <NSObject>
/**
 *  代理方法，传递点击的位置和几个view
 */
-(void)layoutView:(LDLayoutView *)layoutView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LDLayoutView : UIView
/**
 *  代理
 */
@property(nonatomic, weak) id<LDLayoutViewDelegate> delegete;

+(instancetype)layoutView;
/**
 *  设置所需要的数据
 *
 *  @param pictures 图片集合（瀑布流需与图片比例一一对应）
 *  @param HWScales 图片的 高度/宽度 的比值（瀑布流必须参数，其余不用）
 *  @param layoutType 布局类型（瀑布，直线，堆）
 */
-(void)layoutPictures:(NSMutableArray *)pictures withHWScales:(NSArray *)HWScales andLayoutType:(LDLayoutViewLayoutType)layoutType;
/**
 *  是否显示水平和垂直滑动的指示条
 */
-(void)showHorizontal:(BOOL)showHorizontal showVertical:(BOOL)showVertical;

@end
