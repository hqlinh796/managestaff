/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridColumn.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridCell.h"

@class NGridView;

/**
 * The NGridColumn class defines attributes of the grid column.
 */
@interface NGridColumn : NSObject

/**
 * Grid that created the column.
 */
@property (readonly) NGridView *parentGrid;

/**
 * Key that identifies the column.
 */
@property (readonly) NSInteger key;

/**
 * Coordinate of the column.
 */
@property (readonly) NSInteger coordinate;

/**
 * A Boolean value that determines whether the column was a header.
 *
 * Header columns positioned to the left/right of the grid and used to display titles of the rows.
 */
@property (readonly) BOOL isHeader;

/**
 * Column object initializer.
 *
 * @param gridView Related grid view.
 * @param key Key of the column.
 * @param coordinate Coordinate of the column.
 * @param isHeader Flag determining if column is a part of header.
 */
- (id)initWithGrid:(NGridView *)gridView key:(NSInteger)key coordinate:(NSInteger)coordinate andHeaderStatus:(BOOL)isHeader;

/**
 * Returns cell in the current column.
 * @param rowCoordinate Coordinate of the needed row.
 */
- (NGridCell *)cellInRowWithCoordinate:(NSInteger)rowCoordinate;

/**
 * Returns position of the column in pixels.
 */
- (CGFloat)xPosition;

/**
 * Returns absolute position of the column in pixels.
 * Absolute position is a position of column in case of grid view content offset == {0, 0}.
 */
- (CGFloat)absoluteXPosition;

/**
 * Returns width of the column in pixels.
 */
- (CGFloat)width;

/**
 * Returns column freeze state.
 *
 * If column is frozen then it's doesn't hide when you scroll the grid.
 */
- (BOOL)isFrozen;

/**
 * Returns a Boolean value indicating whether the column is expanded.
 */
- (BOOL)isExpanded;

@end
