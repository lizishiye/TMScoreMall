//
//  g01jfsc_zk65mLZAllDivisionViewControllerm
//  TMPointMall
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZAllDivisionViewController.h"
#import "g01jfsc_zk65mLZDivisionListCell.h"
#import "g01jfsc_zk65mLZDivisionProductViewController.h"

#define CELLHEIGHT ((ScreenWidth-30)*(LZImageName(@"lz_hotImage").size.height / LZImageName(@"lz_hotImage").size.width)-12)

static NSString * Kg01jfsc_zk65mLZDivisionListCell = @"g01jfsc_zk65mLZDivisionListCell";

@interface g01jfsc_zk65mLZAllDivisionViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSInteger _pageNum;
    NSInteger _pageSize;
}

@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation g01jfsc_zk65mLZAllDivisionViewController

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
    [g01jfsc_zk65mLZRequestTool getAreaListWithPageNum:_pageNum page_size:_pageSize success:^(id responseObject) {
        NSArray * data = responseObject[@"list"];
        if (_pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary * dict in data) {
            g01jfsc_zk65mLZDivisionModel * model = [g01jfsc_zk65mLZDivisionModel mj_objectWithKeyValues:dict];
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
    g01jfsc_zk65mLZDivisionListCell * cell = (g01jfsc_zk65mLZDivisionListCell *)[tableView dequeueReusableCellWithIdentifier:Kg01jfsc_zk65mLZDivisionListCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.section];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    g01jfsc_zk65mLZDivisionModel * model = self.dataArray[indexPath.section];
    
    g01jfsc_zk65mLZDivisionProductViewController * vc = [[g01jfsc_zk65mLZDivisionProductViewController alloc] init];
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
        [_myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([g01jfsc_zk65mLZDivisionListCell class]) bundle:MyFramworkXib_Bundle] forCellReuseIdentifier:Kg01jfsc_zk65mLZDivisionListCell];
        
    }
    return _myTableView;
}



@end
