//
//  NSObject+Singleton.h
//  TestApp
//
//  Created by Jobs on 28/08/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Singleton)

+(NSObject *)shareInstanceWithClass:(Class)cls;
+(void)tearDown;

@end

NS_ASSUME_NONNULL_END
