//
//  YLNewContactInfoView.m
//  YLTestDemo1
//
//  Created by linms on 16/8/26.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLNewContactInfoView.h"
#import "YLNewContactInfoElementView.h"
#import "YLContactDataSource.h"
@interface YLNewContactInfoView ()
//topView
@property (nonatomic, strong) NSTextField *titleLabel;
///////////////////////////////////////////////////////
@property (nonatomic, strong) NSButton *addBtn;
@property (nonatomic, strong) NSButton *saveBtn;
@property (nonatomic, strong) YLNewContactInfoElementView *nameView;
@property (nonatomic, retain) NSMutableArray *elementArray;
@end
@implementation YLNewContactInfoView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.layer.cornerRadius = 4.f;
}
- (instancetype)initWithFrame:(NSRect)frameRect{
    if (self = [super initWithFrame:frameRect]) {
        //topView
        NSView *topView = [[NSView alloc] initWithFrame:CGRectZero];
        topView.wantsLayer = YES;
        topView.layer.backgroundColor = RGBA(0, 0, 0, 0.1).CGColor;
        [self addSubview:topView];
        [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(46);
        }];
        //标题
        _titleLabel = [[NSTextField alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [NSColor colorFromHexString:@"#3a3a3a"];
        _titleLabel.font = [NSFont systemFontOfSize:16.f];
        _titleLabel.bordered = NO;
        _titleLabel.editable = NO;
        _titleLabel.backgroundColor = [NSColor clearColor];
        [topView addSubview:_titleLabel];
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(topView.mas_centerX);
            make.centerY.equalTo(topView.mas_centerY);
        }];
        //添加分割线
        NSView *separateLineView = [[NSView alloc] initWithFrame:CGRectZero];
        separateLineView.wantsLayer = YES;
        separateLineView.layer.backgroundColor = RGBA(0, 0, 0, 0.25).CGColor;
        [self addSubview:separateLineView];
        [separateLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(topView);
            make.height.mas_equalTo(1);
        }];
        
        _elementArray = [NSMutableArray new];
        _nameView = [[YLNewContactInfoElementView alloc] initWithFrame:CGRectZero];
        _nameView.isShowDeleBtn = NO;
        _nameView.inputTextField.placeholderString = @"Name";
        [_nameView setTitle:@"Name"];
        [self addSubview:_nameView];
        [_nameView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(topView.mas_bottom).offset(30);
            make.height.mas_equalTo(46);
        }];
        
        YLNewContactInfoElementView *numView = [[YLNewContactInfoElementView alloc] initWithFrame:CGRectZero];
        numView.isShowDeleBtn = NO;
        numView.inputTextField.placeholderString = @"Number 1";
        [numView setTitle:@"Number1"];
        [_elementArray addObject:numView];
        [self addSubview:numView];
        [numView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(_nameView.mas_bottom).offset(14);
            make.height.mas_equalTo(46);
        }];
        
        //添加号码按钮
        _addBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        _addBtn.bordered = NO;
        [_addBtn setBackgroundColor:[NSColor clearColor]];
        _addBtn.title = @"Add Number";
        _addBtn.font = [NSFont systemFontOfSize:14];
        [_addBtn setAttributedTitleWithColor:[NSColor colorFromHexString:@"#039e79"]];
        [_addBtn setTarget:self];
        [_addBtn setAction:@selector(addBtnClicked:)];
        [self addSubview:_addBtn];
        [_addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(40);
            make.right.equalTo(self.mas_right).offset(-40);
            make.top.equalTo(numView.mas_bottom).offset(14);
            make.height.mas_equalTo(30);
        }];
        
        //添加保存按钮
        _saveBtn = [[NSButton alloc] initWithFrame:CGRectZero];
        _saveBtn.bordered = NO;
        _saveBtn.title = @"Save";
        [_saveBtn setAttributedTitleWithColor:[NSColor colorFromHexString:@"#ffffff"]];
        _saveBtn.font = [NSFont systemFontOfSize:14];
        [_saveBtn setBackgroundColor:[NSColor colorFromHexString:@"#039e79"]];
        [_saveBtn setTarget:self];
        [_saveBtn setAction:@selector(saveBtnClicked:)];
        [self addSubview:_saveBtn];
        [_saveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(40);
            make.right.equalTo(self.mas_right).offset(-40);
            make.bottom.equalTo(self.mas_bottom).offset(-30);
            make.height.mas_equalTo(30);
        }];
        
        
    }
    return self;
}


//添加新号码
- (void)addBtnClicked:(NSButton *)btn{
    //更新视图布局
    [self updateViewLayout];
    
}
- (void)updateViewLayout{
    //更新视图content
    YLNewContactInfoElementView *lastElement = _elementArray.lastObject;
    YLNewContactInfoElementView *newNumElement = [[YLNewContactInfoElementView alloc] initWithFrame:CGRectZero];
    [_elementArray addObject:newNumElement];
    [self addSubview:newNumElement];
    [newNumElement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(lastElement.mas_bottom).offset(14);
        make.height.mas_equalTo(46);
    }];
    CGFloat contentH = 0;
    if (_elementArray.count >= 3) {
        contentH = (_elementArray.count + 1)*60 + 136;
        if (_addBtn) {
            [_addBtn removeFromSuperview];
            _addBtn = nil;
        }
    }else{
        contentH = (_elementArray.count + 1)*60 + 180;
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentH);
    }];
    for (int i = 0;i < _elementArray.count;i++) {
        YLNewContactInfoElementView *elementV = _elementArray[i];
        elementV.inputTextField.placeholderString = [NSString stringWithFormat:@"Number %d",(i + 1)];
        [elementV setTitle:[NSString stringWithFormat:@"Number %d",(i + 1)]];
        [elementV setIsShowDeleBtn:YES];
        [self elementViewDeleteBtnAction:elementV];
    }
    lastElement = _elementArray.lastObject;
    [_addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(40);
        make.right.equalTo(self.mas_right).offset(-40);
        make.top.equalTo(lastElement.mas_bottom).offset(14);
        make.height.mas_equalTo(30);
    }];
}
- (void)elementViewDeleteBtnAction:(YLNewContactInfoElementView *)view{
    __block YLNewContactInfoElementView *elementV = view;
    [elementV newContactElementViewDeleteBtnClickedHandle:^{
        //删除按钮点击，布局界面
        [_elementArray removeObject:elementV];
        [elementV removeFromSuperview];
        elementV = nil;
        NSInteger count = _elementArray.count;
        CGFloat contentH = (count + 1)*60 + 180;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(contentH);
        }];
        for (int i = 0;i < _elementArray.count;i++) {
            YLNewContactInfoElementView *elementV = _elementArray[i];
            if (i == 0) {
                [elementV mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self);
                    make.top.equalTo(_nameView.mas_bottom).offset(14);
                    make.height.mas_equalTo(46);
                }];
                elementV.inputTextField.placeholderString = @"Number 1";
                [elementV setTitle:@"Number 1"];
            }else{
                YLNewContactInfoElementView *preElement = _elementArray[i - 1];
                [elementV mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self);
                    make.top.equalTo(preElement.mas_bottom).offset(14);
                    make.height.mas_equalTo(46);
                }];
                elementV.inputTextField.placeholderString = [NSString stringWithFormat:@"Number %d",i + 1];
                [elementV setTitle:[NSString stringWithFormat:@"Number %d",i + 1]];
                
            }
            [elementV setIsShowDeleBtn:(count <= 1 ? NO : YES)];
        }
        YLNewContactInfoElementView *lastElement = _elementArray.lastObject;
        if (!_addBtn) {
            //添加号码按钮
            _addBtn = [[NSButton alloc] initWithFrame:CGRectZero];
            _addBtn.bordered = NO;
            [_addBtn setBackgroundColor:[NSColor clearColor]];
            _addBtn.title = @"Add Number";
            _addBtn.font = [NSFont systemFontOfSize:14];
            [_addBtn setAttributedTitleWithColor:[NSColor colorFromHexString:@"#039e79"]];
            [_addBtn setTarget:self];
            [_addBtn setAction:@selector(addBtnClicked:)];
            [self addSubview:_addBtn];
        }
        [_addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(40);
            make.right.equalTo(self.mas_right).offset(-40);
            make.top.equalTo(lastElement.mas_bottom).offset(14);
            make.height.mas_equalTo(30);
        }];
    }];
}

//保存联系人信息
- (void)saveBtnClicked:(NSButton *)btn{
    //同步化联系人的数据，并通知tableview界面数据刷新操作
    YLNewContactInfoElementView *num1Element = self.elementArray.firstObject;
    NSString *name = _nameView.inputTextField.stringValue;
    NSString *number1 = num1Element.inputTextField.stringValue;
    NSMutableArray *dataArray = [YLContactDataSource synContactName:name AndContactNumber:number1];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNeedRefreshData" object:self userInfo:@{@"ContactInfo":dataArray}];
}

//设置联系人显示信息
- (void)setNewContactName:(NSString *)name andNumbers:(NSArray *)numArray{
    if (self.elementArray.count) {
        _nameView.inputTextField.stringValue = name;
        if (_elementArray.count == numArray.count) {
            int count = (int)_elementArray.count;
            for (int i = 0; i < count; i++) {
                YLNewContactInfoElementView *elementView = _elementArray[i];
                NSString *number = numArray[i];
                elementView.inputTextField.stringValue = number;
            }
        }
    }
}
//设置新建联系人topView标题栏
- (void)setNewContactTopViewTitle:(NSString *)title{
    if (title) {
        _titleLabel.stringValue = title;
    }
}
@end
