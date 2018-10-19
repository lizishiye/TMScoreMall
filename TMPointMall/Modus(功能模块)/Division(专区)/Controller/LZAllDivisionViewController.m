//
//  LZAllDivisionViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "LZAllDivisionViewController.h"
#import "LZDivisionListCell.h"
#import "LZDivisionProductViewController.h"

#define CELLHEIGHT ((ScreenWidth-30)*(LZImageName(@"lz_hotImage").size.height / LZImageName(@"lz_hotImage").size.width)-12)

static NSString * KLZDivisionListCell = @"LZDivisionListCell";

@interface LZAllDivisionViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSInteger _pageNum;
    NSInteger _pageSize;
}

@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation LZAllDivisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self changeNavBackIem];
    
    self.title = @"全部专区";
    
    _pageNum = 1;
    _pageSize = 20;
    [self addRefreshHeaderAndFooter];
    
    [self.myTableView.mj_header beginRefreshing];
}

-(void)lz_setUpSubViews {
    [self.view addSubview:self.myTableView];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void) addRefreshHeaderAndFooter {
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNum = 1;
        [self loadData];
    }];
    self.myTableView.mj_header = header;
    
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.myTableView.mj_footer = footer;
}

#pragma mark - 加载数据
- (void) loadData {
    [LZRequestTool getAreaListWithPageNum:_pageNum page_size:_pageSize success:^(id responseObject) {
        NSArray * data = responseObject[@"list"];
        if (_pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary * dict in data) {
            LZDivisionModel * model = [LZDivisionModel mj_objectWithKeyValues:dict];
            [self.dataArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
            [self.myTableView reloadData];
            _pageNum++;
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView.mj_footer endRefreshing];
            [self.myTableView reloadData];
        });
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELLHEIGHT;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZDivisionListCell * cell = (LZDivisionListCell *)[tableView dequeueReusableCellWithIdentifier:KLZDivisionListCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LZDivisionModel * model = self.dataArray[indexPath.section];
    
    LZDivisionProductViewController * vc = [[LZDivisionProductViewController alloc] init];
    vc.divisionModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-KNavi_Height) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _myTableView.backgroundColor = ColorClear;
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerNib:[UINib nibWithNibName:@"LZDivisionListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:KLZDivisionListCell];
        
    }
    return _myTableView;
}



@end
