/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridResizerArea.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridView.h"
#import "NGridResizerStyle.h"

/**
 * The NGridResizerArea class represents cell resizer in the grid.
 */
@interface NGridResizerArea : UIView 

/**
 * Grid using the resizer.
 */
@property (nonatomic, assign) NGridView *parentGrid;

/**
 * Origin frame of the resizer.
 */
@property (nonatomic, assign, readwrite) CGRect originFrame;

/**
 * Style of the resizer.
 */
@property (readonly) NGridResizerStyle *style;

/**
 * Creates resizer for the grid view.
 * @param gridView Related grid view.
 * @param style Style for the resizer.
 */
+ (NGridResizerArea *)resizerForGridView:(NGridView *)gridView withStyle:(NGridResizerStyle *)style;

/**
 * Starts resizing height of the cell.
 * @param cell Related cell.
 */
- (void)resizeHeightForCell:(NGridCell *)cell;

/**
 * Starts resizing width of the cell.
 * @param cell Related cell.
 */
- (void)resizeWidthForCell:(NGridCell *)cell;

/**
 * Finishes resizing.
 */
- (void)finish;

/**
 * Stretches resizer size after its change.
 */
- (void)stretch;

@end
