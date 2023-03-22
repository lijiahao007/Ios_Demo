//
// Created by VINSON on 2023/3/20.
//

#import "MyViewController.h"


@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)click {
    NSLog(@"点击了返回");
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回成功");
    }];
}


@end