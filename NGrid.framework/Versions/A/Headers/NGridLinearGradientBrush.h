/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridLinearGradientBrush.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridGradientBrush.h"
#import "NGridGradientStop.h"

/**
 * The NGridLinearGradientBrush class provides brush filling areas with linear gradient. Gradient is spread from the start point to
 * the end point, everything below the start and above the end is filled by the edge colors (the first and the last on in <NGridGradientStops>
 * array).
 */
@interface NGridLinearGradientBrush :NGridGradientBrush

/**
 * Starting point of the gradient. It is relative to the area, value should be in ([0; 1]; [0; 1]). (0; 0) is the bottom left corner
 * of the area, (1; 1) is the top right corner.
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 * Ending point of the gradient. It is relative to the area, value should be in ([0; 1]; [0; 1]). (0; 0) is the bottom left corner
 * of the area, (1; 1) is the top right corner.
 */
@property (nonatomic, assign) CGPoint endPoint;

@end
