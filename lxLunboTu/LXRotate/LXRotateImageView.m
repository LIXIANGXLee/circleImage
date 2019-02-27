//
//  RotateImageView.m
//  lxLunboTu
//
//  Created by budgetoutsource on 2017/3/1.
//  Copyright © 2017年 李响. All rights reserved.
//

#import "LXRotateImageView.h"
#import "LXRotateImageModel.h"
#import <objc/runtime.h>
#import "LXProxy.h"

#define SCREENWIDTH self.frame.size.width
#define SCREENHEIGHT self.frame.size.height


@interface LXRotateImageView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrollview;
@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)NSThread  * thread;
@property(nonatomic,assign)int index;

@property(nonatomic,strong)UIImageView * leftImgView;
@property(nonatomic,strong)UIImageView * midMgView;
@property(nonatomic,strong)UIImageView * rightImgView;
@property(nonatomic,strong)UITapGestureRecognizer * tapGesture;

@end

@implementation LXRotateImageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.scrollview];
        [self addSubview:self.pageControl];
        [self.scrollview addSubview:self.leftImgView];
        [self.scrollview addSubview:self.midMgView];
        [self.scrollview addSubview:self.rightImgView];
        [self.midMgView addGestureRecognizer:self.tapGesture];
        
        
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizesSubviews = NO;
        self.index = 0;
        [self lx_StartTimer];
    }
    return self;
}

//NSTimer method
-(void)ceateTimer{
   
        __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        weakSelf.thread = [NSThread currentThread];
        
        if (@available(iOS 10.0, *)) {
            weakSelf.timer = [NSTimer timerWithTimeInterval:weakSelf.lx_duration ? weakSelf.lx_duration:2.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
                [weakSelf rotateGo];
            }];
        } else {
            weakSelf.timer = [NSTimer timerWithTimeInterval:self.lx_duration ? self.lx_duration:2.0f target:[LXProxy proxyWithTarget:self] selector:@selector(rotateGo) userInfo:nil repeats:YES];
        }
        
        [[NSRunLoop currentRunLoop] addTimer: weakSelf.timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"-=-=-=-=end");
    });
}

-(void)rotateGo{
    
    if (!_imgDataSource) return;
    self.index ++ ;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.scrollview setContentOffset:CGPointMake(SCREENWIDTH * 2, 0) animated:YES];
        if ([self.imgDataSource count]) {
            self.pageControl.currentPage = self.index % [self.imgDataSource count];
        }
    });
}

-(void)setImgDataSource:(NSArray<LXRotateImageProtocol> *)imgDataSource{
    _imgDataSource = imgDataSource;
    if (!_imgDataSource) return;
    
    self.scrollview.scrollEnabled = ([self.imgDataSource count]>1);
    self.pageControl.numberOfPages = [self.imgDataSource count] ;
    self.pageControl.hidden = !([self.imgDataSource count]>1);
    [self.scrollview setContentOffset:CGPointMake(SCREENWIDTH * 2, 0) animated:YES];
    
    if ([_imgDataSource count] >1) {
        [self lx_StartTimer];
    }else{
        [self lx_stopTimer];
    }
}


-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT - 20, SCREENWIDTH, 8)];
        _pageControl.currentPage = 0;
        [_pageControl setBackgroundColor:[UIColor clearColor]];
        _pageControl.currentPageIndicatorTintColor = self.lx_currentPageIndicatorTintColor?self.lx_currentPageIndicatorTintColor : [UIColor redColor];
        _pageControl.pageIndicatorTintColor = self.lx_pageIndicatorTintColor?self.lx_pageIndicatorTintColor:[UIColor whiteColor];
    }
    return _pageControl;
}

-(UIImageView *)leftImgView{
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _leftImgView.userInteractionEnabled = YES;
        if ([self.imgDataSource count] > 1) {
            id<LXRotateImageProtocol>lModel = self.imgDataSource[[self.imgDataSource count] - 1];
            if ([self.delegate respondsToSelector:@selector(lx_setImageOfImageView:imageStr:)]) {
                [self.delegate lx_setImageOfImageView:_leftImgView imageStr:lModel.img_str];
            }
        }
    }
    return _leftImgView;
}

-(UIImageView *)midMgView{
    if (!_midMgView) {
        _midMgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
        _midMgView.userInteractionEnabled = YES;
        if ([self.imgDataSource count] > 0) {
           id<LXRotateImageProtocol>mModel = self.imgDataSource[0];
            if ([self.delegate respondsToSelector:@selector(lx_setImageOfImageView:imageStr:)]) {
                [self.delegate lx_setImageOfImageView:_midMgView imageStr:mModel.img_str];
            }
        }
    }
    return _midMgView;
}

-(UITapGestureRecognizer *)tapGesture{
    if (!_tapGesture) {
        _tapGesture =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
   
    }
    return _tapGesture;
}

-(UIImageView *)rightImgView{
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH *2, 0, SCREENWIDTH, SCREENHEIGHT)];
        _rightImgView.userInteractionEnabled = YES;
        if ([self.imgDataSource count] > 1) {
           id<LXRotateImageProtocol>rModel = self.imgDataSource[1];
            if ([self.delegate respondsToSelector:@selector(lx_setImageOfImageView:imageStr:)]) {
                [self.delegate lx_setImageOfImageView:_rightImgView imageStr:rModel.img_str];
            }
        }
        
    }
    return _rightImgView;
}

-(UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _scrollview.contentSize = CGSizeMake(SCREENWIDTH * 3, 0);
        _scrollview.pagingEnabled = YES;
        _scrollview.scrollEnabled = YES;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.bounces = NO;
        _scrollview.delegate = self;
        [self.scrollview setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:NO];
    }
    return _scrollview;
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    if (!_imgDataSource) return;
  
    if (_delegate && [_delegate respondsToSelector:@selector(lx_clickIntoNextPageWithIndex:)]) {
         [_delegate lx_clickIntoNextPageWithIndex:self.index % [self.imgDataSource count]];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(lx_clickIntoNextPageWithImageStr:)]) {
       id<LXRotateImageProtocol>lModel = self.imgDataSource[self.index % [self.imgDataSource count]];
        [_delegate lx_clickIntoNextPageWithImageStr:lModel.img_str];
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self resetImage];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self lx_stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self lx_StartTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == SCREENWIDTH * 2) {
        
        self.index ++ ;
        [self resetImage];
        
    }else if(scrollView.contentOffset.x == 0){
        
        self.index += (int)[self.imgDataSource count];
        self.index -- ;
        [self resetImage];
    }
}


//If UIImageview pictures, please call this method
-(void)resetImage{
    
    if (!_imgDataSource) return;

    [self.scrollview setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:NO];
    self.pageControl.currentPage = self.index % [self.imgDataSource count];
    
    if ([self.imgDataSource count] > 1) {
        
        id<LXRotateImageProtocol>lModel = self.imgDataSource[(self.index - 1) % [self.imgDataSource count]];
        if ([self.delegate respondsToSelector:@selector(lx_setImageOfImageView:imageStr:)]) {
            [self.delegate lx_setImageOfImageView:_leftImgView imageStr:lModel.img_str];
        }
        id<LXRotateImageProtocol>rModel = self.imgDataSource[(self.index + 1) % [self.imgDataSource count]];
        if ([self.delegate respondsToSelector:@selector(lx_setImageOfImageView:imageStr:)]) {
            [self.delegate lx_setImageOfImageView:_rightImgView imageStr:rModel.img_str];
        }
    }
    
    if ([self.imgDataSource count] > 0) {
        
        id<LXRotateImageProtocol>mModel = self.imgDataSource[self.index % [self.imgDataSource count]];
        if ([self.delegate respondsToSelector:@selector(lx_setImageOfImageView:imageStr:)]) {
            [self.delegate lx_setImageOfImageView:_midMgView imageStr:mModel.img_str];
        }
    }
}

-(void)lx_StartTimer{
    
    if (self.imgDataSource.count > 1) {
          [self __start];
    }else{
         [self __stop];
    }
  
}

-(void)lx_stopTimer{
    
    if (self.thread == nil) return;
    [self performSelector:@selector(__stop) onThread:self.thread withObject:nil waitUntilDone:YES];
}


#pragma mark - 私有方法
-(void)__start{
    
    if (![self.timer isValid]) {
        [self ceateTimer];
    }
}

-(void)__stop{
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.thread = nil;
        if (CFRunLoopGetCurrent()) {
            CFRunLoopStop(CFRunLoopGetCurrent());
        }
    }
}

-(void)dealloc{
    NSLog(@"----dealloc--%s",__func__);
    [self lx_stopTimer];

}

@end
