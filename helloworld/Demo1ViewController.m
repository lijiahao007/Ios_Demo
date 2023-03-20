//
// Created by VINSON on 2023/3/20.
//

#import <UIKit/UIKit.h>
#import "Demo1ViewController.h"
#import "MyNavigationDelegate.h"


@implementation Demo1ViewController {
    MyNavigationDelegate *_myNavigationDelegate;
    NSArray *_rightItems;
}

static int count = 0;
int finalCount = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    count++;
    finalCount = count;
    [self addSubNavigationController];
    NSLog(@"%s  %d  count=%d", __func__, __LINE__, finalCount);

    [self setNavigationItem];
}

- (void)setNavigationItem {
    // 创建自定义的导航栏
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
            initWithTitle:@"返回"
                    style:UIBarButtonItemStylePlain
                   target:self
                   action:@selector(backUp)];

    self.navigationItem.leftBarButtonItem = leftItem;

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"详情1" style:UIBarButtonItemStylePlain target:self action:@selector(detail)];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"详情2" style:UIBarButtonItemStylePlain target:self action:@selector(detail1)];
    _rightItems = @[rightItem, rightItem1];
    self.navigationItem.rightBarButtonItems = @[rightItem, rightItem1];

    // navigation delegate
    _myNavigationDelegate = [[MyNavigationDelegate alloc] init];
    self.navigationController.delegate = _myNavigationDelegate;
}

BOOL isClick = NO;

- (void)detail {
    NSLog(@"%s  %d", __func__, __LINE__);
    self.navigationItem.rightBarButtonItems = isClick ? @[_rightItems[0]] : @[_rightItems[0], _rightItems[1]];
    isClick = !isClick;
}

- (void)detail1 {
    NSLog(@"%s  %d", __func__, __LINE__);
}

- (void)backUp {
    NSLog(@"%s  %d", __func__, __LINE__);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"destinationReturn" object:self.data];

    [self.navigationController popViewControllerAnimated:YES];
    if (finalCount != 1) {
        count--;
    }
}

- (void)addSubNavigationController {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = finalCount % 2 == 1 ? [UIColor blueColor] : [UIColor cyanColor];
    view.frame = CGRectMake(150, 150, 100, 100);
    [self.view addSubview:view];

    self.title = [NSString stringWithFormat:@"导航 %d", finalCount];
    self.view.backgroundColor = finalCount % 2 == 1 ? [UIColor cyanColor] : [UIColor blueColor];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateToNext)];
    [view addGestureRecognizer:gesture];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.data == nil) {
        self.data = @"";
    }
    NSLog(@"viewDidAppear  %d data=%@", finalCount, self.data);
}




- (void)navigateToNext {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:@"destinationReturn" object:nil];

    Demo1ViewController *controller = [[Demo1ViewController alloc] init];
    controller.data = [NSString stringWithFormat:@"%d %@",finalCount, self.data];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)receiveMessage:(NSNotification *)receiveMessage {
    NSLog(@"%d receiveMessage-- %@", finalCount, receiveMessage.object);
}

- (void)dealloc {
    NSLog(@"dealloc %d", finalCount);
    // 清除通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end