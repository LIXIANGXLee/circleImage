//
//  qqViewController.m
//  lxLunboTu
//
//  Created by 恒悦科技 on 2017/6/2.
//  Copyright © 2017年 LMTeam. All rights reserved.
//

#import "qqViewController.h"
#import "LXRotateImageView.h"
#import "LXRotateImageModel.h"
#import <UIImageView+WebCache.h>


@interface qqViewController ()<LXRotateImageViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) LXRotateImageView * v;

@property(nonatomic,strong)UITableView * l_tableView;

@end

@implementation qqViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//     [_v lx_stopTimer];
//     [_v lx_stopTimer];
//     [_v lx_stopTimer];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_v lx_StartTimer];
     [_v lx_StartTimer];
    [_v lx_StartTimer];

}

- (void)viewDidLoad {
    [super viewDidLoad];
   LXRotateImageView * v = [[LXRotateImageView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 260)];
    v.delegate = self;
  
       [self.view addSubview:v];
    _v = v;
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray * dataS = [NSMutableArray array];
        LXRotateImageModel * model = [[LXRotateImageModel alloc]init];
        model.img_str = @"http://img5.imgtn.bdimg.com/it/u=1244820289,2116300780&fm=200&gp=0.jpg";
        [dataS addObject:model];
        
        LXRotateImageModel * model1 = [[LXRotateImageModel alloc]init];
        model1.img_str = @"http://img1.imgtn.bdimg.com/it/u=2293999807,2071077178&fm=200&gp=0.jpg";
        [dataS addObject:model1];
        
        _v.imgDataSource = dataS;
        
//    });
    
   
    
    _l_tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,  500, 320, 200) style:UITableViewStyleGrouped];
    _l_tableView.delegate = self;
    _l_tableView.dataSource = self;    
    [_l_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_l_tableView];
}

- (void)haha{
   
    
    NSMutableArray * dataS = [NSMutableArray array];
    LXRotateImageModel * model = [[LXRotateImageModel alloc]init];
    model.img_str = @"http://img5.imgtn.bdimg.com/it/u=1244820289,2116300780&fm=200&gp=0.jpg";
    [dataS addObject:model];
    
    LXRotateImageModel * model1 = [[LXRotateImageModel alloc]init];
    model1.img_str = @"http://img1.imgtn.bdimg.com/it/u=2293999807,2071077178&fm=200&gp=0.jpg";
    [dataS addObject:model1];
    
    _v.imgDataSource = dataS;
}


-(void)lx_clickIntoNextPageWithIndex:(int)index;
{
    NSLog(@"-=-=lx_clickIntoNextPageWithIndex=-%d==%@",index,[NSThread currentThread]);
}
-(void)lx_clickIntoNextPageWithImageStr:(NSString *)imageStr;
{
     NSLog(@"-=-=-lx_clickIntoNextPageWithImageStr=-%@",imageStr);
}

-(void)lx_setImageOfImageView:(UIImageView *)imageView imageStr:(NSString *)imageStr{
    
     [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{

        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
  
    return nil;
    
}

-(void)dealloc{

    NSLog(@"----dealloc--%s",__func__);
//    [_v lx_stopTimer];
//    [_v lx_stopTimer];
}

@end
