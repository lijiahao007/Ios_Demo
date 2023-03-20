//
//  helloworldTests.m
//  helloworldTests
//
//  Created by VINSON on 2023/3/13.
//

#import <XCTest/XCTest.h>
#import "Player.h"
#import "Player+PlayerExtension.h"
#import "SpeakMethod.h"

@interface helloworldTests : XCTestCase

@end

@implementation helloworldTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void) testString {
    [self calStringLen:@"你"];
    [self calStringLen:@"好"];
    [self calStringLen:@"ni"];
    [self calStringLen:@"hao"];
}

-(void) calStringLen: (NSString*) str {
    NSLog(@"%@ --- %zd", str, str.length);
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSLog(@"helloworldTest");
    
    Player* player = [Player player];
    [player magicAttack];
    [player normalAttack];
    [player magicAttack];
    [player magicAttack];
    [player magicAttack];
    [player magicAttack];
    [player magicAttack];
    [player magicAttack];
    [player magicAttack];
    [player magicAttack];
    [player magicAttack];
    [player magicAttack];
    [player magicAttack];
    	
    NSLog(@"end");
    player.magicPoint; // 实际上调用的是player magicPoint变量的getter。
    
    NSString *res = [player repeatSay:10 repeatValue:@"Hello "];
    NSLog(@"repeatSay=【%@】", res);
    
    
    bool canResponseToSelector = [player respondsToSelector:@selector(repeatSay:repeatValue:)];
    NSLog(@"canResponseTo repeatSay %d", canResponseToSelector);
    
    NSString *str = @"是否相等";
    NSString *str1 = @"是否相等";
    NSString *str2 = @"不相等啊";
    
    bool isSame0 = [str isEqual:str1];
    bool isSame1 = [str isEqual:str2];
    NSLog(@"%d",isSame0);
    NSLog(@"%d", isSame1);

    int number = 10;
    int otherNumber = 20;
  
    // 常量指针 （指向的地址不能变）
    int* const pInt2 = &number;
//    pInt2 = &otherNumber; // wrong
    *pInt2 = 20;
    
    // 指向常量的指针 （指向的地址对应的内容不能变）
    const int * pInt3 = &number;
    pInt3 = &otherNumber;
//    *pInt3 = 20; // wrong
     
    // 指向常量的常量指针 （上两者的结合）
    const int * const pInt4 = &number;
//    pInt4 = &otherNumber; // wrong
//    *pInt4 = 20; //wrong
    
    // 相当于 const int *
    int const * pInt5 = &number;
    pInt5 = &otherNumber;
//    *pInt5 = 20; // wrong
 
    const NSString* string1 = @"Hellow";
    NSLog(@"%p %@", string1, string1);
    string1 = @"hellow2";
    NSLog(@"%p %@", string1, string1);
    
    
    NSString* const string2 = @"Hellow";
    NSLog(@"%p %@", string2, string2);
//    string2 = @"hellow2"; // wrong
    NSLog(@"%p %@", string2, string2);
    
    NSString const * string3 = @"Hellow";
    NSLog(@"%p %@", string3, string3);
//    string2 = @"hellow2"; // wrong
    NSLog(@"%p %@", string3, string3);
    
    NSLog(@"%p", @"Hellow");
    
    NSString *subString0 = [@"0123456789" substringFromIndex:3];
    NSString *subString1 = [@"0123456789" substringToIndex:3];
    NSString *subString2 = [@"0123465789" substringWithRange:NSMakeRange(3, 5)];
    NSLog(@"%@", subString0);
    NSLog(@"%@", subString1);
    NSLog(@"%@", subString2);
    
    NSInteger convertInt = [@"1335" integerValue];
    NSLog(@"convertInt=%zd", convertInt);

}


-(void) test2 {
    NSMutableDictionary* mDic = [NSMutableDictionary dictionary];
    mDic[@"website"] = @"www.baidu.com";
    NSLog(@"%@", mDic[@"website"]);
    NSLog(@"%@", mDic);
    
    
    NSNumber* intNumber = @10;
    NSLog(@"%@", intNumber);
    
    NSDate* date = [NSDate date];
    NSLog(@"国际标准时间：%@", date);
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSLog(@"时区：%@", zone);
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSLog(@"当前时区与GMT时区间隔的秒数=%zd", interval);
    NSDate* localDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    NSLog(@"本地时间=%@", localDate);
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    // NSDateFormetter 在格式化时，默认会在传入的date里加上时区。
    // 因为我们的localDate已经手动加上了时区，如果NSDateFormatter又加就重复了。
    // 所以这里需要将timeZoneForSeondsFromGMT设置为0
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString* localDateStr = [df stringFromDate:localDate];
    NSLog(@"%@", localDateStr);
    
    
    Player* player = [Player player];
    NSLog(@"player=%@", player);
    
    NSLog(@"date=%@", [df stringFromDate:date]);
    NSLog(@"localDate=%@", [df stringFromDate:localDate]);
    
    NSDate* earilerCompare = [date earlierDate:localDate];
    NSLog(@"earilerCompate=%@", [df stringFromDate:earilerCompare]);
    
    NSDate* laterCompare = [date laterDate:localDate];
    NSLog(@"laterCompare=%@", [df stringFromDate:laterCompare]);
}

-(void) testFileManager {
    // 目录的绝对路径
    NSString *directoryPath = @"/Users/vinson/Desktop";

    NSArray* desktopPaths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, true);
    NSLog(@"%@", desktopPaths);
    NSString* desktopPath = desktopPaths[0];
    NSLog(@"%@", desktopPath);
    
    NSString* filePath1 = [directoryPath stringByAppendingPathComponent:@"mytext.txt"];
    NSString* filePath2 = [desktopPath stringByAppendingPathComponent:@"mytext.txt"];
    NSLog(@"filePath1=%@", filePath1);
    NSLog(@"filePath2=%@", filePath2);
    
    NSFileManager* fm = [NSFileManager defaultManager];
    bool isPath1Exists = [fm fileExistsAtPath:filePath1];
    bool isPath2Exists = [fm fileExistsAtPath:filePath2];
    NSLog(@"isPath1Exists=%d", isPath1Exists);
    NSLog(@"isPath2Exists=%d", isPath2Exists);
    
    
    
    NSData* fileData = [fm contentsAtPath:filePath1];
    NSString* fileContent = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    NSLog(@"fileContent=%@", fileContent);

}



-(void)testBlock{
    NSString* (^printBlock)(int, NSString*) = ^(int repeatCount, NSString* content) {
        NSMutableString* res = [NSMutableString stringWithCapacity:content.length * repeatCount];
        for (int i = 0; i < repeatCount; i++) {
            [res appendString:content];
        }
        return res;
    };
    
    NSString* res = printBlock(10, @"Helloworld");
    NSLog(@"%@", res);
    
    [self myPrint:^{
        return @"Helloworld";
    }];
    
    Player* player = [Player player];
    NSString* res1 = [player getPrintWay:0]();
    NSString* res2 = [player getPrintWay:1]();
    NSString* res3 = [player getPrintWay:2]();
    NSLog(@"res1=%@ \n res2=%@ \n res3=%@", res1, res2, res3);
}

-(void) myPrint:(NSString* (^) (void)) printBlock {
    NSString* res = printBlock();
    NSLog(@"res=%@", res);
}

-(void) testCategory {
    Player* player = [Player player:100 magicPoint:100L];
    [player printExtendInfo];
    
    Player* player1 = [Player player];
    NSLog(@"%@", player1);
    NSLog(@"%@", [player1 class]);
}

-(void) testProtocal {
    NSString* (^speak)(id<SpeakMethod>) = ^(id<SpeakMethod> speaker) {
        [speaker sayMagicPoint];
        [speaker sayHealthPoint];
        
        if([speaker respondsToSelector:@selector(sayMagicPointAndHealthPoint)]) {
            NSLog(@"实现了 sayMagicPointAndHealthPoint");
            [speaker sayMagicPointAndHealthPoint];
        } else {
            NSLog(@"没有实现 sayMagicPointAndHealthPoint");
        }
        
        return @"ok";
    };
    
    Player* player=[Player player];
    NSString* isFinishSpeak = speak(player);
    NSLog(@"isFinishSpeak=%@", isFinishSpeak);
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{

    }];
}

@end
