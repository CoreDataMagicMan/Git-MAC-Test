//
//  AppDelegate.m
//  YLTestDemo1
//
//  Created by linms on 16/8/22.
//  Copyright © 2016年 linms. All rights reserved.
//

#import "AppDelegate.h"
#import "YLRootWindowController.h"
@interface AppDelegate ()
@property (strong) YLRootWindowController *rootWindowC;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _rootWindowC = [[YLRootWindowController alloc] initWithWindowNibName:@"YLRootWindowController"];
    
    [_rootWindowC.window center];
    [_rootWindowC.window orderFront:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
