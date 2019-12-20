/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridGradientBrush.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridBrush.h"
#import "NGridGradientStop.h"

/**
 * The NGradientBrush class provides the base for brushes filling areas with gradients.
 */
@interface NGridGradientBrush : NGridBrush

/**
 * Calculate maximum distance from given point to the edges of given rect.
 *
 * @param p Point to find maximal distance from.
 * @param rect Rect to find maximal distance to.
 */
- (CGFloat) calcMaxDistance: (CGPoint)p toEdges:(CGRect)rect;

/**
 * Create instance of CGGradient used as low-level gradient tool.
 */
- (CGGradientRef) gradient;

/**
 * Mutable array of gradient stops (see <NGridGradientStop>) controlling gradient colors and their positions.
 */
@property (nonatomic, retain) NSMutableArray *gradientStops;

/**
 * Reference to the instance of CGGradient used as low-level gradient tool.
 */
@property (nonatomic, readonly) CGGradientRef gradient;

@end
