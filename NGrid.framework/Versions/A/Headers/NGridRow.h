/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridRow.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridCell.h"

@class NGridView;

/**
 * The NGridRow class defines attributes of grid row. Row objects are immutable.
 */
@interface NGridRow : NSObject

/**
 * Grid that created the row.
 */
@property (readonly) NGridView *parentGrid;

/**
 * Key of the row.
 */
@property (readonly) NSInteger key;

/**
 * Coordinate of the row.
 */
@property (readonly) NSInteger coordinate;

/**
 * A Boolean value that determines whether the row was a header.
 *
 * Header rows positioned at the top of the grid and used to display titles of columns.
 */
@property (readonly) BOOL isHeader;

/**
 * Constructor to create row object.
 *
 * @param gridView Related grid view.
 * @param key Row key.
 * @param coordinate Row coordinate.
 * @param isHeader Header status.
 */
- (id)initWithGrid:(NGridView *)gridView key:(NSInteger)key coordinate:(NSInteger)coordinate andHeaderStatus:(BOOL)isHeader;

/**
 * Returns the cell in the current row.
 * @param columnCoordinate Coordinate of the needed column.
 */
- (NGridCell *)cellInColumnWithIndex:(NSInteger)columnCoordinate;

/**
 * Returns the position of the row in pixels.
 */
- (CGFloat)yPosition;

/**
 * Returns absolute position of the row in pixels.
 * Absolute position is a position of the column if grid view content offset equals to {0, 0}.
 */
- (CGFloat)absoluteYPosition;

/**
 * Height of the row in pixels.
 */
- (CGFloat)height;

/**
 * Row freeze state.
 *
 * If row is frozen then it's doesn't hide when you scroll the grid.
 */
- (BOOL)isFrozen;

/**
 * Returns a Boolean value indicating whether the row is expanded.
 */
- (BOOL)isExpanded;

@end
