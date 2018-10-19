//
//  LZHomeViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/12.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZHomeViewController.h"
#import <SGPagingView/SGPagingView.h>
#import "LZTableView.h"
#import "LZHomeHeaderView.h"
#import "LZSubHomeViewController.h"
#import "LZConversionRecordViewController.h"
#import "LZProductCategoryModel.h"
#import "LZDivisionModel.h"
#import "LZSliderModel.h"

#define HeaderView_H (330+(ScreenWidth-12*2)*(371.0/702.0))

#define ListScrollView_H (ScreenHeight-KNavi_Height-PageTitleView_H)

@interface LZHomeViewController () <SGPageContentScrollViewDelegate, SGPageTitleViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSInteger _currentSelectedIndex;
}

@property (strong,nonatomic) LZTableView *myTableView;

@property (strong,nonatomic) SGPageContentScrollView * pageContentView;

@property (strong, nonatomic) LZHomeHeaderView * headerView;


@property (strong,nonatomic) NSMutableArray *listVCArray;
//标题分类
@property (nonatomic, strong) NSMutableArray * titleArray;
//热门专区
@property (nonatomic, strong) NSMutableArray * hotArray;
//轮播广告
@property (nonatomic, strong) NSMutableArray * sliderArray;


@end

@implementation LZHomeViewController
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
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : LZ_ColorHex(333333), NSFontAttributeName: Font(19)};
    [self.navigationController.navigationBar setTintColor:ColorClear];

    NSString * notifiKey = [NSString stringWithFormat:@"KBusinessListScrollViewDidScroll"];
    [LZNotificationCenter addObserver:self selector:@selector(listScrollViewDidScroll:) name:notifiKey object:nil];
    
    LZShowProgress
    [self loadData];
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
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    [rightBtn setTitle:@"兑换记录" forState:UIControlStateNormal];
    [rightBtn setTitleColor:LZ_ColorHex(333333) forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.myTableView];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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
    [LZRequestTool getPointWithToken:[DataTool getUToken] Success:^(id responseObject) {
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
    [LZRequestTool getAreaListWithPageNum:1 page_size:10 success:^(id responseObject) {

        NSArray * data = responseObject[@"list"];
        [self.hotArray removeAllObjects];
        for (NSDictionary * dict in data) {
            LZDivisionModel * model = [LZDivisionModel mj_objectWithKeyValues:dict];
            [self.hotArray addObject:model];
        }
        dispatch_group_leave(group);
        
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
}

- (void) loadSliderData:(dispatch_group_t) group {
    
    dispatch_group_enter(group);
    [LZRequestTool getSliderListSuccess:^(id responseObject) {

        NSArray * data = (NSArray *)responseObject;
        [self.sliderArray removeAllObjects];
        for (NSDictionary * dict in data) {
            LZSliderModel * model = [LZSliderModel mj_objectWithKeyValues:dict];
            [self.sliderArray addObject:model];
        }
        dispatch_group_leave(group);
        
    } failure:^(NSError *error) {
        dispatch_group_leave(group);
    }];
}

- (void) loadCategoryData:(dispatch_group_t) group {
    dispatch_group_enter(group);
    [LZRequestTool getProductCategoryListSuccess:^(id responseObject) {
        
        NSArray * data = (NSArray *)responseObject;
        [self.titleArray removeAllObjects];
        for (NSDictionary * dict in data) {
            LZProductCategoryModel * model = [LZProductCategoryModel mj_objectWithKeyValues:dict];
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
        [self refreshUI];
    });
}

#pragma mark - 事件
- (void) rightBtnClicked {
    LZConversionRecordViewController * vc = [[LZConversionRecordViewController alloc] init];
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
    
    LZSubHomeViewController * currentSelectedVC = self.listVCArray[_currentSelectedIndex];
    
    
    UICollectionView * contentTableView = currentSelectedVC.myCollectionView;
    CGFloat y = scrollView.contentOffset.y;

    if (contentTableView.contentOffset.y > 0 || y > HeaderView_H-PageTitleView_H) {
        scrollView.contentOffset = CGPointMake(0, HeaderView_H-PageTitleView_H);
    }

    if (scrollView.contentOffset.y < HeaderView_H-PageTitleView_H) {
        for (LZSubHomeViewController * vc in self.listVCArray) {
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

- (LZTableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[LZTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-KNavi_Height) style:UITableViewStylePlain];
        _myTableView.backgroundColor = LZ_RGB(238, 238, 238);
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.tableHeaderView = self.headerView;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}

- (LZHomeHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LZHomeHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeaderView_H)];
        _headerView.rootVC = self;
    }
    return _headerView;
}

- (SGPageContentScrollView *)pageContentView {
    if (!_pageContentView) {
        [self.listVCArray removeAllObjects];
        for (int i = 0; i < self.titleArray.count; i++) {
            LZProductCategoryModel * model = self.titleArray[i];
            
            LZSubHomeViewController * vc = [[LZSubHomeViewController alloc] init];
            vc.rootVC = self;
            vc.categoryID = model.product_category_id;
            [self.listVCArray addObject:vc];
        }
        _pageContentView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ListScrollView_H) parentVC:self childVCs:self.listVCArray];
        _pageContentView.delegatePageContentScrollView = self;
        _pageContentView.isScrollEnabled = NO;
    }
    return _pageContentView;
}

@end
