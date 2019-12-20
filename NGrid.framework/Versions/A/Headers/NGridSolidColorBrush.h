/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridSolidColorBrush.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridBrush.h"

/**
 * The NGridSolidColorBrush class provides brush filling areas with solid color.
 */
@interface NGridSolidColorBrush : NGridBrush

/**
 * Creates solid color brush.
 *
 * @param color Color of the brush.
 */
+ (NGridSolidColorBrush *)solidColorBrushWithColor:(UIColor *)color;

/**
 * Color of the brush.
 */
@property (nonatomic, retain) UIColor *color;

@end
