//
// Created by VINSON on 2023/3/21.
//

#import "CustomViewController.h"
#import "MyNibView.h"

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MyNibView *view = [MyNibView initFromNib];
    view.frame = CGRectMake(0, 0, [self getScreenSize].width, [self getScreenSize].height);
    [self.view addSubview:view];
}


- (CGSize)getScreenSize {
    CGSize size = self.view.window.windowScene.screen.bounds.size;
    NSLog(@"size=(%f, %f)", size.width, size.height);
    return size;
}

@end
