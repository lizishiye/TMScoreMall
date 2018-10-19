//
//  LZDivisionProductViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZDivisionProductViewController.h"
#import "LZHomeCollectionViewCell.h"
#import "LZGoodsDetailViewController.h"
#import "LZProductModel.h"
#import "LZDivisionModel.h"

#define ItemCount               2.0
#define InteritemSpacing        2.0
#define LineSpacing             2.0
#define ItemWidth               (ScreenWidth - LineSpacing*(ItemCount-1)-10) / ItemCount

static NSString *KLZHomeCollectionViewCell = @"LZHomeCollectionViewCell";

@interface LZDivisionProductViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSInteger _pageNum;
    NSInteger _pageSize;
}

@property (nonatomic, strong) UICollectionView * myCollectionView;

@property (nonatomic, strong) NSMutableArray * dataArray;


@end

@implementation LZDivisionProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self changeNavBackIem];
    
    self.title = self.divisionModel.name;
    self.webView.hidden = YES;
    self.view.backgroundColor = LZ_ColorHex(EEEEEE);
    
    _pageNum = 1;
    _pageSize = 20;
    [self addRefreshHeaderAndFooter];
    
    [self.myCollectionView.mj_header beginRefreshing];
}

- (void) lz_setUpSubViews {
    [self.view addSubview:self.myCollectionView];
    
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 10, 0, 0));
    }];
}

- (void) addRefreshHeaderAndFooter {
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNum = 1;
        [self loadData];
    }];
    self.myCollectionView.mj_header = header;
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.myCollectionView.mj_footer = footer;
}

#pragma mark - 加载数据
- (void) loadData {
    [LZRequestTool getAreaProductListWithAreaId:self.divisionModel.area_id index:_pageNum page_size:_pageSize success:^(id responseObject) {
        NSArray * data = responseObject[@"list"];
        if (_pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary * dict in data) {
            LZProductModel * model = [LZProductModel mj_objectWithKeyValues:dict];
            [self.dataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionView.mj_header endRefreshing];
            [self.myCollectionView.mj_footer endRefreshing];
            [self.myCollectionView reloadData];
            _pageNum++;
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionView.mj_header endRefreshing];
            [self.myCollectionView.mj_footer endRefreshing];
            [self.myCollectionView reloadData];
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
    
    [self.navigationController pushViewController:vc animated:YES];
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
