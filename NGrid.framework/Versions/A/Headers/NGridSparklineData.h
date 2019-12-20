/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridSparklineData.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * The NGridSparklineData class is used to prepare data to draw sparklines.
 */
@interface NGridSparklineData : NSObject

/**
 * Values used to draw sparklines.
 */
@property (retain) NSArray *values;

/**
 * Value used to draw top peak.
 */
@property (assign) CGFloat maxValue;

/**
 * Value used to draw bottom peak.
 */
@property (assign) CGFloat minValue;

/**
 * Index in values with maximum value.
 */
@property (assign) NSInteger maxPeakElementIndex;

/**
 * Index in values with minimum value.
 */
@property (assign) NSInteger minPeakElementIndex;

@end
