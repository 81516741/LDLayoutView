//
//  ViewController.m
//  Collection布局
//
//  Created by ld on 16/1/21.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "LDLayoutView.h"

@interface ViewController ()<LDLayoutViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor redColor];
    
    //**********这里没什么的，就是造点假数据*********//
    //*height/width 的比值，瀑布流必须参数，其余可无
    NSArray * HWScales = @[@1.2,@1.5,@1.3,@1.9,@1.6,@1.1,@1.0,@0.5,@1.5,@1.2,@1.5,@1.3,@1.9,@1.6,@1.1,@1.0,@0.5,@1.5];
    //装图片名的数组
    NSMutableArray * pictures = [NSMutableArray array];
    for (int i = 1; i < 19; i++) {
        NSString * image = [NSString stringWithFormat:@"%02d",i];
        [pictures addObject:image];
    }
    
    LDLayoutView * layoutView = [LDLayoutView layoutView];
    layoutView.delegete = self;
    layoutView.frame = CGRectMake(20, 100,280, 200);
    //设置是否显示指示条
    [layoutView showHorizontal:NO showVertical:NO];
    
    //******《主要步骤》 传递数据显示内容*****//
    [layoutView layoutPictures:pictures withHWScales:HWScales andLayoutType:LDLayoutViewLayoutTypeWaterFlow];
    
    //添加到控制器的view
    [self.view addSubview:layoutView];
    
    
}

//代理方法，传递几个值
-(void)layoutView:(LDLayoutView *)layoutView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}
@end
