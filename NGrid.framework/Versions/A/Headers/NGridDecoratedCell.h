/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridDecoratedCell.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import "NGridCell.h"

/**
 * The NGridDecoratedCell class defines attributes and behavior of the cells with border decorations.
 */
@interface NGridDecoratedCell : NGridCell

/**
 * Size of the top border in pixels.
 */
@property (assign) CGFloat topBorderWidth;

/**
 * Size of the right border in pixels.
 */
@property (assign) CGFloat rightBorderWidth;

/**
 * Size of the bottom border in pixels.
 */
@property (assign) CGFloat bottomBorderWidth;

/**
 * Size of the left border in pixels.
 */
@property (assign) CGFloat leftBorderWidth;

/**
 * Convenient method for setting all four values for top, right, bottom, left borders  in pixels.
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 * Color of the left border.
 */
@property (nonatomic, retain) UIColor *leftBorderColor;

/**
 * Color of the right border.
 */
@property (nonatomic, retain) UIColor *rightBorderColor;

/**
 * Color of the top border.
 */
@property (nonatomic, retain) UIColor *topBorderColor;

/**
 * Color of the bottom border.
 */
@property (nonatomic, retain) UIColor *bottomBorderColor;

/**
 * Left dash pattern.
 * Used if non-solid lines are needed.
 * Expects an array of values that specify the lengths of the painted segments and unpainted segments, respectively, of the dash pattern.
 */
@property (nonatomic, retain) NSArray *leftDash;

/**
 * Right dash pattern.
 * Used if non-solid lines are required.
 * Expects an array of values that specify the lengths of the painted segments and unpainted segments, respectively, of the dash pattern.
 */
@property (nonatomic, retain) NSArray *rightDash;

/**
 * Top dash pattern.
 * Used if non-solid lines are needed.
 * Expects an array of values that specify the lengths of the painted segments and unpainted segments, respectively, of the dash pattern.
 */
@property (nonatomic, retain) NSArray *topDash;

/**
 * Bottom dash pattern.
 * Used if non-solid lines are needed.
 * Expects an array of values that specify the lengths of the painted segments and unpainted segments, respectively, of the dash pattern.
 */
@property (nonatomic, retain) NSArray *bottomDash;

@end
