/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridRadialGradientBrush.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import "NGridGradientBrush.h"

/**
 * The NGridRadialGradientBrush class provides brush filling areas with radial gradient.
 */
@interface NGridRadialGradientBrush : NGridGradientBrush

/**
 * Center of the gradient in relative values, ([0; 1]; [0; 1]).
 */
@property (nonatomic, assign) CGPoint center;

@end
