/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridDataSource.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import "NGridCellUnionSet.h"

@class NGridCell;
@class NGridView;

/**
 * The NGridDataSource protocol defines methods that should be implemented to provide the grid data.
 */
@protocol NGridDataSource <NSObject>

/**
 * Asks the data source to return the cell by key.
 * @param gridView Grid view that requests the cell.
 * @param cellKey Key of the needed cell.
 */
- (NGridCell *)gridView:(NGridView *)gridView cellWithKey:(NGridCellKey *)cellKey;

/**
 * Asks the data source to return the cell value by the cell key.
 * @param gridView Grid view that requests the cell.
 * @param cellKey Key of the needed cell.
 */
- (NSObject *)gridView:(NGridView *)gridView valueForCellWithKey:(NGridCellKey *)cellKey;

/**
 * Asks the data source to return the number of the rows.
 * @param gridView Related grid view object.
 */
- (NSInteger)gridViewRowCount:(NGridView *)gridView;

/**
 * Asks the data source to return the number of the columns.
 * @param gridView Related grid view object.
 */
- (NSInteger)gridViewColumnCount:(NGridView *)gridView;

/**
 * Asks the data source to return the number of the row headers.
 * @param gridView Related grid view object.
 */
-(NSInteger)gridViewRowHeaderCount:(NGridView *)gridView;

/**
 * Asks the data source to return the number of the column headers.
 * @param gridView Related grid view object.
 */
-(NSInteger)gridViewColumnHeaderCount:(NGridView *)gridView;

@optional

/**
 * Asks the data source to return the cell text indentation.
 * @param gridView Grid view that requests cell.
 * @param cellKey Key of the needed cell.
 */
- (NSInteger)gridView:(NGridView *)gridView indentForCellWithKey:(NGridCellKey *)cellKey;

/**
 * Asks the data source to return the key of the row which is a parent for the specified one.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row.
 */
- (NSInteger)gridView:(NGridView *)gridView parentRowKeyForRowWithKey:(NSInteger)rowKey;

/**
 * Asks the data source to return the key of the column which is a parent for the specified one.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column.
 */
- (NSInteger)gridView:(NGridView *)gridView parentColumnKeyForColumnWithKey:(NSInteger)columnKey;

/**
 * Asks the data source to return union set for grid view.
 * @param gridView Related grid view object.
 */
- (NGridCellUnionSet *)cellUnionSetForGridView:(NGridView *)gridView;

/**
 * Asks the data source whether selection is allowed. Return YES to allow selection in the grid.
 * @param gridView Related grid view object.
 */
- (BOOL)gridViewCanSelectRowsAndColumns:(NGridView *)gridView;

/**
 * Asks the data source to set the value by the cell key.
 * @param gridView Related grid view object.
 * @param value Value for cell.
 * @param cellKey Key of the cell.
 */
- (void)gridView:(NGridView *)gridView setValue:(NSObject *)value forCellWithKey:(NGridCellKey *)cellKey;

/**
 * Asks the data source whether specified row is section.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row.
 */
- (BOOL)gridView:(NGridView *)gridView rowWithKeyIsSection:(NSInteger)rowKey;

/**
 * Asks the data source whether specified column is section.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column.
 */
- (BOOL)gridView:(NGridView *)gridView columnWithKeyIsSection:(NSInteger)columnKey;

/**
 * Compare two cell values. This method is called when the grid is being sorted to compare the pairs of cell values.
 * @param cellVal1 - first cell value to compare.
 * @param cellVal2 - second cell value to compare.
 * @param caseInsensitive - flag determining if the case (if applied) should be ignored (YES) or taken into account (NO).
 * @return comparison result.
 */
- (NSComparisonResult)compareCellValue:(NSObject *)cellVal1 toCellValue:(NSObject *)cellVal2 caseInsensitive:(BOOL)caseInsensitive;

@end
