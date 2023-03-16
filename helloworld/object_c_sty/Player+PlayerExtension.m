//
//  Player+PlayerExtension.m
//  helloworld
//
//  Created by VINSON on 2023/3/16.
//

#import "Player+PlayerExtension.h"

@implementation Player (PlayerExtension)

+(Player*) player:(int)healthPoint magicPoint:(long)magicPoint {
    Player* player = [[Player alloc]init];
    player.healthPoint = healthPoint;
    player.magicPoint = magicPoint;
    return player;
}

-(void) printExtendInfo{
    NSLog(@"printExtendInfo {healthPoint:%d, magicPoint:%ld}", self.healthPoint, self.magicPoint);
}

@end
