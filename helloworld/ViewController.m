//
//  ViewController.m
//  helloworld
//
//  Created by VINSON on 2023/3/13.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addRectViewToController];
}


-(void) addRectViewToController {
    UIView* yellowView = [[UIView alloc]init];
    // 设置起始位置和大小
    yellowView.frame = CGRectMake(100, 100, 200, 200);
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    NSLog(@"yellowView.frame=%@", NSStringFromCGRect(yellowView.frame));
    NSLog(@"yellowView.bounds=%@", NSStringFromCGRect(yellowView.bounds));
    NSLog(@"yellowView.center=%@", NSStringFromCGPoint(yellowView.center));
    
    UIView* redView = [[UIView alloc]init];
    redView.frame = CGRectMake(0, 0, 100, 100);
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    NSLog(@"redView.frame=%@", NSStringFromCGRect(redView.frame));
    NSLog(@"redView.bounds=%@", NSStringFromCGRect(redView.bounds));
    NSLog(@"redView.center=%@", NSStringFromCGPoint(redView.center));
    
    
    UIView* blueView = [[UIView alloc]init];
    blueView.frame = CGRectMake(0, 0, 100, 100);
    blueView.backgroundColor = [UIColor blueColor];
    [yellowView addSubview:blueView];
    NSLog(@"blueView.frame=%@", NSStringFromCGRect(blueView.frame));
    NSLog(@"blueView.bounds=%@", NSStringFromCGRect(blueView.bounds));
    NSLog(@"blueView.center=%@", NSStringFromCGPoint(blueView.center));
}

-(BOOL) prefersStatusBarHidden{
    return YES;
}

@end
