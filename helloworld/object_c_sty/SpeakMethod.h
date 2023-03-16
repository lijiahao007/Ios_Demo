//
//  PrintListener.h
//  helloworld
//
//  Created by VINSON on 2023/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SpeakMethod <NSObject>
// 必需实现的方法
-(void) sayMagicPoint;
-(void) sayHealthPoint;

@optional
// 下方是可选实现的方法
-(void) sayMagicPointAndHealthPoint;

@end

NS_ASSUME_NONNULL_END
