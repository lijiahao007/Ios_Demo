//
//  SceneDelegate.m
//  helloworld
//
//  Created by VINSON on 2023/3/13.
//

#import "SceneDelegate.h"
#import "controllers/ViewController.h"
#import "controllers/Demo1ViewController.h"
#import "MyNavigationDelegate.h"
#import "controllers/MyNavigationController.h"
#import "controllers/ScrollViewDemoController.h"
#import "controllers/TableDemoController.h"
#import "controllers/CustomViewController.h"
#import "controllers/CollectionViewController.h"

// 这个类是用来管理ViewController的生命周期的
@interface SceneDelegate ()

@end

@implementation SceneDelegate {
}


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

    // ==========  底部导航栏demo ==========
    // 可以在该方法中设置rootViewController。（IOS13之后的版本在这里设置）
//    UITabBarController *tabBar = [[UITabBarController alloc]init];
//
//    // 设置ViewController作为根ViewController
//    ViewController *myView = [[ViewController alloc]init];
//    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:myView];
//    navigation.tabBarItem.title = @"导航";
//
//    UIViewController *view1 = [[UIViewController alloc]init];
//    view1.view.backgroundColor = [UIColor redColor];
//    view1.tabBarItem.title = @"文章";
//
//    UIViewController *view2 = [[UIViewController alloc]init];
//    view2.view.backgroundColor = [UIColor yellowColor];
//    view2.tabBarItem.title = @"新闻";
//
//    UIViewController *view3 = [[UIViewController alloc]init];
//    view3.view.backgroundColor = [UIColor greenColor];
//    view3.tabBarItem.title = @"视频";
//
//    UIViewController *view4 = [[UIViewController alloc]init];
//    view4.view.backgroundColor = [UIColor blueColor];
//    view4.tabBarItem.title = @"我的";
//
//    [tabBar setViewControllers:@[navigation,view1,view2,view3,view4] ];
//    self.window.rootViewController = tabBar;

// ============= 控制器跳转demo =============
//    // 1. 创建UIViewController
//    Demo1ViewController *controller = [[Demo1ViewController alloc] init];
//
//    // 2. 创建UINavigationController， 将上面的controller作为其跟controller
//    MyNavigationController *navigation = [[MyNavigationController alloc] initWithRootViewController:controller];
//    self.window.rootViewController = navigation;
//
//    // 3. 设置代理
//    [self.window makeKeyAndVisible]; // 显示window


// ============= ScrollView Demo ==============
//    ScrollViewDemoController *collectionDemoController = [[ScrollViewDemoController alloc] init];
//    self.window.rootViewController = collectionDemoController;
//    [self.window makeKeyAndVisible];


// ============== TableView Demo ============
//    TableDemoController *viewController = [[TableDemoController alloc] init];
//    self.window.rootViewController = viewController;
//    [self.window makeKeyAndVisible];

//    CustomViewController *viewController = [[CustomViewController alloc] init];
//    self.window.rootViewController = viewController;
//    [self.window makeKeyAndVisible];

    CollectionViewController* viewController = [[CollectionViewController alloc] init];
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
