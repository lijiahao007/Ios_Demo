//
// Created by VINSON on 2023/3/20.
//

#import "MyNavigationDelegate.h"


@implementation MyNavigationDelegate {

}

// 该方法在viewController 即将显示时回调
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"willShowViewController  navigationController=%@, viewController=%@", navigationController, viewController);
}

// 该方法在viewController显示后回调
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"didShowViewController navigationController=%@, viewController=%@", navigationController, viewController);
}



@end