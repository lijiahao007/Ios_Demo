//
//  CustomCircleProgress.m
//  helloworld
//
//  Created by VINSON on 2023/3/17.
//

#import "CustomCircleProgress.h"

@interface CustomCircleProgress ()
// 私有变量
@property (nonatomic, weak) UILabel *cLabel;
@end

@implementation CustomCircleProgress

// 1. 在initWithFrame中进行绘制属性的初始化操作，并创建需要显示的View，
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        //默认颜色
        self.progerssBackgroundColor=[UIColor lightGrayColor];
        self.progerssColor=[UIColor blueColor];
        self.percentFontColor=[UIColor blueColor];
        //默认进度条宽度
        self.progerWidth=15;
        //默认百分比字体大小
        self.percentageFontSize=22;
        
        //百分比标签
        UILabel *cLabel = [[UILabel alloc] initWithFrame:self.bounds];
        cLabel.font = [UIFont boldSystemFontOfSize:self.percentageFontSize];
        cLabel.textColor = self.percentFontColor;
        cLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:cLabel];
        self.cLabel = cLabel;
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _cLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];
    
    // 异步重绘UIView， 类似于postInvalidate
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
    //路径
    UIBezierPath *backgroundPath = [[UIBezierPath alloc] init];
    //线宽
    backgroundPath.lineWidth = self.progerWidth;
    //颜色
    [self.progerssBackgroundColor set];
    //拐角
    backgroundPath.lineCapStyle = kCGLineCapRound;
    backgroundPath.lineJoinStyle = kCGLineJoinRound;
    //半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - self.progerWidth) * 0.5;
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [backgroundPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2  clockwise:YES];
    //连线
    [backgroundPath stroke];
    
    
    //路径
    UIBezierPath *progressPath = [[UIBezierPath alloc] init];
    //线宽
    progressPath.lineWidth = self.progerWidth;
    //颜色
    [self.progerssColor set];
    //拐角
    progressPath.lineCapStyle = kCGLineCapRound;
    progressPath.lineJoinStyle = kCGLineJoinRound;
    
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [progressPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2 * _progress clockwise:YES];
    //连线
    [progressPath stroke];
}


@end
