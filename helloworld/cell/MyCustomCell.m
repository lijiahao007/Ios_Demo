//
// Created by VINSON on 2023/3/21.
//

#import "MyCustomCell.h"

@interface MyCustomCell()
@property (weak, nonatomic) IBOutlet UILabel *lablebview1;
@property (weak, nonatomic) IBOutlet UILabel *labelView2;

@end
@implementation MyCustomCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 注册
    MyCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCustomCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EmptyCell" owner:self options:nil] firstObject];
    }

    return cell;
}

- (void)setLabel1:(NSString *)label1 {
    _label1 = label1;
    _lablebview1.text = label1;
}

- (void)setLabel2:(NSString *)label2 {
    _label2 = label2;
    _labelView2.text = label2;
}


@end
