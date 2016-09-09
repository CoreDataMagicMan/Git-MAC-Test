//
//  AppDefineHeader.h
//  YLTestDemo1
//
//  Created by linms on 16/9/5.
//  Copyright © 2016年 linms. All rights reserved.
//

#ifndef AppDefineHeader_h
#define AppDefineHeader_h

#import "Masonry.h"
#import "NSColor+Common.h"
#import "NSButton+Extension.h"

// RGBA颜色
#define RGB(r,g,b)    \
([NSColor colorWithRed:r/255.00 green:g/255.00 blue:b/255.00 alpha:1.0])

#define RGBA(r,g,b,a) \
([NSColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#endif /* AppDefineHeader_h */
