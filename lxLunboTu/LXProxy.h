//
//  LXProxy.h
//  lxLunboTu
//
//  Created by 恒悦科技 on 2018/9/12.
//  Copyright © 2018年 LMTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXProxy : NSProxy

+(instancetype)proxyWithTarget:(id)target;

@property (weak, nonatomic) id target;


@end
