/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridProxyDataSource.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import "NGridCellStyle.h"
#import "NGridSortSettingsProtocol.h"
#import "NGridFilterSettingsProtocol.h"
#import "NGridHighlightSettingsProtocol.h"
#import "NGridStyleManager.h"
#import "NGridDataSource.h"
#import "NGridCellCoordinate.h"

@class NGridCellStyle;

/**
 * The NGridProxyDataSource protocol defines methods that should be implemented to provide the data and behavior to grid.
 * Proxy data source is used as the data mediator. It is responsible for sorting, filtering, formatting etc.
 */
@protocol NGridProxyDataSource <NSObject>

/**
 * Asks the proxy data source to return the cell by the coordinate in the grid view.
 * @param gridView Related grid view object.
 * @param cellCoordinate Coordinate of the needed cell.
 */
- (NGridCell *)gridView:(NGridView *)gridView cellWithCoordinate:(NGridCellCoordinate *)cellCoordinate;

/**
 * Asks the proxy data source to return the row count in the grid view.
 * @param gridView Related grid view object.
 */
- (NSInteger)gridViewRowCount:(NGridView *)gridView;

/**
 * Asks the proxy data source to return the column count in the grid view.
 * @param gridView Related grid view object.
 */
- (NSInteger)gridViewColumnCount:(NGridView *)gridView;

/**
 * Asks the proxy data source to return the row header count (count of header columns).
 * @param gridView Related grid view object.
 */
- (NSInteger)gridViewRowHeaderCount:(NGridView *)gridView;

/**
 * Asks the proxy data source to return the column header count (count of header rows).
 * @param gridView Related grid view object.
 */
- (NSInteger)gridViewColumnHeaderCount:(NGridView *)gridView;

/**
 * Asks the proxy data source to convert the cell coordinate to the cell key.
 * @param gridView Related grid view object.
 * @param cellCoordinate Coordinate of the cell.
 */
- (NGridCellKey *)gridView:(NGridView *)gridView cellKeyByCoordinate:(NGridCellCoordinate *)cellCoordinate;

/**
 * Asks the proxy data source to convert the row key to the row coordinate.
 * @param gridView Related grid view object.
 * @param rowCoordinate Coordinate of the row in the grid view.
 */
- (NSInteger)gridView:(NGridView *)gridView rowKeyByCoordinate:(NSInteger)rowCoordinate;

/**
 * Asks the proxy data source to convert the column key to the column coordinate.
 * @param gridView Related grid view object.
 * @param columnCoordinate Coordinate of column in the grid view.
 */
- (NSInteger)gridView:(NGridView *)gridView columnKeyByCoordinate:(NSInteger)columnCoordinate;

/**
 * Asks the proxy data source to convert the cell key to the cell coordinate.
 * @param gridView Related grid view object.
 * @param cellKey Key of the cell.
 */
- (NGridCellCoordinate *)gridView:(NGridView *)gridView cellCoordinateByKey:(NGridCellKey *)cellKey;

/**
 * Asks the proxy data source to convert the row coordinate to the row key.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row in the data source.
 */
- (NSInteger)gridView:(NGridView *)gridView rowCoordinateByKey:(NSInteger)rowKey;

/**
 * Asks the proxy data source to convert the column coordinate to the row key.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column in the data source.
 */
- (NSInteger)gridView:(NGridView *)gridView columnCoordinateByKey:(NSInteger)columnKey;

/**
 * Asks the proxy data source to return the general data source.
 * This data source is used as data provider to proxy data source.
 * See <NGridDataSource> protocol specifications.
 */
- (id<NGridDataSource>)dataSource;

/**
 * Asks the proxy data source to set general data source.
 * This data source is used as data provider to proxy data source.
 * See <NGridDataSource> protocol specifications.
 * @param dataSource Data source object.
 */
- (void)setDataSource:(id<NGridDataSource>)dataSource;

@optional

/**
 * Asks the proxy data source to return the cell union set.
 * @param gridView Related grid view object.
 */
- (NGridCellUnionSet *)cellUnionSetForGridView:(NGridView *)gridView;

/**
 * Asks the proxy data source whether selection is allowed in the grid view. Return YES to enable selection.
 * @param gridView Related grid view object.
 */
- (BOOL)gridViewCanSelectRowsAndColumns:(NGridView *)gridView;

#pragma mark - Expanders stuff 

/**
 * Asks the proxy data source to expand all rows in the grid view.
 * @param gridView Related grid view object.
 */
- (void)gridViewExpandAllRows:(NGridView *)gridView;

/**
 * Asks the proxy data source to collapse all rows in the grid view.
 * @param gridView Related grid view object.
 */
- (void)gridViewCollapseAllRows:(NGridView *)gridView;

/**
 * Asks the proxy data source to expand all columns in the grid view.
 * @param gridView Related grid view object.
 */
- (void)gridViewExpandAllColumns:(NGridView *)gridView;

/**
 * Asks the proxy data source to collapse all columns in the grid view.
 * @param gridView Related grid view object.
 */
- (void)gridViewCollapseAllColumns:(NGridView *)gridView;

/**
 * Asks the proxy data source to prepare data source to expand the row with a key.
 * @param gridView Related grid view object.
 * @param rowCoordinate Coordinate of the row to expand.
 */
- (void)gridView:(NGridView *)gridView expandRowWithCoordinate:(NSInteger)rowCoordinate;

/**
 * Asks the proxy data source to prepare data source to collapse the row with a key.
 * @param gridView Related grid view object.
 * @param rowCoordinate Coordinate of the row to collapse.
 */
- (void)gridView:(NGridView *)gridView collapseRowWithCoordinate:(NSInteger)rowCoordinate;

/**
 * Asks the proxy data source to prepare data source to expand the column with a key.
 * @param gridView Related grid view object.
 * @param columnCoordinate Coordinate of the column to expand.
 */
- (void)gridView:(NGridView *)gridView expandColumnWithCoordinate:(NSInteger)columnCoordinate;

/**
 * Asks the proxy data source to prepare data source to collapse the column with a key.
 * @param gridView Related grid view object.
 * @param columnCoordinate Coordinate of the column to collapse.
 */
- (void)gridView:(NGridView *)gridView collapseColumnWithCoordinate:(NSInteger)columnCoordinate;

/**
 * Asks the proxy data source if the row with key is expanded.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row.
 */
- (BOOL)gridView:(NGridView *)gridView isRowWithKeyExpanded:(NSInteger)rowKey;

/**
 * Asks the proxy data source if the column with key is expanded.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column.
 */
- (BOOL)gridView:(NGridView *)gridView isColumnWithKeyExpanded:(NSInteger)columnKey;

#pragma mark - Sparklines stuff

/**
 * Asks the proxy data source to return the row sparkline visibility.
 * @param gridView Related grid view object.
 */
- (BOOL)gridViewIsRowSparklinesShown:(NGridView *)gridView;

/**
 * Asks the proxy data source to return the column sparkline visibility.
 * @param gridView Related grid view object.
 */
- (BOOL)gridViewIsColumnSparklinesShown:(NGridView *)gridView;

/**
 * Asks the proxy data source to set the row sparkline visibility.
 * @param gridView Related grid view object.
 * @param isShown YES if you want to show the row sparklines.
 */
- (void)gridView:(NGridView *)gridView setRowSpartlinesShown:(BOOL)isShown;

/**
 * Asks the proxy data source to set the column sparkline visibility.
 * @param gridView Related grid view object.
 * @param isShown YES if you want to show the column sparklines.
 */
- (void)gridView:(NGridView *)gridView setColumnSpartlinesShown:(BOOL)isShown;

#pragma mark - Freezing stuff

/**
 * Asks the proxy data source to freeze the row by the key.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row to freeze.
 */
- (void)gridView:(NGridView *)gridView freezeRowWithKey:(NSInteger)rowKey;

/**
 * Asks the proxy data source to freeze the column by the key.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column to freeze.
 */
- (void)gridView:(NGridView *)gridView freezeColumnWithKey:(NSInteger)columnKey;

/**
 * Asks the proxy data source to freeze row by the key.
 * @param gridView Related grid view object.
 * @param rowKey Key of row to freeze.
 * @param index Specified the index of frozen row.
 */
- (void)gridView:(NGridView *)gridView freezeRowWithKey:(NSInteger)rowKey toIndex:(NSInteger)index;

/**
 * Asks the proxy data source to freeze column by the key.
 * @param gridView Related grid view object.
 * @param columnKey Key of column to freeze.
 * @param index Specified the index of frozen column.
 */
- (void)gridView:(NGridView *)gridView freezeColumnWithKey:(NSInteger)columnKey toIndex:(NSInteger)index;

/**
 * Asks the proxy data source to unfreeze the row by the key.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row to unfreeze.
 */
- (void)gridView:(NGridView *)gridView unfreezeRowWithKey:(NSInteger)rowKey;

/**
 * Asks the proxy data source to unfreeze the column by the key.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column to unfreeze.
 */
- (void)gridView:(NGridView *)gridView unfreezeColumnWithKey:(NSInteger)columnKey;

/**
 * Asks the proxy data source if the row with key is frozen.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row.
 */
- (BOOL)gridView:(NGridView *)gridView isRowWithKeyFrozen:(NSInteger)rowKey;

/**
 * Asks the proxy data source if the column with key is frozen.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column.
 */
- (BOOL)gridView:(NGridView *)gridView isColumnWithKeyFrozen:(NSInteger)columnKey;

/**
 * Asks the proxy data source to return the key of the frozen row.
 * @param gridView Related grid view object.
 * @param index Index of the frozen row.
 */
- (NSInteger)gridView:(NGridView *)gridView keyForFrozenRowWithIndex:(NSInteger)index;

/**
 * Asks the proxy data source to return the key of the frozen column.
 * @param gridView Related grid view object.
 * @param index Index of the frozen column.
 */
- (NSInteger)gridView:(NGridView *)gridView keyForFrozenColumnWithIndex:(NSInteger)index;

/**
 * Asks the proxy data source to return the number of the frozen row.
 * @param gridView Related grid view object.
 */
- (NSInteger)gridViewFrozenRowCount:(NGridView *)gridView;

/**
 * Asks the proxy data source to return the number of the frozen column.
 * @param gridView Related grid view object.
 */
- (NSInteger)gridViewFrozenColumnCount:(NGridView *)gridView;

#pragma mark - Sorting stuff

/**
 * Asks the proxy data source to set the sort settings.
 * @param gridView Related grid view object.
 * @param settings Sort settings.
 */
- (void)gridView:(NGridView *)gridView setSortSettings:(id<NGridSortSettingsProtocol>)settings;

/**
 * Asks the proxy data source to return the sort settings.
 * @param gridView Related grid view object.
 */
- (id<NGridSortSettingsProtocol>)gridViewSortSettings:(NGridView *)gridView;

/**
 * Asks the proxy data source to remove the sort settings.
 * @param gridView Related grid view object.
 */
- (void)gridViewRemoveSortSettings:(NGridView *)gridView;

#pragma mark - Filter stuff

/**
 * Asks the proxy data source to set the filter settings.
 * @param gridView Related grid view object.
 * @param settings Filter settings.
 */
- (void)gridView:(NGridView *)gridView setFilterSettings:(id<NGridFilterSettingsProtocol>)settings;

/**
 * Asks the proxy data source to return the filter settings.
 * @param gridView Related grid view object.
 */
- (id<NGridFilterSettingsProtocol>)gridViewFilterSettings:(NGridView *)gridView;

/**
 * Asks the proxy data source to remove the filter settings.
 * @param gridView Related grid view object.
 */
- (void)gridViewRemoveFilterSettings:(NGridView *)gridView;

#pragma mark - Highlight stuff

/**
 * Asks the proxy data source to set the highlight settings.
 * @param gridView Related grid view object.
 * @param settings Highlight settings.
 */
- (void)gridView:(NGridView *)gridView setHighlightSettings:(id<NGridHighlightSettingsProtocol>)settings;

/**
 * Asks the proxy data source to return the highlight settings.
 * @param gridView Related grid view object.
 */
- (id<NGridHighlightSettingsProtocol>)gridViewHighlightSettings:(NGridView *)gridView;

/**
 * Asks the proxy data source to remove the highlight settings.
 * @param gridView Related grid view object.
 */
- (void)gridViewRemoveHighlightSettings:(NGridView *)gridView;

/**
 * Sent to the proxy data source just before the grid view begins reloading data.
 * @param gridView Related grid view object.
 */
- (void)gridViewWillReloadData:(NGridView *)gridView;

/**
 * Sent to the proxy data source after the grid view reloads data.
 * @param gridView Related grid view object.
 */
- (void)gridViewDidReloadData:(NGridView *)gridView;

@end
