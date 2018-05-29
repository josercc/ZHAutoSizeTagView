//
//  ViewController.m
//  ZHAutoSizeTagView Example
//
//  Created by 张行 on 2018/5/11.
//  Copyright © 2018年 张行. All rights reserved.
//

#import "ViewController.h"
#import <ZHAutoSizeTagView/ZHAutoSizeTagView-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZHAutoSizeTagView *view = [[ZHAutoSizeTagView alloc] initWithFrame:CGRectMake(0, 0, 320, 40) block:^(ZHAutoSizeTagManager * _Nonnull manager) {
        manager.tagTitle = @[@"测试"];
    }];
    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
