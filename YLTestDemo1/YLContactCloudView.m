//
//  YLContactCloudView.m
//  YLTestDemo1
//
//  Created by linms on 16/9/2.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "YLContactCloudView.h"
@interface YLContactCloudView()
@property (weak) IBOutlet NSButton *localBtn;
@property (weak) IBOutlet NSButton *cloudBtn;
@end
@implementation YLContactCloudView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    
}
- (void)viewDidMoveToWindow{
    [super viewDidMoveToWindow];
    self.layer.cornerRadius = 4.f;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.4f;
    self.layer.borderColor = [NSColor colorFromHexString:@"#42b49a"].CGColor;
    //local
    [_localBtn setAttributedTitleWithColor:[NSColor whiteColor]];
    _localBtn.font = [NSFont systemFontOfSize:16];
    [_localBtn setBackgroundColor:[NSColor colorFromHexString:@"#42b49a"]];
    [_localBtn setTarget:self];
    [_localBtn setAction:@selector(localBtnClicked:)];
    //cloud
    [_cloudBtn setAttributedTitleWithColor:[NSColor colorFromHexString:@"#42b49a"]];
    _cloudBtn.font = [NSFont systemFontOfSize:16];
    [_cloudBtn setBackgroundColor:[NSColor whiteColor]];
    [_cloudBtn setTarget:self];
    [_cloudBtn setAction:@selector(cloudBtnClicked:)];
}
- (void)localBtnClicked:(NSButton *)btn{
    [btn setBackgroundColor:[NSColor colorFromHexString:@"#42b49a"]];
    [btn setAttributedTitleWithColor:[NSColor whiteColor]];
    [_cloudBtn setBackgroundColor:[NSColor whiteColor]];
    [_cloudBtn setAttributedTitleWithColor:[NSColor colorFromHexString:@"#42b49a"]];
}
- (void)cloudBtnClicked:(NSButton *)btn{
    [btn setBackgroundColor:[NSColor colorFromHexString:@"#42b49a"]];
    [btn setAttributedTitleWithColor:[NSColor whiteColor]];
    [_localBtn setBackgroundColor:[NSColor whiteColor]];
    [_localBtn setAttributedTitleWithColor:[NSColor colorFromHexString:@"#42b49a"]];
}

@end
