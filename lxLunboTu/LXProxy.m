//
//  LXProxy.m
//  lxLunboTu
//
//  Created by 恒悦科技 on 2018/9/12.
//  Copyright © 2018年 LMTeam. All rights reserved.
//

#import "LXProxy.h"

@implementation LXProxy

+ (instancetype)proxyWithTarget:(id)target{
    LXProxy *proxy = [LXProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    [invocation invokeWithTarget:self.target];
}


@end
