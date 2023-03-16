//
//  helloworld.m
//  helloworld
//
//  Created by VINSON on 2023/3/14.
//

#import "Player.h"

@implementation Player

+(Player *) player {
    // 初始化
    Player *player = [[Player alloc] init];
    player.magicPoint = 100;
    player.healthPoint = 100;
    return player;
}

-(void) magicAttack {
    static int attackNum = 0;
    self.magicPoint -= 10;
    NSLog(@"magicAttack  剩余魔法值：%ld --- 生命值：%d", self.magicPoint, _healthPoint);
    attackNum++;
    NSLog(@"当前攻击次数=%d", attackNum);
}

-(void) normalAttack {
    NSLog(@"normalAttack  剩余魔法值：%ld --- 生命值：%d", self.magicPoint, _healthPoint);
}


@synthesize magicPoint = _magicPoint;

-(long) magicPoint {
    if (_magicPoint == 100) {
        NSLog(@"魔法值已满");
    } else if (_magicPoint <= 0) {
        NSLog(@"魔法值已空");
    }
    return _magicPoint;
}

-(void) setMagicPoint:(long)magicPoint {
    NSLog(@"魔法值更改了 %ld -> %ld", _magicPoint, magicPoint);
    _magicPoint = magicPoint;
}

-(NSString*) repeatSay:(int)count repeatValue:(NSString *)str {
    NSString* res = [[NSString alloc]init];
    for (int i = 0; i < count; i++) {
        res = [res stringByAppendingString:str];
    }
    return res;
}

-(void) tempFunction {
    NSLog(@"tempFunction");
}

// %@打印时调用的函数
-(NSString*) description {
    return [NSString stringWithFormat:@"Player{healthPoint=%d, magicPoint=%ld}", self.healthPoint, self.magicPoint];
}

// [player class] 时调用的函数
+(NSString*) description {
    return @"这是一个Player类";
}

-(NSString* (^)(void)) getPrintWay:(int)way {
    switch(way) {
        case 0:
            return ^{
                return @"printWay1";
            };
        case 1:
            return ^{
                return @"printWay2";
            };
        default:
            return ^{
                return @"defaultPrintWay";
            };
    }
}

-(void) sayMagicPoint {
    NSLog(@"Player sayMarginPoint=%ld", _magicPoint);
}

-(void) sayHealthPoint {
    NSLog(@"Player sayHealthPoint=%d", _healthPoint);
}

@end
