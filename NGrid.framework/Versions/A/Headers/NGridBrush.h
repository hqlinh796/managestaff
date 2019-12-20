/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridBrush.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * The NGridBrush class is an abstract class defining the brush interface.
 */
@interface NGridBrush : NSObject<NSCopying, NSCoding>

/**
 * Opacity of the brush.
 */
@property (nonatomic, assign) double opacity;

/**
 * Applies brush to context.
 * @param context Context.
 * @param path Path to draw.
 * @param rect Rect.
 */
- (void)applyToContext:(CGContextRef)context path:(CGPathRef)path rect:(CGRect)rect;

@end
