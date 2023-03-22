//
// Created by VINSON on 2023/3/21.
//

#import "TableDemoController.h"
#import "MyCustomCell.h"


@implementation TableDemoController {
    NSMutableArray *_cellContent;
    UITableView *_tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    _cellContent = [[NSMutableArray alloc] initWithArray:@[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"]];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self; // 设置列表操作代理
    _tableView.dataSource = self; // 设置列表数据源代理

    _tableView.sectionFooterHeight = 100;
    _tableView.sectionHeaderHeight = 100;

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 100)];
    header.backgroundColor = [UIColor redColor];
    _tableView.tableHeaderView = header;

    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 100)];
    footer.backgroundColor = [UIColor greenColor];
    _tableView.tableFooterView = footer;

    _tableView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:_tableView];


    // 自适应行高
    _tableView.estimatedRowHeight = 127;
    _tableView.rowHeight = UITableViewAutomaticDimension;

    // 分割线样式
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor systemPinkColor];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 17, 0, 17);

}

// 返回每个Section的行数 (必需实现)
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"section: %ld   count=%lu", section, _cellContent.count);
    return _cellContent.count;
}


// 返回每个Cell的样式与内容（必须实现）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reUseIdentifier = @"cell";
    // 从缓存池中取出cell
    NSString *data = _cellContent[(NSUInteger) indexPath.row];
    if (indexPath.row % 3 == 0) {
        MyCustomCell *cell = [MyCustomCell cellWithTableView:tableView];
        cell.label1 = data;
        cell.label2 = [NSString stringWithFormat:@"label2: %@", data];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUseIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseIdentifier];
        }
        cell.textLabel.text = data;
        return cell;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row % 3 == 0) {
//        MyCustomCell *cell = [MyCustomCell cellWithTableView:tableView];
//        return cell.bounds.size.height ;
//    } else {
//        NSString *reUseIdentifier = @"cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUseIdentifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseIdentifier];
//        }
//        return cell.bounds.size.height;
//    }
//}


// 返回TableView的Section数 (可选实现，若未实现，则默认返回1)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

// 只有在点击，然后放手后才会开始回调
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"willSelectRowAtIndexPath: %ld, %ld", indexPath.section, indexPath.row);
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath: %ld, %ld", indexPath.section, indexPath.row);
    [_cellContent removeObjectAtIndex:(NSUInteger) indexPath.row];
    [_tableView reloadData];
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"willDeselectRowAtIndexPath: %ld, %ld", indexPath.section, indexPath.row);
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didDeselectRowAtIndexPath: %ld, %ld", indexPath.section, indexPath.row);
}


// 选中的项是否需要 highlight
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"shouldHighlightRowAtIndexPath: %ld, %ld", indexPath.section, indexPath.row);
    return YES;
}

// 当选中项高亮时回调
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didHighlightRowAtIndexPath: %ld, %ld", indexPath.section, indexPath.row);
}

// 其他项目取消高亮时回调。
// 例如：当前选中B，然后按住A不放。这时会回调didHighlightRowAtIndexPath:didHighlightRowAtIndexPath。
//      一旦放手，B会取消高亮，这是会回调didUnhighlightRowAtIndexPath:didUnhighlightRowAtIndexPath。
//      需要注意的是上面两个的回调中，indexPath都是新选中新高亮的那个cell的位置。
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didUnhighlightRowAtIndexPath: %ld, %ld", indexPath.section, indexPath.row);
}


// ======== 编辑 ==========
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction *_Nonnull action, __kindof UIView *_Nonnull sourceView, void (^_Nonnull completionHandler)(BOOL)) {
        NSLog(@"删除");
        completionHandler(YES);
    }];

    UIContextualAction *action1 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"置顶" handler:^(UIContextualAction *_Nonnull action, __kindof UIView *_Nonnull sourceView, void (^_Nonnull completionHandler)(BOOL)) {
        NSLog(@"置顶");
        completionHandler(YES);
    }];

    UIContextualAction *action2 = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"置底" handler:^(UIContextualAction *_Nonnull action, __kindof UIView *_Nonnull sourceView, void (^_Nonnull completionHandler)(BOOL)) {
        NSLog(@"置底");
        completionHandler(YES);
    }];
    return [UISwipeActionsConfiguration configurationWithActions:@[action, action1, action2]];
}


// ======= Section Header Footer =====

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %ld header", section];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %ld footer", section];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"startPage"]];
}


@end
