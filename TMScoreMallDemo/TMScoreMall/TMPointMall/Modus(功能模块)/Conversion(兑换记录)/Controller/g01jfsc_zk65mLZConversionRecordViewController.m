//
//  g01jfsc_zk65mLZConversionRecordViewController.m
//  TMPointMall
//
//  Created by Admin on 2018/10/16.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "g01jfsc_zk65mLZConversionRecordViewController.h"
#import "g01jfsc_zk65mLZConversionRecordCell.h"
#import "g01jfsc_zk65mLZOrderDetailViewController.h"
#import "g01jfsc_zk65mLZConversionOrderModel.h"
#import "g01jfsc_zk65mLZDataTool.h"


static NSString * Kg01jfsc_zk65mLZConversionRecordCell = @"g01jfsc_zk65mLZConversionRecordCell";

@interface g01jfsc_zk65mLZConversionRecordViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSInteger _pageNum;
    NSInteger _pageSize;
}

@property (nonatomic, strong) UITableView * myTableView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation g01jfsc_zk65mLZConversionRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self changeNavBackIem];
    
    self.title = @"兑换记录";
    self.view.backgroundColor = LZ_ColorHex(EEEEEE);
    self.webView.hidden = YES;
    
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
    [g01jfsc_zk65mLZRequestTool getExchangeOrderListWithMemberCode:[g01jfsc_zk65mLZDataTool getUMemberCode] pageNum:_pageNum page_size:_pageSize success:^(id responseObject) {
        NSArray * data = responseObject[@"list"];
        if (_pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        for (NSDictionary * dict in data) {
            g01jfsc_zk65mLZConversionOrderModel * model = [g01jfsc_zk65mLZConversionOrderModel mj_objectWithKeyValues:dict];
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
    return 105;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
    return self.dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    g01jfsc_zk65mLZConversionRecordCell * cell = (g01jfsc_zk65mLZConversionRecordCell *)[tableView dequeueReusableCellWithIdentifier:Kg01jfsc_zk65mLZConversionRecordCell];
    g01jfsc_zk65mLZConversionOrderModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    
    if (indexPath.row == self.dataArray.count - 1) {
        cell.bottomLineView.hidden = YES;
    } else {
        cell.bottomLineView.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    g01jfsc_zk65mLZConversionOrderModel * model = self.dataArray[indexPath.row];
    
    g01jfsc_zk65mLZOrderDetailViewController * vc = [[g01jfsc_zk65mLZOrderDetailViewController alloc] init];
    vc.exchange_order_id = model.exchange_order_id;
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
        [_myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([g01jfsc_zk65mLZConversionRecordCell class]) bundle:MyFramworkXib_Bundle] forCellReuseIdentifier:Kg01jfsc_zk65mLZConversionRecordCell];

    }
    return _myTableView;
}


@end
