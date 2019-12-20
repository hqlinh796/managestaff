/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCell.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridCellStyle.h"
#import "NGridCellKey.h"
#import "NGridCellCoordinate.h"

@class NGridRow;
@class NGridColumn;
@class NGridView;

/**
 * The NGridCell class defines base attributes and behavior of the cells.
 * If you want to implement the new type of cell, create a class inherited from NGridCell.
 *
 * @note <NGridProxyDataSourceImpl> (used as the default proxy data source) works with <NGridCommonCell>,
 * so if you want to create your own cell inherit it from <NGridCommonCell>.
 */
@interface NGridCell : UIView

/**
 * Returns cell width.
 * This width include all included columns width.
 */
@property (readonly) CGFloat width;

/**
 * Returns cell height.
 * This height include all included rows height.
 */
@property (readonly) CGFloat height;

/**
 * Returns row object.
 * @see specification of <NGridRow> class.
 */
@property (readonly) NGridRow *row;

/**
 * Returns column object.
 * @see specification of <NGridColumn> class.
 */
@property (readonly) NGridColumn *column;

/**
 * Returns cell style.
 */
@property (nonatomic, readonly) NGridCellStyle *style;

/**
 * The key of the cell.
 */
@property (retain) NGridCellKey *key;

/**
 * The coordinate of the cell.
 */
@property (retain) NGridCellCoordinate *coordinate;

/**
 * The reuse identifier used for cell caching and reusing.
 * The proper way is to assign separate ID for each of the cell types (cells of headers, usual cells).
 */
@property (readonly) NSString *reuseIdentifier;

/**
 * Grid using cell.
 * Must be set as pointer to grid view in which current cell actually appears.
 */
@property (assign) NGridView *parentGrid;

/**
 * A Boolean value that determines whether the cell is highlighted.
 *
 * Highlighting may change cell background, text color and font etc.
 */
@property (nonatomic, assign) BOOL isHighlighted;

/**
 * A Boolean value that determines whether the cell should looks like clickable.
 *
 * If set to YES – clickable cell background brush is used as background (if it is set in <style>).
 */
@property (assign) BOOL drawAsClickable;

/**
 * Init cell with reuse identifier.
 * Init cell and set up its reuse identifier.
 * @param reuseIdentifier String ID which used to find this cell in reuse cache.
 */
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

/**
 * Prepares cell to reuse. Clears inner state.
 */
- (void)prepareForReuse;

/**
 * Returns the size of the cell if it were rendered with the specified constraints.
 * @param size The maximum acceptable size for the string. If width or height equals to 0.0 method ignores corresponding constraints.
 */
- (CGSize)bestSizeConstrainedToSize:(CGSize)size;

/**
 * Applies the style to cell.
 * Does not change the style in the proxy data source.
 * @param style Style object.
 */
- (void)applyStyle:(NGridCellStyle *)style;

/**
 * Converts internal data to human readable format.
 */
- (NSString *)stringValue;

@end
