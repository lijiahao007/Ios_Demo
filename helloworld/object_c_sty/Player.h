//
//  helloworld.h
//  helloworld
//
//  Created by VINSON on 2023/3/14.
//

#import <Foundation/Foundation.h>
#import "SpeakMethod.h"

NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject <SpeakMethod>

@property (nonatomic, assign) int healthPoint;
@property (nonatomic, assign) long magicPoint;
@property (nonatomic, copy) NSString* (^myPrint)(int type);

+(Player *)player;
-(void) normalAttack;
-(void) magicAttack;
-(NSString *) repeatSay: (int) count
           repeatValue: (NSString*) str;
-(NSString* (^)(void)) getPrintWay:(int) way;

@end

NS_ASSUME_NONNULL_END
