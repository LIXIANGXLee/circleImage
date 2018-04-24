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


@interface qqViewController ()<LXRotateImageViewDelegate>
{
    LXRotateImageView * v;
}
@end

@implementation qqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    v = [[LXRotateImageView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 260)];
    v.delegate = self;
    [self.view addSubview:v];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)lx_getImageDataSource{
    
    
    
    NSMutableArray * dataS = [NSMutableArray array];
    LXRotateImageModel * model = [[LXRotateImageModel alloc]init];
    model.img_str = @"http://img5.imgtn.bdimg.com/it/u=1244820289,2116300780&fm=200&gp=0.jpg";
    [dataS addObject:model];

    LXRotateImageModel * model1 = [[LXRotateImageModel alloc]init];
    model1.img_str = @"http://img1.imgtn.bdimg.com/it/u=2293999807,2071077178&fm=200&gp=0.jpg";
    [dataS addObject:model1];
    
    
 
    return dataS;
}


-(void)lx_clickIntoNextPageWithIndex:(int)index;
{
    NSLog(@"-=-=-=-%d",index);
}
@end
