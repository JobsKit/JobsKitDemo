//
//  SingletonCustomClass.h
//  TestApp
//
//  Created by Jobs on 27/08/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingletonCustomClass : NSObject

+(SingletonCustomClass *)shareInstance;
+(void)tearDown;

@end

NS_ASSUME_NONNULL_END
