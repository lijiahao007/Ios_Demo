//
//  Player+PlayerExtension.h
//  helloworld
//
//  Created by VINSON on 2023/3/16.
//

#import "Player.h"

NS_ASSUME_NONNULL_BEGIN

@interface Player (PlayerExtension)

+(Player*) player:(int) healthPoint
       magicPoint:(long)magicPoint;

-(void) printExtendInfo;
@end

NS_ASSUME_NONNULL_END
