//
//  MultiThreadTest.m
//  helloworldTests
//
//  Created by VINSON on 2023/3/21.
//

#import <XCTest/XCTest.h>

@interface MultiThreadTest : XCTestCase

@end

@implementation MultiThreadTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

// 并行队列 + 异步任务
- (void)testAsyncTaskAndParallelQueue {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSThread * currentThread = [NSThread currentThread];
    NSLog(@"currentThread: %@", currentThread);

    // 1. 获取并行队列
    dispatch_queue_t parallelQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // 2. 创建异步任务 (下面异步任务分别在不同的线程中执行)
    dispatch_async(parallelQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"1. %@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:1];
        }
    });

    dispatch_async(parallelQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"2. %@ (%d)", [NSThread currentThread], i);
            [NSThread sleepForTimeInterval:1];
        }
    });
    dispatch_async(parallelQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"3. %@ (%d)", [NSThread currentThread], i);
            [NSThread sleepForTimeInterval:1];
        }
    });

    for (int i = 0; i < 10; i++) {
        NSLog(@"main. %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    }
}

// 串行队列 + 异步任务
- (void)testAsyncTaskAndSerialQueue {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSThread * currentThread = [NSThread currentThread];
    NSLog(@"currentThread: %@", currentThread);

    // 1. 创建一个串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("mySerialQueue", NULL);

    // 2. 创建异步任务 (下面异步任务都在同一个线程中执行)
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"1. %@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:1];
        }
    });

    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"2. %@ (%d)", [NSThread currentThread], i);
            [NSThread sleepForTimeInterval:1];
        }
    });
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"3. %@ (%d)", [NSThread currentThread], i);
            [NSThread sleepForTimeInterval:1];
        }
    });

    for (int i = 0; i < 10; i++) {
        NSLog(@"main. %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    }
}

-(void) testThreadGroup {

    // 1. 创建一个分组
    dispatch_group_t group = dispatch_group_create();

    // 2. 获取并行队列
    dispatch_queue_t parallelQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // 3. 创建异步任务
    dispatch_group_async(group, parallelQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"1. %@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:1];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"1. 完成异步任务");
        });
    });

    dispatch_group_async(group, parallelQueue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"2. %@", [NSThread currentThread]);
            [NSThread sleepForTimeInterval:1];
        }

        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2. 完成异步任务");
        });
    });

    XCTestExpectation *expectation = [self expectationWithDescription:@"testThreadGroup"];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"3. 完成所有异步任务");
        [expectation fulfill];
    });

    // 等待某些expectation执行完成后再退出
//    [self waitForExpectations:@[expectation] timeout:100];

    // 等待所有expectation执行完成后再退出。
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error){
        NSLog(@"4. 超时");
    }];
}


-(void) testNSOperation {
    
    NSBlockOperation *task1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1. %@", [NSThread currentThread]);
    }];

    NSBlockOperation *task2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2. %@", [NSThread currentThread]);
    }];

    XCTestExpectation *expectation = [self expectationWithDescription:@"testNSOperation"];

    NSBlockOperation *task3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3. %@", [NSThread currentThread]);
        [expectation fulfill];
    }];

    [task2 addDependency:task1];
    [task3 addDependency:task2];
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [queue addOperation:task3];
    [queue addOperation:task2];
    [queue addOperation:task1];


    [self waitForExpectationsWithTimeout:10 handler:^(NSError* error){
        NSLog(@"完成");
    }];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
