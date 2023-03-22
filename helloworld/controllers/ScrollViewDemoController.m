//
// Created by VINSON on 2023/3/21.
//

#import "ScrollViewDemoController.h"


@implementation ScrollViewDemoController {
    UIScrollView *_myScrollView;
    UIImageView *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startPage"]];

    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    // 1. 设置UIScrollView的滚动范围（内容大小）
    _myScrollView.contentSize = CGSizeMake(_imageView.frame.size.width, _imageView.frame.size.height);
    // 2. 设置UIScrollView 内容左上角在父控件中的位置
    _myScrollView.contentOffset = CGPointMake(0, 0);
    // 3. UIScrollView 内容四周增加的padding。
    _myScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 4. 设置UIScrollView代理
    _myScrollView.delegate = self;
    // 5. 设置缩放倍数 （不然默认都是1，不会缩放）
    _myScrollView.minimumZoomScale = 0.3;
    _myScrollView.maximumZoomScale = 3;

    _myScrollView.backgroundColor = [UIColor cyanColor];

    [_myScrollView addSubview:_imageView];
    [self.view addSubview:_myScrollView];

}

// 滚动时不断调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll  (%f,%f)", scrollView.contentOffset.x, scrollView.contentOffset.y);
}

// 开始滚动之前调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
}

// 滚动过程中，手指离开屏幕时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
}

// 指定需要缩放的View
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

// 开始缩放时调用
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    NSLog(@"scrollViewWillBeginZooming (%f,%f)", scrollView.contentSize.width, scrollView.contentSize.height);
}

// 结束缩放时调用
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    NSLog(@"scrollViewDidEndZooming (%f,%f)", scrollView.contentSize.width, scrollView.contentSize.height);
}

@end
