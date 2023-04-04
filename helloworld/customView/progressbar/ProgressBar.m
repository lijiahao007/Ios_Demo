//
//  ProgressBar.m
//  helloworld
//
//  Created by VINSON on 2023/4/2.
//

#import "ProgressBar.h"

@implementation ProgressBar {
    BOOL _isBeginDraggingThumb;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _max = 100;
        _progress = 30;
        self.backgroundColor = [UIColor clearColor];
        _isBeginDraggingThumb = NO;
    }
    
    return self;
}

// setNeedDisplay 相当于 invalidate，用于重绘

// 类似于Android自定义View里面的 onDraw回调
- (void)drawRect:(CGRect)rect {
    
    // 1. 第一步通常都是获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2. 绘制自定义图形
    float viewWidth = self.bounds.size.width;
    float viewHeight = self.bounds.size.height;
    
    // 下面用圆角矩形会有错误：如果宽度小于圆角大小的两倍，圆角就会变化。
//    // 2.1 绘制进度条左边
//    float x = (viewWidth - viewHeight) / _max * _progress;
//    NSLog(@"ProgressBar: %f  viewWidth:%f  viewHeight:%f", x, viewWidth, viewHeight);
//    if (_progress != 0) {
//        float leftTrackWidth = x + viewHeight / 2;
//        if (leftTrackWidth < viewHeight) {
//            leftTrackWidth = viewHeight;
//        }
//
//
//        UIBezierPath* completeTrakerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, leftTrackWidth, viewHeight)
//                                                                 byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
//                                                                       cornerRadii:CGSizeMake(viewHeight / 2, viewHeight / 2)];
//        [[UIColor blueColor] setFill];
//        [completeTrakerPath fill];
//    }
//
//
//    // 2.2 绘制tracker右边（灰色）
//    if (_max != _progress) {
//        float rightTrackWidth = viewWidth - x - viewHeight / 2;
//        BOOL isOverSize = NO;
//        if (rightTrackWidth < viewHeight) {
//            isOverSize = YES;
//            rightTrackWidth = viewHeight;
//        }
//
//        float rightTrackStart = x + viewHeight / 2;
//        if (rightTrackStart >= viewWidth - viewHeight) {
//            rightTrackStart = viewWidth - viewHeight;
//        }
//
//        UIBezierPath *trakerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rightTrackStart, 0, rightTrackWidth, viewHeight)
//                                                         byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
//                                                               cornerRadii:CGSizeMake(viewHeight / 2, viewHeight / 2)];
//
//
//        [[UIColor grayColor] setFill];
//        [trakerPath fill];
//    }
//
    
    // 2.1 绘制左边
    float x = (viewWidth - viewHeight) / _max * _progress;
    UIBezierPath* leftPart = [UIBezierPath bezierPathWithArcCenter:CGPointMake(viewHeight / 2, viewHeight / 2)
                                                            radius:viewHeight / 2
                                                        startAngle:-M_PI_2
                                                          endAngle:M_PI_2
                                                         clockwise:NO];
    [leftPart addLineToPoint:CGPointMake(x + viewHeight / 2, viewHeight)];
    [leftPart addLineToPoint:CGPointMake(x + viewHeight / 2, 0)];
    [leftPart closePath];
    [[UIColor blueColor] setFill];
    [leftPart fill];
    
    // 2.2 绘制右边
    UIBezierPath* rightPart = [UIBezierPath bezierPathWithArcCenter:CGPointMake(viewWidth - viewHeight / 2, viewHeight / 2) radius:viewHeight / 2 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    [rightPart addLineToPoint:CGPointMake(x + viewHeight / 2, viewHeight)];
    [rightPart addLineToPoint:CGPointMake(x + viewHeight / 2, 0)];
    [rightPart closePath];
    [[UIColor grayColor] setFill];
    [rightPart fill];
    
    
    // 2.3 绘制thumb
    UIBezierPath* thumbPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x+3, 3, viewHeight-6, viewHeight-6)];
    [[UIColor whiteColor] setFill];
    [thumbPath fill];
    thumbPath.lineWidth = 6;
    [[UIColor blueColor] setStroke];
    [thumbPath stroke];
    
    
    // 最后一步通常都是渲染上下文
    CGContextStrokePath(context);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [self getTouchPointFromTouch:touches];
    if ([self isPointInThumb:touchPoint]) {
        _isBeginDraggingThumb = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_isBeginDraggingThumb) {
        CGPoint touchPoint = [self getTouchPointFromTouch:touches];
        float viewWidth = [self getViewWidth];
        
        _progress =  touchPoint.x / viewWidth * _max;
        
        if (_progress < 0) {
            _progress = 0;
        } else if (_progress > _max) {
            _progress = _max;
        }
        
        NSLog(@"touchesMoved x=%f  getViewWidth=%f  progress=%f", touchPoint.x, viewWidth, _progress);
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _isBeginDraggingThumb = NO;
}



-(CGPoint) getTouchPointFromTouch:(NSSet<UITouch*>*)touches {
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    return touchPoint;
}

-(BOOL) isPointInThumb:(CGPoint) point {
    float viewWidth = self.bounds.size.width;
    float viewHeight = self.bounds.size.height;
    float thumbX = (viewWidth - viewHeight) / _max * _progress;
    NSLog(@"isPointInThumb: point.x:%f  thumbX:%f viewHeight:%f", point.x, thumbX, viewHeight);
    return point.x >= thumbX && point.x <= thumbX + viewHeight;
}

-(float) getViewWidth {
    return self.bounds	.size.width;
}

@end
