//
//  MyNibView.m
//  helloworld
//
//  Created by VINSON on 2023/3/21.
//

#import "MyNibView.h"

@interface MyNibView()
@property (weak, nonatomic) IBOutlet UILabel *labelView1;
@end

@implementation MyNibView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(MyNibView*) initFromNib {
    MyNibView* myNibView = [[[NSBundle mainBundle] loadNibNamed:@"EmptyView" owner:self options:nil] firstObject];
    return myNibView;
}

-(instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    NSLog(@"initWithCoder");
    return self;
}

- (void)awakeFromNib {
    NSLog(@"awakeFromNib");
    [super awakeFromNib];
    _labelView1.text = @"init From awake";
}


@end
