//
//  MyCustomViewController.m
//  helloworld
//
//  Created by VINSON on 2023/4/2.
//

#import "MyCustomViewController.h"
#import <os/log.h>


@interface MyCustomViewController ()
@property (atomic) os_log_t logger;
@end

@implementation MyCustomViewController

- (instancetype)init {

    return [super init];
}

-(os_log_t) logger {
    if (_logger == nil) {
        _logger = os_log_create("com.example.helloworld", "MyCustomViewController");
    }
    return _logger;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    ProgressBar* progressBar = [[ProgressBar alloc]initWithFrame:CGRectMake(20, 100, screenWidth - 40, 40)];
    [self.view addSubview:progressBar];
    os_log_info(self.logger, "viewDidLoad %@", progressBar);
}



@end
