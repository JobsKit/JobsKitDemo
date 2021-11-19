//
//  TestVC.m
//  TestApp
//
//  Created by Jobs on 27/08/2021.
//

#import "TestVC.h"
#import "SingletonCustomClass.h"
#import "NSObject+Singleton.h"
#import "TestCustomClass.h"
#import "TestClass.h"

@interface TestVC (){
    
    NSObject *ff;
    NSObject *mm;
    NSObject *dd;
    NSObject *gg;
    NSObject *kk;
}

@end

@implementation TestVC

-(void)dealloc{
    NSLog(@"");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.cyanColor;
    [self test];
}

-(void)test{

    ff = SingletonCustomClass.shareInstance;
    mm = [NSObject shareInstanceWithClass:SingletonCustomClass.class];
    gg = [NSObject shareInstanceWithClass:NSDictionary.class];
    
    dd = [NSObject shareInstanceWithClass:TestCustomClass.class];
    kk = [NSObject shareInstanceWithClass:TestClass.class];
    
//    NSLog(@"%p",gg);
    NSLog(@"");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    [SingletonCustomClass tearDown];
    
    [NSObject tearDown];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
