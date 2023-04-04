//
//  NetworkTest.m
//  helloworldTests
//
//  Created by VINSON on 2023/3/22.
//

#import <XCTest/XCTest.h>

@interface NetworkTest : XCTestCase <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property(nonatomic, strong) XCTestExpectation *expectation;
@end

@implementation NetworkTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

// api : https://api.thecatapi.com/v1/images/search?limit=1
// NSURLConnection
- (void)testNSURLConnection {
    NSURL *url = [NSURL URLWithString:@"https://api.thecatapi.com/v1/images/search?limit=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"str: %@", str);
}

// ===== NSURLConnection异步请求1 begin =====

- (void)testURLConnection1 {
    _expectation = [self expectationWithDescription:@"testNSURLConnection1"];
    NSURL *url = [NSURL URLWithString:@"https://api.thecatapi.com/v1/images/search?limit=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *_Nullable response, NSData *_Nullable data, NSError *_Nullable connectionError) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"str: %@", str);
        [_expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *_Nullable error) {
        NSLog(@"已完成: %@", error);
    }];
}

// ===== NSURLConnection异步请求1 end =====

// ===== NSURLConnection异步请求2 begin =====
- (void)testNSURLConnection2 {
    _expectation = [self expectationWithDescription:@"testNSURLConnection2"];
    NSURL *url = [NSURL URLWithString:@"https://api.thecatapi.com/v1/images/search?limit=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *_Nullable error) {
        NSLog(@"error: %@", error);
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"didReceiveData  str: %@", str);
    [_expectation fulfill];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse response: %@", response);
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError error: %@", error);
    [_expectation fulfill];
}

// ===== NSURLConnection 异步请求 end =======

// ===== NSURLSession 异步请求 begin =====

- (void)testURLSession {
    _expectation = [self expectationWithDescription:@"testURLSession"];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"https://api.thecatapi.com/v1/images/search?limit=1"]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"str: %@", str);
                [self->_expectation fulfill];
            }] resume];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError *_Nullable error) {
        NSLog(@"testURLSession 已完成: %@", error);
    }];
}

// ===== NSURLSession 异步请求 end =====


// ===== 测试指定网络请求的DNS服务器 ====

-(void)testDns {
        
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
