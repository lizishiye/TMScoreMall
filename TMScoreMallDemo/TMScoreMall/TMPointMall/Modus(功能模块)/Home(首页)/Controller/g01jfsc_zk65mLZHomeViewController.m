//
//  g01jfsc_zk65mLZHomeViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/12.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZHomeViewController.h"
#import <SGPagingView/SGPagingView.h>
#import "g01jfsc_zk65mLZTableView.h"
#import "g01jfsc_zk65mLZHomeHeaderView.h"
#import "g01jfsc_zk65mLZSubHomeViewController.h"
#import "g01jfsc_zk65mLZConversionRecordViewController.h"
#import "g01jfsc_zk65mLZProductCategoryModel.h"
#import "g01jfsc_zk65mLZDivisionModel.h"
#import "g01jfsc_zk65mLZSliderModel.h"
#import "g01jfsc_zk65mLZAlertView.h"
#import <SetI001/SetI001.h>

#define HeaderView_H (NSInteger)(330+(ScreenWidth-12*2)*(371.0/702.0))

#define ListScrollView_H (ScreenHeight-KNavi_Height-(self.tabBarController.tabBar ? self.tabBarController.tabBar.frame.size.height : 0)-PageTitleView_H)

@interface g01jfsc_zk65mLZHomeViewController () <SGPageContentScrollViewDelegate, SGPageTitleViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSInteger _currentSelectedIndex;
}

@property (strong,nonatomic) g01jfsc_zk65mLZTableView *myTableView;

@property (strong,nonatomic) SGPageContentScrollView * pageContentView;

@property (strong, nonatomic) g01jfsc_zk65mLZHomeHeaderView * headerView;


@property (strong,nonatomic) NSMutableArray *listVCArray;
//标题分类
@property (nonatomic, strong) NSMutableArray * titleArray;
//热门专区
@property (nonatomic, strong) NSMutableArray * hotArray;
//轮播广告
@property (nonatomic, strong) NSMutableArray * sliderArray;


@end

@implementation g01jfsc_zk65mLZHomeViewController
-(void)dealloc {
    
    [LZNotificationCenter removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadUserPoint];
    
    [self.headerView refreshUserInfo];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"积分商城";
    
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : LZ_ColorHex(333333), NSFontAttributeName: Font(19)};
//    [self.navigationController.navigationBar setTintColor:ColorClear];

    NSString * notifiKey = [NSString stringWithFormat:@"KBusinessListScrollViewDidScroll"];
    [LZNotificationCenter addObserver:self selector:@selector(listScrollViewDidScroll:) name:notifiKey object:nil];
    
    
    
    [self addRefreshHeaderAndFooter];
    
    LZShowProgress
    [self loadData];
    
    
//    //修改积分
//    [g01jfsc_zk65mLZRequestTool editePointWithPoint:1000 Success:^(id responseObject) {
//
//    } failure:^(NSError *error) {
//
//    }];
    
}

- (void) addRefreshHeaderAndFooter {
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.myTableView.mj_header = header;
}

#pragma mark - notifi
- (void) listScrollViewDidScroll:(NSNotification *) notifacation {
    
    NSDictionary * dict = notifacation.object;
    CGFloat listOffsetY = [dict[@"offset"] floatValue];
    UIScrollView * scrollView = dict[@"KScrollView"];
    
    CGFloat myY = self.myTableView.contentOffset.y;
    MyLog(@"myY = %lf   listOffsetY = %lf", myY, listOffsetY);
    
    if (myY < HeaderView_H-PageTitleView_H) {
        scrollView.contentOffset = CGPointZero;
    }
}

- (void) lz_setUpSubViews {

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"兑换记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.myTableView];
    
//    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, (self.tabBarController.tabBar ? self.tabBarController.tabBar.frame.size.height : 0), 0));
////        make.edges.equalTo(self.view);
//    }];
}

- (void) refreshUI {
    [self.headerView refreshUIWithHotArray:self.hotArray titleArray:self.titleArray sliderArray:self.sliderArray];
    if (_pageContentView && _pageContentView.superview) {
        [_pageContentView removeFromSuperview];
        _pageContentView = nil;
    }
    [self.myTableView reloadData];
}

#pragma mark - 加载数据
- (void) loadUserPoint {
    if (![g01jfsc_zk65mLZDataTool getIsLogin]) {
        return;
    }
    [g01jfsc_zk65mLZRequestTool getPointSuccess:^(id responseObject) {
        NSString * point = [NSString stringWithFormat:@"%@", responseObject[@"point"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headerView.pointLB.text = point;
        });
    } failure:^(NSError *error) {
        
    }];
}

- (void) loadData {
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [self loadHotAreaData:group];
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [self loadSliderData:group];
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [self loadCategoryData:group];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 处理上面加载的所有首页数据
        [self dealAllData];
    });
}

- (void) loadHotAreaData:(dispatch_group_t) group {
    dispatch_group_enter(group);
    [g01jfsc_zk65mLZRequestTool getAreaListWithPageNum:1 page_size:10 success:^(id responseObject) {

        NSArray * data = responseObject[@"list"];
        [self.hotArray removeAllObjects];
        for (NSDictionary * dict in data) {
            g01jfsc_zk65mLZDivisionModel * model = [g01jfsc_zk65mLZDivisionModel mj_objectWithKeyValues:dict];
            [self.hotArray addObject:model];
        }
        dispatch_group_leave(group);
        
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
}

- (void) loadSliderData:(dispatch_group_t) group {
    
    dispatch_group_enter(group);
    [g01jfsc_zk65mLZRequestTool getSliderListSuccess:^(id responseObject) {

        NSArray * data = (NSArray *)responseObject;
        [self.sliderArray removeAllObjects];
        for (NSDictionary * dict in data) {
            g01jfsc_zk65mLZSliderModel * model = [g01jfsc_zk65mLZSliderModel mj_objectWithKeyValues:dict];
            [self.sliderArray addObject:model];
        }
        dispatch_group_leave(group);
        
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
}

- (void) loadCategoryData:(dispatch_group_t) group {
    dispatch_group_enter(group);
    [g01jfsc_zk65mLZRequestTool getProductCategoryListSuccess:^(id responseObject) {
        
        NSArray * data = (NSArray *)responseObject;
        [self.titleArray removeAllObjects];
        for (NSDictionary * dict in data) {
            g01jfsc_zk65mLZProductCategoryModel * model = [g01jfsc_zk65mLZProductCategoryModel mj_objectWithKeyValues:dict];
            [self.titleArray addObject:model];
        }
        dispatch_group_leave(group);

    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
}

- (void) dealAllData {
    LZHideProgress
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myTableView.mj_header endRefreshing];
        [self refreshUI];
    });
}

#pragma mark - 事件
- (void) rightBtnClicked {
    if (![g01jfsc_zk65mLZDataTool getIsLogin]) {
        
        g01jfsc_zk65mLZAlertView * alertView = [g01jfsc_zk65mLZAlertView showWithTitle:@"您还未登录" content:@"" cancelTitle:@"再逛逛" sureTitle:@"去登录" okBlock:^{
            SetI001LoginViewController * vc = [[SetI001LoginViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } cancelBlock:^{
            
        }];
        alertView.contentBgViewH.constant = 120;
        alertView.titleTopDistance.constant = 25;

        return;
    }
    
    g01jfsc_zk65mLZConversionRecordViewController * vc = [[g01jfsc_zk65mLZConversionRecordViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ListScrollView_H;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.backgroundColor = ColorClear;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView * view in cell.contentView.subviews) {
        if ([view isKindOfClass:[SGPageContentScrollView class]]) {
            [view removeFromSuperview];
        }
    }
    [cell.contentView addSubview:self.pageContentView];
    
    return cell;
}

#pragma mark - SGPageContentScrollViewDelegate, SGPageTitleViewDelegate
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    
    _currentSelectedIndex = selectedIndex;
    [self.pageContentView setPageContentScrollViewCurrentIndex:selectedIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.listVCArray.count <= 0) {
        return;
    }
    
    g01jfsc_zk65mLZSubHomeViewController * currentSelectedVC = self.listVCArray[_currentSelectedIndex];
    
    
    UICollectionView * contentTableView = currentSelectedVC.myCollectionView;
    CGFloat y = scrollView.contentOffset.y;
    
    CGFloat hh = HeaderView_H-PageTitleView_H;

    if (contentTableView.contentOffset.y > 0 || y > HeaderView_H-PageTitleView_H) {
        scrollView.contentOffset = CGPointMake(0, HeaderView_H-PageTitleView_H);
    }

    if (scrollView.contentOffset.y < HeaderView_H-PageTitleView_H) {
        for (g01jfsc_zk65mLZSubHomeViewController * vc in self.listVCArray) {
            vc.myCollectionView.contentOffset = CGPointZero;
        }
    }
}

#pragma mark - 懒加载

- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)listVCArray {
    if (!_listVCArray) {
        _listVCArray = [NSMutableArray array];
    }
    return _listVCArray;
}
- (NSMutableArray *)sliderArray {
    if (!_sliderArray) {
        _sliderArray = [NSMutableArray array];
    }
    return _sliderArray;
}

- (g01jfsc_zk65mLZTableView *)myTableView {
    if (!_myTableView) {
//        _myTableView = [[g01jfsc_zk65mLZTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-KNavi_Height-(self.tabBarController.tabBar ? self.tabBarController.tabBar.frame.size.height : 0)) style:UITableViewStylePlain];
        
        _myTableView = [[g01jfsc_zk65mLZTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-KNavi_Height-(self.tabBarController.tabBar ? self.tabBarController.tabBar.frame.size.height : 0)) style:UITableViewStylePlain];

        _myTableView.backgroundColor = LZ_RGB(238, 238, 238);
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.tableHeaderView = self.headerView;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//#ifdef __IPHONE_11_0
//        if (@available(iOS 11.0, *)) {
//            if ([_myTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
//                _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//            }
//        }
//#endif
    }
    return _myTableView;
}

- (g01jfsc_zk65mLZHomeHeaderView *)headerView {
    if (!_headerView) {
        CGFloat h = HeaderView_H;

        _headerView = [[g01jfsc_zk65mLZHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeaderView_H)];
        _headerView.rootVC = self;
    }
    return _headerView;
}

- (SGPageContentScrollView *)pageContentView {
    if (!_pageContentView) {
        [self.listVCArray removeAllObjects];
        for (int i = 0; i < self.titleArray.count; i++) {
            g01jfsc_zk65mLZProductCategoryModel * model = self.titleArray[i];
            
            g01jfsc_zk65mLZSubHomeViewController * vc = [[g01jfsc_zk65mLZSubHomeViewController alloc] init];
            vc.rootVC = self;
            vc.categoryID = model.product_category_id;
            [self.listVCArray addObject:vc];
        }
//        CGRect rect = self.view.frame;
        _pageContentView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ListScrollView_H) parentVC:self childVCs:self.listVCArray];
        _pageContentView.delegatePageContentScrollView = self;
        _pageContentView.isScrollEnabled = NO;
    }
    return _pageContentView;
}

@end
