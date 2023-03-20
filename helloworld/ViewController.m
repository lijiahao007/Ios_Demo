//
//  ViewController.m
//  helloworld
//
//  Created by VINSON on 2023/3/13.
//

#import "ViewController.h"
#import "CustomUIView.h"
#import "CustomCircleProgress.h"
#import "MyViewController.h"


@interface ViewController ()

@property(nonatomic, weak) CustomCircleProgress *mProgress;
@property(nonatomic, strong) UITextField *textField;

@end

@implementation ViewController {
    UITextRange *_range;
    __weak IBOutlet UIButton *btnJump;
    __weak IBOutlet UIButton *btnCreateSub;
    __weak IBOutlet UIButton *btnDelete;
    __weak IBOutlet UIButton *btnToNavigation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s  %d", __func__, __LINE__);
    // Do any additional setup after loading the view.
//    [self addRectViewToController];
//    [self addButtonToController];
//    [self addTextFieldToController];
//    [self addUiTabViewController];
//    [self jumpToNextController];
//    [self createSUbController];
}


- (void)createSUbController {
    [btnCreateSub addTarget:self action:@selector(createSub) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete addTarget:self action:@selector(deleteSub) forControlEvents:UIControlEventTouchUpInside];
}

- (void)deleteSub {
    NSLog(@"deleteSub");
    [self.childViewControllers.lastObject.view removeFromSuperview];
    [self.childViewControllers.lastObject removeFromParentViewController];
}

- (void)createSub {
    NSLog(@"createSub");
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2);
    controller.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:controller.view];
    [self addChildViewController:controller];
}

- (void)jumpToNextController {
    [btnJump addTarget:self action:@selector(jumpToNext) forControlEvents:UIControlEventTouchUpInside];
}

- (void)jumpToNext {
    MyViewController *myView = [[MyViewController alloc] init];
    [self presentViewController:myView animated:YES completion:^{
        NSLog(@"presentViewController completion 完成");
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    NSLog(@"prepareForSegue %@,  src:%@,  dest:%@", segue.identifier, segue.sourceViewController, segue.destinationViewController);
}


- (void)addUiTabViewController {
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor blueColor];
    view2.frame = CGRectMake(150, 150, 100, 100);
    [self.view addSubview:view2];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushCtl)];
    [view2 addGestureRecognizer:gesture];
}

- (void)pushCtl {
    UIViewController *con = [[UIViewController alloc] init];
    con.view.backgroundColor = [UIColor whiteColor];
    con.navigationItem.title = @"图片展示";
    con.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" menu:nil];

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(100, 100, 100, 100);
    [con.view addSubview:view];

    [self.navigationController pushViewController:con animated:YES];
}


- (void)addTextFieldToController {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
    textField.backgroundColor = [UIColor grayColor];
    textField.textColor = [UIColor whiteColor];
    textField.placeholder = @"请输入文字";
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.delegate = self;
    [self.view addSubview:textField];
    self.textField = textField;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"开始编辑");
}

// 例如弹窗等，会结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"结束编辑 reason=%@", [NSValue value:&reason withObjCType:@encode(UITextFieldDidEndEditingReason)]);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"修改了字符 %@ [%zd, %zd]", string, range.location, range.length);

    NSLog(@"\t\tafter len=%zd", textField.text.length + string.length);

    if (textField.text.length + string.length >= 10) {
        return NO;
    } else {
        return YES;
    }
}


- (void)textFieldDidChangeSelection:(UITextField *)textField {
    _range = textField.selectedTextRange;
    if (![_range.start isEqual:_range.end]) {
        NSLog(@"选择了字符: %@", [textField textInRange:_range]);
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"点击了return");
    // 释放第一响应者的身份
    [textField resignFirstResponder];
    NSString *text = textField.text;
    if ([text isEqual:@""]) {
        [self showAlertToast:@"" message:@"你输入了空的字符串" sheetOrAlert:NO duration:1];
    } else {
        [self showAlertToast:@"" message:textField.text sheetOrAlert:NO duration:1];
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.textField resignFirstResponder];
}


- (void)addButtonToController {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 400, 100, 100);
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    button.backgroundColor = [UIColor grayColor];
    button.tintColor = [UIColor whiteColor];
    [button setTitle:@"按钮--正常状态" forState:UIControlStateNormal];
    [button setTitle:@"按钮--高亮状态" forState:UIControlStateHighlighted];
    [button setTitle:@"按钮--focus状态" forState:UIControlStateFocused];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10); // 增加padding
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail; // 尾部显示省略号
    [self.view addSubview:button];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    view.alpha = 0.5;
    [self.view addSubview:view];

}

- (void)clickButton:(id)clickButton {
    NSLog(@"点击按钮");
    [self showAlertToast:@"按钮" message:@"点击按钮" sheetOrAlert:NO duration:0.5];
}


- (void)addRectViewToController {
    UIView *yellowView = [[UIView alloc] init];
    // 设置起始位置和大小
    yellowView.frame = CGRectMake(100, 100, 200, 200);
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.tag = 1;
    [self.view addSubview:yellowView];
    NSLog(@"yellowView.frame=%@", NSStringFromCGRect(yellowView.frame));
    NSLog(@"yellowView.bounds=%@", NSStringFromCGRect(yellowView.bounds));
    NSLog(@"yellowView.center=%@", NSStringFromCGPoint(yellowView.center));
    [self setGestureRecognizer:yellowView];

    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(0, 0, 100, 100);
    redView.backgroundColor = [UIColor redColor];
    redView.tag = 2;
    [self.view addSubview:redView];
    NSLog(@"redView.frame=%@", NSStringFromCGRect(redView.frame));
    NSLog(@"redView.bounds=%@", NSStringFromCGRect(redView.bounds));
    NSLog(@"redView.center=%@", NSStringFromCGPoint(redView.center));
    [self setGestureRecognizer:redView];


    UIView *blueView = [[UIView alloc] init];
    blueView.frame = CGRectMake(0, 0, 100, 100);
    blueView.backgroundColor = [UIColor blueColor];
    blueView.tag = 3;
    [yellowView addSubview:blueView];
    NSLog(@"blueView.frame=%@", NSStringFromCGRect(blueView.frame));
    NSLog(@"blueView.bounds=%@", NSStringFromCGRect(blueView.bounds));
    NSLog(@"blueView.center=%@", NSStringFromCGPoint(blueView.center));
    [self setGestureRecognizer:blueView];

    CustomUIView *customView = [[CustomUIView alloc] init];
    customView.frame = CGRectMake(200, 300, 100, 100);
    customView.backgroundColor = [UIColor greenColor];
    customView.tag = 4;
    [self.view addSubview:customView];
    [self setGestureRecognizer:customView tapRequire:1];

    // 一个圆形进度条
    CustomCircleProgress *progress = [[CustomCircleProgress alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:progress];
    self.mProgress = progress;
    UITapGestureRecognizer *progressTabRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickProgress:)];
    [progress addGestureRecognizer:progressTabRecognizer];
    [progress setProgress:0.3f];

    UIView *view = [self.view viewWithTag:3];
    view.backgroundColor = [UIColor blackColor];

}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
//    NSLog(@"preferredStatusBarStyle");
    return UIStatusBarStyleLightContent;
}


- (void)clickProgress:(UITapGestureRecognizer *)sender {
    CGFloat progress = self.mProgress.progress;
    float newProgress = (float) ((progress + 0.01) > 1 ? (progress + 0.01 - 1) : progress + 0.01);
    [self.mProgress setProgress:newProgress];
}

- (void)setGestureRecognizer:(UIView *)uiView {
    // 一个GestureRecognizer一般只能绑定一个UIView
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [uiView addGestureRecognizer:longPressGestureRecognizer];
    [uiView addGestureRecognizer:tapGestureRecognizer];
    longPressGestureRecognizer.minimumPressDuration = 2; // 以秒为单位
}

- (void)setGestureRecognizer:(UIView *)uiView tapRequire:(int)tapNumber {
    // 如果即设置了单击手势识别，又设置了双击手势识别。这时只会触发单击手势识别，（或者说点击事件被单击手势识别器消耗了）
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTapGestureRecognizer.numberOfTapsRequired = (NSUInteger) tapNumber;
    [uiView addGestureRecognizer:longPressGestureRecognizer];
    [uiView addGestureRecognizer:doubleTapGestureRecognizer];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)gestureRecognizer {
    NSLog(@"长按事件");
    // 手势识别器识别出手势了
    [self showAlertToast:@"长按" message:[NSString stringWithFormat:@"长按事件 to %zd", gestureRecognizer.view.tag] sheetOrAlert:NO duration:1];
}

- (void)tapAction:(UITapGestureRecognizer *)gestureRecognizer {
    NSLog(@"点击事件");
    [self showAlertToast:@"点击" message:[NSString stringWithFormat:@"点击事件 to %zd", gestureRecognizer.view.tag] sheetOrAlert:NO duration:1];
}

- (void)doubleTapAction:(UITapGestureRecognizer *)gestureRecognizer {
    NSLog(@"双击事件");
    [self showAlertToast:@"双击" message:[NSString stringWithFormat:@"双击事件 to %zd", gestureRecognizer.view.tag] sheetOrAlert:NO duration:1];
}

- (void)showAlertToast:(NSString *)title message:(NSString *)message sheetOrAlert:(BOOL)isSheet duration:(long)duration {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:isSheet ? UIAlertControllerStyleActionSheet : UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:^{
        NSLog(@"alert 已显示");
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:^{
            NSLog(@"alert dismiss 完成");
        }];
    });
}

@end
