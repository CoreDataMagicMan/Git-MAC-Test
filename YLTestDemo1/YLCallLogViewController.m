//
//  YLCallLogViewController.m
//  YLTestDemo1
//
//  Created by linms on 16/9/1.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLCallLogViewController.h"
#import "YLCallRecDataSource.h"
#import "YLCallRecCell.h"
#import "YLCallLogInfoView.h"
#import "YLCallLogInfoElementView.h"
#import "MaskView.h"
#import "YLNewContactInfoView.h"
@interface YLCallLogViewController () <NSTableViewDelegate,NSTableViewDataSource,YLCallRecCellDelegate,YLCallLogInfoViewDelegate>{
    BOOL selectIndexRow;
}
@property (weak) IBOutlet NSTableView *tableList;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) YLCallLogInfoView *logInfoView;
@property (nonatomic, strong) MaskView *maskView;
@property (nonatomic, strong) YLNewContactInfoView *addConView;
@end

@implementation YLCallLogViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    //tableView初始化
    _tableList.delegate = self;
    _tableList.dataSource = self;
    [_tableList setBackgroundColor:[NSColor whiteColor]];
    [_tableList setGridColor:[NSColor clearColor]];
    
    _dataArray = [YLCallRecDataSource searchCallRecLog];
    [_tableList reloadData];
    [self registerNotification];
}
- (void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNeedRefreshData:) name:@"kNeedRefreshData" object:nil];
}
- (void)handleNeedRefreshData:(NSNotification *)note{
    if ([note.name isEqualToString:@"kNeedRefreshData"]) {
        [_addConView removeFromSuperview];
        [_maskView removeFromSuperview];
        _addConView = nil;
        _maskView = nil;
    }
}
#pragma -mark NSTableViewDelegate NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return _dataArray.count;
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSDictionary *dic = _dataArray[row];
    NSString *identifier = [tableColumn identifier];
    YLCallRecCell *callRecCell = [tableView makeViewWithIdentifier:identifier owner:self];
    callRecCell.delegate = self;
    if ([identifier isEqualToString:@"CallLogColumn"]) {
        callRecCell.callLogLabel.stringValue = [dic objectForKey:@"CallLog"];
        callRecCell.dateLabel.stringValue = [dic objectForKey:@"Date"];
    }
    return callRecCell;
}
#pragma -mark cycle
#pragma -mark YLCallRecCellDelegate
- (void)YLCallRecCell:(YLCallRecCell *)cell mouseExitPoint:(NSPoint)point isShowOrHidden:(BOOL)isShow{
    //保存row的index path
    selectIndexRow = [self.tableList rowForView:cell];
    //添加一个详情信息显示视图
    if (isShow) {
        NSRect newContentFrame = [self.view convertRect:self.view.frame toView:self.view.window.contentView];
        CGFloat newContentY = newContentFrame.origin.y;
        NSRect newCellFrame = [cell convertRect:cell.frame toView:self.view.window.contentView];
        CGFloat newCellMaxY = CGRectGetMaxY(newCellFrame);
        CGFloat newCellMinY = CGRectGetMinY(newCellFrame);
        CGFloat detailMinY = newCellMaxY - 156;
        if (!_logInfoView) {
            _logInfoView = [[YLCallLogInfoView alloc] initWithFrame:CGRectZero];
            [self.view.window.contentView addSubview:_logInfoView];
            [_logInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_bottom).offset(-(newCellMaxY - newContentY));
                make.left.equalTo(self.view.mas_right).offset(4);
                make.width.mas_equalTo(260);
                make.height.mas_equalTo(156);
            }];
            
            if (detailMinY < newContentY) {
                if (newCellMinY < newContentY) {
                    [_logInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.view.mas_bottom);
                        make.left.equalTo(self.view.mas_right).offset(4);
                        make.width.mas_equalTo(260);
                        make.height.mas_equalTo(156);
                    }];
                }else{
                    [_logInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.view.mas_bottom).offset(-(newCellMinY - newContentY));
                        make.left.equalTo(self.view.mas_right).offset(4);
                        make.width.mas_equalTo(260);
                        make.height.mas_equalTo(156);
                    }];
                }
            }
            _logInfoView.delegate = self;
            _logInfoView.nameLabel.stringValue = cell.callLogLabel.stringValue;
            NSString *number = @"10.3.17.183";
            NSString *duration = @"00:14:00";
            NSString *time = cell.dateLabel.stringValue;
            NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[number,
                                                                      duration,
                                                                      time]
                                                            forKeys:@[@"Number",
                                                                      @"Duration",
                                                                      @"Time"]];
            [_logInfoView setCallLogInfoViewWithRecord:dic];
        }else{
            if (detailMinY < newContentY) {
                if (newCellMinY < newContentY) {
                    [_logInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.view.mas_bottom);
                        make.left.equalTo(self.view.mas_right).offset(4);
                        make.width.mas_equalTo(260);
                        make.height.mas_equalTo(156);
                    }];
                }else{
                    [_logInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.view.mas_bottom).offset(-(newCellMinY - newContentY));
                        make.left.equalTo(self.view.mas_right).offset(4);
                        make.width.mas_equalTo(260);
                        make.height.mas_equalTo(156);
                    }];
                }
            }else{
                [_logInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.mas_bottom).offset(-(newCellMaxY - newContentY));
                    make.left.equalTo(self.view.mas_right).offset(4);
                    make.width.mas_equalTo(260);
                    make.height.mas_equalTo(156);
                    
                }];
            }
            _logInfoView.nameLabel.stringValue = cell.callLogLabel.stringValue;
        }
    }else{
        BOOL isContain = CGRectContainsPoint(_logInfoView.frame, point);
        if (isContain) {
            
        }
        else{
            if (_logInfoView) {
                [_logInfoView removeFromSuperview];
                _logInfoView = nil;
            }
            
        }
    }
}
#pragma -mark cycle
#pragma -mark YLCallLogInfoViewDelegate
- (void)YLCallLogInfoView:(YLCallLogInfoView *)view didTopViewAddBtnClicked:(NSButton *)btn{
    if (_logInfoView) {
        [_logInfoView removeFromSuperview];
        _logInfoView = nil;
        //展现新联系人视图
        //NSDictionary *contactDic = [_dataArray objectAtIndex:selectIndexRow];
        NSString *name = @"";
        NSString *number = @"10.3.17.183";
        [self createContactInfoViewWithTopTitle:@"New Contact"
                                        AndName:name
                                      AndNumber:number];
    }
}
- (void)YLCallLogInfoView:(YLCallLogInfoView *)view mouseExitPoint:(NSPoint)point{
    YLCallRecCell *callRecCell = [self.tableList viewAtColumn:0 row:selectIndexRow makeIfNecessary:NO];
    BOOL isContain = CGRectContainsPoint(callRecCell.frame, point);
    if (isContain) {
        
    }
    else{
        if (_logInfoView) {
            [_logInfoView removeFromSuperview];
            _logInfoView = nil;
        }
        
    }
}
#pragma -mark cycle
- (void)createContactInfoViewWithTopTitle:(NSString *)title AndName:(NSString *)name AndNumber:(NSString *)num{
    if (!_maskView) {
        _maskView = [[MaskView alloc] initWithFrame:CGRectZero];
        [self.view.window.contentView addSubview:_maskView];
        [_maskView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view.window.contentView);
        }];
    }
    _addConView = [[YLNewContactInfoView alloc] initWithFrame:CGRectZero];
    [_addConView setNewContactTopViewTitle:title];
    [_addConView setNewContactName:name andNumbers:@[num]];
    _addConView.wantsLayer = YES;
    _addConView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    [_maskView addSubview:_addConView];
    [_addConView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_maskView.mas_centerX);
        make.centerY.equalTo(_maskView.mas_centerY);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(300);
    }];
}
@end
