//
//  ViewController.m
//  TestApp
//
//  Created by Jobs on 27/08/2021.
//

#import "ViewController.h"
#import "TestVC.h"

@interface ViewController (){
    id dd;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self presentViewController:TestVC.new
                       animated:YES
                     completion:nil];
}

@end
