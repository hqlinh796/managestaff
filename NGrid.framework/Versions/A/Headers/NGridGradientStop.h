/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridGradientStop.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class UIColor;

/**
 * The NGridGradientStop class provides color and position for <NGridGradientBrush>.
 */
@interface NGridGradientStop : NSObject<NSCopying, NSCoding>

/**
 * Creates gradient stop.
 *
 * @param color Color of the gradient stop.
 * @param offset Relative offset of the gradient stop, [0, 1], 0 means beginning of the area, 1 means end of the area.
 */
+ (NGridGradientStop *)gradientStopWithColor:(UIColor *)color offset:(CGFloat)offset;

/**
 * Initializes gradient stop.
 *
 * @param color Color of gradient stop.
 * @param offset Relative offset of gradient stop, [0, 1], 0 means beginning of the area, 1 means end of the area.
 */
- (id)initWithColor:(UIColor *)color offset:(CGFloat)offset;

/**
 * Color of the gradient stop.
 */
@property (nonatomic, retain) UIColor *color;

/**
 * Relative offset of the gradient stop, [0, 1], 0 means the beginning of the area, 1 means the end of the area.
 */
@property (nonatomic, assign) CGFloat offset;

@end
