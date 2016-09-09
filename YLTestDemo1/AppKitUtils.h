//
//  AppKitUtils.h
//  YLTestDemo1
//
//  Created by linms on 16/9/7.
//  Copyright © 2016年 linms. All rights reserved.
//

#ifndef AppKitUtils_h
#define AppKitUtils_h

#pragma mark OS X

// Content Hugging
#define HUG_H(VIEW, PRIORITY)                                                  \
[VIEW setContentHuggingPriority:(PRIORITY)                                   \
forOrientation:NSLayoutConstraintOrientationHorizontal]
#define HUG_V(VIEW, PRIORITY)                                                  \
[VIEW setContentHuggingPriority:(PRIORITY)                                   \
forOrientation:NSLayoutConstraintOrientationVertical]
#define HUG(VIEW, PRIORITY)                                                    \
{                                                                            \
HUG_H(VIEW, PRIORITY);                                                     \
HUG_V(VIEW, PRIORITY);                                                     \
}

// Compression Resistance
#define RESIST_H(VIEW, PRIORITY)                                               \
[VIEW setContentCompressionResistancePriority:(PRIORITY)                     \
forOrientation:                               \
NSLayoutConstraintOrientationHorizontal]
#define RESIST_V(VIEW, PRIORITY)                                               \
[VIEW setContentCompressionResistancePriority:(PRIORITY)                     \
forOrientation:                               \
NSLayoutConstraintOrientationVertical]
#define RESIST(VIEW, PRIORITY)                                                 \
{                                                                            \
RESIST_H(VIEW, PRIORITY);                                                  \
RESIST_V(VIEW, PRIORITY);                                                  \
}

#endif /* AppKitUtils_h */
