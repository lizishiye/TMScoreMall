//
//  LZSubHomeViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZSubHomeViewController.h"
#import "LZHomeCollectionViewCell.h"
#import "LZGoodsDetailViewController.h"
#import "LZProductModel.h"

#define ItemCount               2.0
#define InteritemSpacing        2.0
#define LineSpacing             2.0
#define ItemWidth               (ScreenWidth - LineSpacing*(ItemCount-1) - 10) / ItemCount

static NSString *KLZHomeCollectionViewCell = @"LZHomeCollectionViewCell";

@interface LZSubHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSInteger _pageNum;
    NSInteger _pageSize;
}

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation LZSubHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView.hidden = YES;
    self.view.backgroundColor = ColorClear;
    
    _pageNum = 1;
    _pageSize = 20;
    [self addRefreshHeaderAndFooter];
    
    LZShowProgress
    [self loadData];
}

- (void) lz_setUpSubViews {
    [self.view addSubview:self.myCollectionView];
    
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 10, 0, 0));
    }];
}

- (void) addRefreshHeaderAndFooter {
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.myCollectionView.mj_footer = footer;
}

- (void) loadData {
    [LZRequestTool getProductListWithProductCategoryId:self.categoryID index:_pageNum page_size:_pageSize success:^(id responseObject) {
        LZHideProgress
        NSDictionary * jsonDic = (NSDictionary *)responseObject;
        NSString * jsonStr = jsonDic.mj_JSONString;
        MyLog(@"%@", jsonStr);
        if (_pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        NSArray * listArr = responseObject[@"list"];
        for (NSDictionary * dict in listArr) {
            LZProductModel * model = [LZProductModel mj_objectWithKeyValues:dict];
            [self.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionView.mj_footer endRefreshing];
            [self.myCollectionView reloadData];
            _pageNum++;
        });
    } failure:^(NSError *error) {
        LZHideProgress
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionView.mj_footer endRefreshing];
        });
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LZHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLZHomeCollectionViewCell forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LZProductModel * model = self.dataArray[indexPath.row];
    
    LZGoodsDetailViewController * vc = [[LZGoodsDetailViewController alloc] init];
    vc.productID = model.product_id;

    [self.rootVC.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat y = scrollView.contentOffset.y;
    
    NSDictionary * dict = @{@"offset" : @(y),
                            @"KScrollView" : scrollView
                            };
    NSString * notifiKey = [NSString stringWithFormat:@"KBusinessListScrollViewDidScroll"];
    [LZNotificationCenter postNotificationName:notifiKey object:dict];
    
}

#pragma mark - 懒加载
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(ItemWidth, 177);
        flowLayout.minimumLineSpacing = LineSpacing;
        flowLayout.minimumInteritemSpacing = InteritemSpacing;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _myCollectionView.backgroundColor = [UIColor clearColor];
        _myCollectionView.pagingEnabled = NO;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        _myCollectionView.showsVerticalScrollIndicator = NO;
        _myCollectionView.alwaysBounceHorizontal = NO;
        _myCollectionView.alwaysBounceVertical = YES;
        _myCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
        [_myCollectionView registerNib:[UINib nibWithNibName:@"LZHomeCollectionViewCell" bundle:MyFramworkXib_Bundle] forCellWithReuseIdentifier:KLZHomeCollectionViewCell];
    }
    return _myCollectionView;
}
@end
