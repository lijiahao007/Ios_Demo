//
//  CustomUIView.m
//  helloworld
//
//  Created by VINSON on 2023/3/17.
//

#import "CustomUIView.h"

@implementation CustomUIView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype) initWithFrame:(CGRect)frame {
    NSLog(@"CustomUIView initWithFrame %@", frame);
    self = [super initWithFrame:frame];
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)coder {
    NSLog(@"CustomUIView initWithCoder %@", coder);
    self = [super initWithCoder:coder];
    return self;
}



-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog([NSString stringWithFormat:@"touchesBegin"]);
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog([NSString stringWithFormat:@"touchesMoved"]);
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog([NSString stringWithFormat:@"touchesEnded"]);
}

-(void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog([NSString stringWithFormat:@"touchesCancelled"]);
}

@end
