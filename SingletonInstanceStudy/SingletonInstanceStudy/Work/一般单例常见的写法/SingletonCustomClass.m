//
//  SingletonCustomClass.m
//  TestApp
//
//  Created by Jobs on 27/08/2021.
//

#import "SingletonCustomClass.h"
// 单例的健壮性
@implementation SingletonCustomClass

-(void)dealloc{
    NSLog(@"");
}

static SingletonCustomClass *_instance = nil;
static dispatch_once_t onceToken;
+(SingletonCustomClass *)shareInstance{
    /**
     dispatch_once主要是根据onceToken的值来决定怎么去执行代码。
     当onceToken = 0时，线程执行dispatch_once的block中代码
     当onceToken = -1时，线程跳过dispatch_once的block中代码不执行
     当onceToken为其他值时，线程被阻塞，等待onceToken值改变
     
     _predicate 是系统级别的抛出值，人为不应该进行强制干预，除非销毁单例的时候
     */
    
    dispatch_once(&onceToken, ^{
        //不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
        //已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）的功能来帮助出处理底层内存分配的杂物
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance ;
}

+(void)tearDown{
    _instance = nil;
    onceToken = 0;
}
//用alloc返回也是唯一实例
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [SingletonCustomClass shareInstance];
}
//对对象使用copy也是返回唯一实例
-(instancetype)copyWithZone:(NSZone *)zone {
    return [SingletonCustomClass shareInstance];//return _instance;
}
//对对象使用mutablecopy也是返回唯一实例
-(id)mutableCopyWithZone:(NSZone *)zone {
    return [SingletonCustomClass shareInstance];
}
/*

 当static关键字修饰局部变量时，只会初始化一次且在程序中只有一份内存
 allocWithZone mutablecopyWithZone 这个类遵守<NSCopying,NSMutableCopying>协议
 如果_instance = [self alloc] init];创建的话，
 将会和-(id) allocWithZone:(struct _NSZone *)zone产生死锁。
 dispatch_once中的onceToken线程被阻塞，等待onceToken值改变。
 当用alloc创建对象、以及对对象进行copy mutableCopy也是返回唯一实例

 */


@end
