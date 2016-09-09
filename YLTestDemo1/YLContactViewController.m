//
//  YLContactViewController.m
//  YLTestDemo1
//
//  Created by linms on 16/8/22.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLContactViewController.h"
#import "YLContactDataSource.h"
#import "YLContactCell.h"
#import "YLContactInfoView.h"
#import "AppDelegate.h"
#import "MaskView.h"
#import "YLNewContactInfoView.h"
#import "YLSearchBar.h"
#import "YLDeleteContactAlertView.h"

@interface YLContactViewController ()<NSTableViewDelegate,NSTableViewDataSource,YLContactCellDelegate,YLContactInfoViewDelegate,YLSearchBarDelegate>{
    NSInteger selectIndexRow;
}
@property (weak) IBOutlet NSTableView *tableList;
@property (weak) IBOutlet YLSearchBar *searchBar;
@property (weak) IBOutlet NSTextField *resultLabel;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) YLContactInfoView *detailView;
@property (nonatomic, strong) MaskView *maskView;
@property (nonatomic, strong) YLNewContactInfoView *addConView;
@end

@implementation YLContactViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do view setup here.
    _resultLabel.font = [NSFont systemFontOfSize:16];
    _resultLabel.textColor = [NSColor colorFromHexString:@"#888888"];
    _resultLabel.stringValue = @"5 Contacts";
    _searchBar.searchDelegate = self;
    _tableList.delegate = self;
    _tableList.dataSource = self;
    [_tableList setGridColor:[NSColor clearColor]];
    NSTableColumn *column  = [[_tableList tableColumns] firstObject];
    column.width = 249.f;
    column.maxWidth = 249.f;
    column.minWidth = 249.f;
    column.editable = NO;
    column.headerCell.title = [NSString stringWithFormat:@"%ld 联系人",_dataArray.count];
    _dataArray = [YLContactDataSource searchContact];
    [_tableList reloadData];
    [self registerNotification];
    
}
- (void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNeedRefreshData:) name:@"kNeedRefreshData" object:nil];
}
- (void)handleNeedRefreshData:(NSNotification *)note{
    if ([note.name isEqualToString:@"kNeedRefreshData"]) {
        NSDictionary *dic = note.userInfo;
        _dataArray = [dic objectForKey:@"ContactInfo"];
        [_addConView removeFromSuperview];
        [_maskView removeFromSuperview];
        _addConView = nil;
        _maskView = nil;
        [self.tableList reloadData];
    }
}

#pragma -mark NSTableViewDataSource NSTableViewDelegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return _dataArray.count;
}
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    NSDictionary *dic = _dataArray[row];
    NSString *identifier = [tableColumn identifier];
    if ([identifier isEqualToString:@"ContactColumn"]) {
        YLContactCell *contactCell = [tableView makeViewWithIdentifier:identifier owner:self];
        contactCell.delegate = self;
        contactCell.nameLabel.stringValue = [dic objectForKey:@"Name"];
        contactCell.numberLabel.stringValue = [dic objectForKey:@"Number"];
        return contactCell;
    }
    return nil;
}
- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
    //取到tableview对应行的view
    YLContactCell *contactCell = [tableView viewAtColumn:0 row:row makeIfNecessary:NO];
    contactCell.layer.backgroundColor = [NSColor colorWithRed:0 green:0 blue:0 alpha:0.2f].CGColor;
    return NO;
}
#pragma -mark cycle
#pragma -mark YLContactCellDelegate
- (void)YLContactCell:(YLContactCell *)cell isShowOrHidden:(BOOL)isShow ExitPoint:(NSPoint)exitPoint{
    //保存row的index path
    selectIndexRow = [self.tableList rowForView:cell];
    //添加一个详情信息显示视图
    if (isShow) {
        NSRect newContentFrame = [self.view convertRect:self.view.frame toView:self.view.window.contentView];
        CGFloat newContentY = newContentFrame.origin.y;
        NSRect newCellFrame = [cell convertRect:cell.frame toView:self.view.window.contentView];
        CGFloat newCellMaxY = CGRectGetMaxY(newCellFrame);
        CGFloat newCellMinY = CGRectGetMinY(newCellFrame);
        CGFloat detailMinY = newCellMaxY - 84;
        if (!_detailView) {
            _detailView = [[YLContactInfoView alloc] initWithFrame:CGRectZero];
            [self.view.window.contentView addSubview:_detailView];
            [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_bottom).offset(-(newCellMaxY - newContentY));
                make.left.equalTo(self.view.mas_right).offset(4);
                make.width.mas_equalTo(260);
                make.height.mas_equalTo(84);
            }];
            if (detailMinY < newContentY) {
                if (newCellMinY < newContentY) {
                    [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.view.mas_bottom);
                        make.left.equalTo(self.view.mas_right).offset(4);
                        make.width.mas_equalTo(260);
                        make.height.mas_equalTo(84);
                    }];
                }else{
                    [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.view.mas_bottom).offset(-(newCellMinY - newContentY));
                        make.left.equalTo(self.view.mas_right).offset(4);
                        make.width.mas_equalTo(260);
                        make.height.mas_equalTo(84);
                    }];
                }
            }
            _detailView.delegate = self;
            _detailView.wantsLayer = YES;
            _detailView.layer.backgroundColor = [NSColor whiteColor].CGColor;
            [_detailView setContactInfoTopViewTitle:[cell.nameLabel stringValue]];
            [_detailView setContactInfoElementViewTitle:@"Number1:" andSubTitle:[cell.numberLabel stringValue]];
        }else{
            if (detailMinY < newContentY) {
                if (newCellMinY < newContentY) {
                    [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.view.mas_bottom);
                        make.left.equalTo(self.view.mas_right).offset(4);
                        make.width.mas_equalTo(260);
                        make.height.mas_equalTo(84);
                    }];
                }else{
                    [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(self.view.mas_bottom).offset(-(newCellMinY - newContentY));
                        make.left.equalTo(self.view.mas_right).offset(4);
                        make.width.mas_equalTo(260);
                        make.height.mas_equalTo(84);
                    }];
                }
            }else{
                [_detailView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view.mas_bottom).offset(-(newCellMaxY - newContentY));
                    make.left.equalTo(self.view.mas_right).offset(4);
                    make.width.mas_equalTo(260);
                    make.height.mas_equalTo(84);
                    
                }];
            }
            [_detailView setContactInfoTopViewTitle:[cell.nameLabel stringValue]];
            [_detailView setContactInfoElementViewTitle:@"Number1:" andSubTitle:[cell.numberLabel stringValue]];
            
        }
    }else{
        BOOL isContain = CGRectContainsPoint(_detailView.frame, exitPoint);
        if (isContain) {
            
        }
        else{
            if (_detailView) {
                [_detailView removeFromSuperview];
                _detailView = nil;
            }
            
        }
    }
    
}
#pragma -mark cycle
#pragma -mark YLDetailInfoViewDelegate
- (void)YLContactInfoView:(YLContactInfoView *)view ExitPoint:(NSPoint)exitPoint{
    YLContactCell *contactCell = [self.tableList viewAtColumn:0 row:selectIndexRow makeIfNecessary:NO];
    BOOL isContain = CGRectContainsPoint(contactCell.frame, exitPoint);
    if (isContain) {
        
    }
    else{
        if (_detailView) {
            [_detailView removeFromSuperview];
            _detailView = nil;
        }
        
    }
}
- (void)YLContactInfoView:(YLContactInfoView *)view topViewEditBtnClicked:(NSButton *)btn{
    if (_detailView) {
        [_detailView removeFromSuperview];
        _detailView = nil;
        //展现新联系人视图
        NSDictionary *contactDic = [_dataArray objectAtIndex:selectIndexRow];
        NSString *name = [contactDic objectForKey:@"Name"];
        NSString *number = [contactDic objectForKey:@"Number"];
        [self createContactInfoViewWithTopTitle:@"Edit Contact"
                                        AndName:name
                                        AndNumber:number];
    }
    
}
- (void)YLContactInfoView:(YLContactInfoView *)view topViewDeleteBtnClicked:(NSButton *)btn{
    if (_detailView) {
        [_detailView removeFromSuperview];
        _detailView = nil;
    }
    
  
    //添加删除框
    __block MaskView *maskView = [[MaskView alloc] initWithFrame:CGRectZero];
    [self.view.window.contentView addSubview:maskView];
    [maskView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.window.contentView);
    }];
    
    __block YLDeleteContactAlertView *deAlertView = [[YLDeleteContactAlertView alloc] initWithFrame:CGRectZero];
    [maskView addSubview:deAlertView];
    [deAlertView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(maskView.mas_centerX);
        make.centerY.equalTo(maskView.mas_centerY);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(150);
    }];
    [deAlertView alertViewReturnBtnClickedHandle:^(YLAlertViewReturnButtonType buttonType) {
        if (buttonType == YLAlertViewReturnConfirmButtonType) {
            if (deAlertView) {
                [deAlertView removeFromSuperview];
                deAlertView = nil;
            }
            if (maskView) {
                [maskView removeFromSuperview];
                maskView = nil;
            }
        }else if (buttonType == YLAlertViewReturnCancelButtonType){
            if (deAlertView) {
                [deAlertView removeFromSuperview];
                deAlertView = nil;
            }
            if (maskView) {
                [maskView removeFromSuperview];
                maskView = nil;
            }
        }
    }];
    
}
#pragma -mark cycle
#pragma -mark YLSearchBarDelegate
- (void)YLSearchBar:(YLSearchBar *)searchTextField didChangeString:(NSString *)string{
    NSLog(@"string:%@",string);
}
#pragma -mark cycle
//添加联系人
- (IBAction)addContact:(NSButton *)sender {
    [self createContactInfoViewWithTopTitle:@"New Contact" AndName:@""
                                  AndNumber:@""];
}

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
        make.center.equalTo(_maskView);
        make.width.mas_equalTo(310);
        make.height.mas_equalTo(300);
    }];
}

@end
