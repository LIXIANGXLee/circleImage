//
//  aaViewController.m
//  lxLunboTu
//
//  Created by budgetoutsource on 2017/3/2.
//  Copyright © 2017年 LMTeam. All rights reserved.
//

#import "aaViewController.h"
#import "LXRotateImageView.h"
#import "qqViewController.h"

@interface aaViewController ()

@end

@implementation aaViewController
{
    LXRotateImageView * v;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(20, 200, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(haha) forControlEvents:UIControlEventTouchUpInside];
}

-(void)haha{
    qqViewController * vv = [[qqViewController alloc]init];
    
    [self.navigationController pushViewController:vv animated:YES];
}



@end
