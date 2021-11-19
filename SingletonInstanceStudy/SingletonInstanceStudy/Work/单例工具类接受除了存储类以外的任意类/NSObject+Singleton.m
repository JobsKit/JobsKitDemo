//
//  NSObject+Singleton.m
//  TestApp
//
//  Created by Jobs on 28/08/2021.
//

#import "NSObject+Singleton.h"

@implementation NSObject (Singleton)

static NSObject *instance = nil;
static dispatch_once_t oT;
+(NSObject *)shareInstanceWithClass:(Class)cls{
    /**
     dispatch_once主要是根据onceToken的值来决定怎么去执行代码。
     当onceToken = 0时，线程执行dispatch_once的block中代码
     当onceToken = -1时，线程跳过dispatch_once的block中代码不执行
     当onceToken为其他值时，线程被阻塞，等待onceToken值改变
     
     _predicate 是系统级别的抛出值，人为不应该进行强制干预，除非销毁单例的时候
     */
    
    /**
     这三种存储类是类簇，底层实现相较于其他类是有所区别的
     所以涉及到的这三类的操作都要有谨慎，比如不建议对他们进行继承
     */
    if ([NSStringFromClass(cls) isEqualToString:@"NSArray"] ||
        [NSStringFromClass(cls) isEqualToString:@"NSDictionary"] ||
        [NSStringFromClass(cls) isEqualToString:@"NSSet"]) {
        return nil;
    }
    
    dispatch_once(&oT, ^{
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        instance = [[cls allocWithZone:NULL] init];
    });
    return instance ;
}

+(void)tearDown{
    instance = nil;
    oT = 0;
}

@end
