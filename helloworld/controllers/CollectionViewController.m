//
// Created by VINSON on 2023/3/21.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()
@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 1. 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    // 2. 注册header
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    // 3. 注册footer
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

    [self.view addSubview:self.collectionView];
}

// 每个Section中行数 （必须实现）
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

// 每个cell的内容 （必须实现）
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 因为上面注册过了，所以可以直接获取cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor blueColor];
    } else if (indexPath.section == 1) {
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor orangeColor];
    }

    UIView *selectedView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedView.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = selectedView;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

// 设置header 和 footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"viewForSupplementaryElementOfKind kind=%@", kind);
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor redColor];
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor greenColor];
        return footer;
    }

    return nil;
}


// 懒加载
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 30; // item 之间的最小间距
        flowLayout.minimumLineSpacing = 20; // 行之间的最小间距
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10); // 上左下右内间距
        flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100); // 预留header的大小
        flowLayout.footerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100); // 预留footer的大小

        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}



- (NSMutableArray *)data {
    if (_data == nil) {
        _data = [[NSMutableArray alloc] initWithArray:@[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z"]];
    }
    return _data;
}

// UICollectionView 选中与取消选中相关方法
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"shouldSelectItemAtIndexPath %lu", indexPath.row);
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"shouldDeselectItemAtIndexPath %lu", indexPath.row);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath %lu", indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didDeselectItemAtIndexPath %lu", indexPath.row);

}


// highLight相关
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"shouldHighlightItemAtIndexPath %lu", indexPath.row);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didHighlightItemAtIndexPath %lu", indexPath.row);
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didUnhighlightItemAtIndexPath %lu", indexPath.row);
}


// ======= UICollectionViewDelegateFlowLayout =======
// 设置每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    arc4random_stir();
    int randomWidth = arc4random_uniform(50);
    int randomHeight = arc4random_uniform(50);
    return CGSizeMake(100 + randomWidth, 100 + randomHeight);
}

// cell 相较于屏幕两侧以及header、footer的距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 50, 50, 50);
}


@end