/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridSelectionStyle.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * The NGridSelectionStyle class describes style of the selection area.
 */
@interface NGridSelectionStyle : NSObject

/**
 * A string that succinctly identifies the selection area.
 */
@property (retain) NSString *accessibilityAreaLabel;

/**
 * A string that succinctly identifies the selection area drag point.
 */
@property (retain) NSString *accessibilityDragPointLabel;

/**
 * Width of the selection area border.
 */
@property (assign) CGFloat borderWidth;

/**
 * Color of the selection area border.
 */
@property (retain) UIColor *borderColor;

/**
 * Background color of the selection area.
 */
@property (retain) UIColor *backgroundColor;

/**
 * Image of the selection area balloon.
 */
@property (retain) UIImage *balloonImage;

@end
