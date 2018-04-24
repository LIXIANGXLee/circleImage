//
//  RotateImageView.h
//  lxLunboTu
//
//  Created by budgetoutsource on 2017/3/1.
//  Copyright © 2017年 李响. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXRotateImageViewDelegate <NSObject>

@required
#pragma mark - This proxy is a data source method

-(NSArray *)lx_getImageDataSource;

@optional

#pragma mark - Click on the next page
-(void)lx_clickIntoNextPageWithIndex:(int)index;

-(void)lx_clickIntoNextPageWithImageStr:(NSString *)imageStr;

@end

@interface LXRotateImageView : UIView

#pragma mark - Timer setting
@property(nonatomic,assign)CGFloat lx_duration;


@property(nonatomic,strong)UIColor * lx_currentPageIndicatorTintColor;
@property(nonatomic,strong)UIColor * lx_pageIndicatorTintColor;

@property(nonatomic,weak)id<LXRotateImageViewDelegate>delegate;

#pragma mark - When you leave this page, you need to call this timer destruction method
-(void)lx_stopTimer;


#pragma mark - When you bacl this page, you need to call this timer start method
-(void)lx_StartTimer;


@end
