//
// Created by VINSON on 2023/3/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MyCustomCell : UITableViewCell

@property (nonatomic) NSString* label1;
@property (nonatomic) NSString* label2;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end