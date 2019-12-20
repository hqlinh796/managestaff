/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridView.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridProxyDataSource.h"
#import "NGridDelegate.h"
#import "NGridTouchDelegate.h"
#import "NGridCell.h"
#import "NGridRow.h"
#import "NGridColumn.h"
#import "NGridCellCoordinate.h"
#import "NGridSelectionArea.h"
#import "NGridSelectionStyle.h"
#import "NGridResizerStyle.h"
#import "NGridAutoresizeSettings.h"

@class NGridResizerArea;

/**
 * The NGridView class represents the main grid view you need to embed in your user interface.
 *
 * Grid view supports:
 *
 *  - multidimensional data sets;
 *  - data interaction;
 *  - themes and color customization;
 *  - selection;
 *  - column and row freezing;
 *  - column and row resizing;
 *  - data sort and filtering;
 *  - conditional formatting and growth indicators;
 *  - sparklines.
 */
@interface NGridView : UIScrollView <UIScrollViewDelegate, NGridTouchDelegate, NGridSelectionDelegate>

/**
 * License key for NGrid. You get it in email when download NGrid framework.
 *
 * License key must be set before using the NGrid.
 */
@property (nonatomic, retain) NSString *licenseKey;

/**
 * Object used as the data source of the grid.
 */
@property (nonatomic, assign) id<NGridDataSource> dataSource;

/**
 * Proxy data source used to manage data from the data source.
 *
 * Proxy data source responsible for sorting, filtering, highlighting etc.
 * Data source (<NGridDataSource>) must be set in proxy.
 */
@property (nonatomic, assign) id<NGridProxyDataSource> proxyDataSource;

/**
 * Grid delegate used to manage grid appearance and user interactions.
 */
@property (nonatomic, assign) id<NGridDelegate> delegate;

/**
 * Resizer object.
 */
@property (nonatomic, readonly) NGridResizerArea *resizer;

/**
 * A Boolean value that determines whether the multiselect mode is ON.
 *
 * In multiselect mode you can only selecting rows/columns by calling
 * <selectRowByCell:> (<selectRowByKey:>) or <selectColumnByCell:> (<selectColumnByKey:>).
 */
@property (assign, getter = isMultiselect) BOOL multiselect;

/**
 * A Boolean value that determines whether docking is enabled.
 *
 * If set to YES, grid view docks to nearest top/left row/column after scrolling.
 */
@property (assign) BOOL dockable;

/**
 * Color of the separator between frozen and not frozen rows.
 */
@property (nonatomic, retain) UIColor *lastFrozenRowBorderColor;

/**
 * Width of the separator between frozen and not frozen rows.
 */
@property (nonatomic, assign) CGFloat lastFrozenRowBorderWidth;

/**
 * Color of the separator between frozen and not frozen columns.
 */
@property (nonatomic, retain) UIColor *lastFrozenColumnBorderColor;

/**
 * Width of the separator between frozen and not frozen columns.
 */
@property (nonatomic, assign) CGFloat lastFrozenColumnBorderWidth;

/**
 * A Boolean value that determines whether the selection keeps by indices.
 *
 * If property set to YES then after data source update the selections stays in place,
 * otherwise selection changes according to data source changes.
 */
@property (assign) BOOL keepSelectionByIndex;

/**
 * Style specifying the appearance of the grid selection.
 */
@property (retain) NGridSelectionStyle *selectionStyle;

/**
 * Style specifying the appearance of the grid resizer.
 */
@property (retain) NGridResizerStyle *resizerStyle;

/**
 * A Boolean value that determines whether content width adapts to frame width.
 */
@property (assign) BOOL autoresizeToFitGridFrameWidth;

/**
 * A Boolean value that determines whether content height adapts to frame height.
 */
@property (assign) BOOL autoresizeToFitGridFrameHeight;

/**
 * A Boolean value that determines whether grid should finalize editing on reload data.
 */
@property (assign) BOOL finishEditingOnReloadData;

/**
 * Requests reusable cell with reusable id.
 * @param ID This id used for search cells in cache.
 */
- (NGridCell *)dequeueReusableCellWithIdentifier:(NSString *)ID;

/**
 * Returns specified row object.
 * @param rowKey Key of the row.
 */
- (NGridRow *)rowWithKey:(NSInteger)rowKey;

/**
 * Returns specified column object.
 * @param columnKey Key of the column.
 */
- (NGridColumn *)columnWithKey:(NSInteger)columnKey;

/**
 * Returns specified header row object.
 * @param rowKey Key of the row.
 */
- (NGridRow *)headerRowWithKey:(NSInteger)rowKey;

/**
 * Returns specified header column object.
 * @param columnKey Key of the column.
 */
- (NGridColumn *)headerColumnWithKey:(NSInteger)columnKey;

/**
 * Returns specified cell.
 * @param cellKey Key of the cell.
 */
- (NGridCell *)cellWithKey:(NGridCellKey *)cellKey;

/**
 * Updates grid after data source update.
 */
- (void)reloadData;

/**
 * Scrolls current view rect to the grid point.
 * @param coordinate Coordinate of the grid view.
 * @param animated YES if you want to animate changing of the grid view position.
 */
- (void)showCellWithCoordinate:(NGridCellCoordinate *)coordinate animated:(BOOL)animated;

/**
 * Returns selection area of the specified row.
 * @param rowKey Key of the row.
 */
- (NGridSelectionArea *)selectionAreaForRowWithKey:(NSInteger)rowKey;

/**
 * Returns selection area of the specified column.
 * @param columnKey Key of the column.
 */
- (NGridSelectionArea *)selectionAreaForColumnWithKey:(NSInteger)columnKey;

/**
 * Starts resizing based on the cell.
 * @param cell Cell in the grid view.
 */
- (void)beginResizeWithCell:(NGridCell *)cell;

/**
 * Starts column resizing based on the cell.
 * @param cell Corner cell in the grid view.
 */
- (void)beginResizeColumnWithCornerCell:(NGridCell *)cell;

/**
 * Starts row resizing based on the cell.
 * @param cell Corner cell in the grid view.
 */
- (void)beginResizeRowWithCornerCell:(NGridCell *)cell;

/**
 * Finishes resizing.
 */
- (void)finishResize;

/**
 * Inserts the rows with the specified keys.
 * @param keys The keys of the new rows to be inserted.
 */
- (void)insertRowsWithKeys:(NSArray *)keys;

/**
 * Removes the rows with the specified keys.
 * @param keys An array containing the row keys to remove.
 */
- (void)removeRowsWithKeys:(NSArray *)keys;

/**
 * Inserts the columns with the specified keys.
 * @param keys The keys of the new rows to be inserted.
 */
- (void)insertColumnsWithKeys:(NSArray *)keys;

/**
 * Removes the columns with the specified keys.
 * @param keys An array containing the column keys to remove.
 */
- (void)removeColumnsWithKeys:(NSArray *)keys;

/**
 * Begin a series of method calls that change data source state.
 */
- (void)beginUpdates;

/**
 * Conclude a series of method calls that change data source state.
 */
- (void)endUpdates;

#pragma mark - Expanders stuff

/**
 * A Boolean value indicating whether the grid view allows the user to expand/collapse columns or rows using expander icon.
 */
@property (assign) BOOL expandUsingExpanderIcon;

/**
 * Expands all rows in the grid view.
 */
- (void)expandAllRows;

/**
 * Collapses all rows in the grid view.
 */
- (void)collapseAllRows;

/**
 * Expands all columns in the grid view.
 */
- (void)expandAllColumns;

/**
 * Collapses all columns in the grid view.
 */
- (void)collapseAllColumns;

/**
 * Prepares data source to expand the row with key.
 * @param rowCoordinate Coordinate of the row to expand.
 */
- (void)expandRowWithCoordinate:(NSInteger)rowCoordinate;

/**
 * Collapses the row with key.
 * @param rowCoordinate Coordinate of the row to collapse.
 */
- (void)collapseRowWithCoordinate:(NSInteger)rowCoordinate;

/**
 * Expands the column with key.
 * @param columnCoordinate Coordinate of the column to expand.
 */
- (void)expandColumnWithCoordinate:(NSInteger)columnCoordinate;

/**
 * Collapses the column with key.
 * @param columnCoordinate Coordinate of the column to collapse.
 */
- (void)collapseColumnWithCoordinate:(NSInteger)columnCoordinate;

/**
 * Returns a Boolean value indicating whether the row is expanded.
 * @param rowKey Key of the row.
 */
- (BOOL)isRowWithKeyExpanded:(NSInteger)rowKey;

/**
 * Returns a Boolean value indicating whether the column is expanded.
 * @param columnKey Key of the column.
 */
- (BOOL)isColumnWithKeyExpanded:(NSInteger)columnKey;

#pragma mark - Sparklines stuff

/**
 * Returns the row sparkline visibility.
 */
- (BOOL)isRowSparklinesShown;

/**
 * Returns the column sparkline visibility.
 */
- (BOOL)isColumnSparklinesShown;

/**
 * Sets the row sparkline visibility.
 * @param isShown YES if you want to show the row sparklines.
 */
- (void)setRowSparklinesShown:(BOOL)isShown;

/**
 * Sets the column sparkline visibility.
 * @param isShown YES if you want to show the column sparklines.
 */
- (void)setColumnSparklinesShown:(BOOL)isShown;

#pragma mark - Freezing stuff

/**
 * Returns a Boolean value indicating whether the specified row can be freezed.
 * @param rowKey Key of the row to freeze.
 */
- (BOOL)isRowCanBeFreezed:(NSInteger)rowKey;

/**
 * Returns a Boolean value indicating whether the specified column can be freezed.
 * @param columnKey Key of the column to freeze.
 */
- (BOOL)isColumnCanBeFreezed:(NSInteger)columnKey;

/**
 * Freezes row by key.
 * @param rowKey Key of the row to freeze.
 */
- (void)freezeRowWithKey:(NSInteger)rowKey;

/**
 * Freezes column by key.
 * @param columnKey Key of the column to freeze.
 */
- (void)freezeColumnWithKey:(NSInteger)columnKey;

/**
 * Freezes row by key.
 * @param rowKey Key of the row to freeze.
 * @param index Specified the index of frozen row.
 */
- (void)freezeRowWithKey:(NSInteger)rowKey toIndex:(NSInteger)index;

/**
 * Freezes column by key.
 * @param columnKey Key of the column to freeze.
 * @param index Specified the index of frozen column.
 */
- (void)freezeColumnWithKey:(NSInteger)columnKey toIndex:(NSInteger)index;

/**
 * Unfreezes row by key.
 * @param rowKey Key of the row to unfreeze.
 */
- (void)unfreezeRowWithKey:(NSInteger)rowKey;

/**
 * Unfreezes column by key.
 * @param columnKey Key of the column to unfreeze.
 */
- (void)unfreezeColumnWithKey:(NSInteger)columnKey;

/**
 * Checks if the row with key is frozen.
 * @param rowKey Key of the row.
 */
- (BOOL)isRowWithKeyFrozen:(NSInteger)rowKey;

/**
 * Checks if the column with key is frozen.
 * @param columnKey Key of the column.
 */
- (BOOL)isColumnWithKeyFrozen:(NSInteger)columnKey;

#pragma mark - Sort stuff

/**
 * Sets the sort settings.
 * @param settings Sort settings.
 */
- (void)setSortSettings:(id<NGridSortSettingsProtocol>)settings;

/**
 * Returns the sort settings.
 */
- (id<NGridSortSettingsProtocol>)sortSettings;

/**
 * Removes the sort settings.
 */
- (void)removeSortSettings;

#pragma mark - Filter stuff

/**
 * Sets the filter settings.
 * @param settings Filter settings.
 */
- (void)setFilterSettings:(id<NGridFilterSettingsProtocol>)settings;

/**
 * Returns the filter settings.
 */
- (id<NGridFilterSettingsProtocol>)filterSettings;

/**
 * Removes the filter settings.
 */
- (void)removeFilterSettings;

#pragma mark - Highlight stuff

/**
 * Sets the highlight settings.
 * @param settings Highlight settings.
 */
- (void)setHighlightSettings:(id<NGridHighlightSettingsProtocol>)settings;

/**
 * Returns the highlight settings.
 */
- (id<NGridHighlightSettingsProtocol>)highlightSettings;

/**
 * Removes the highlight settings.
 */
- (void)removeHighlightSettings;

#pragma mark - Selection stuff

/**
 * A Boolean value that determines whether the selection areas should pass all touches through except touches on balloons.
 */
@property (assign) BOOL selectionAreaShouldPassTouchesThrough;

/**
 * Clears current selection.
 */
- (void)clearSelection;

/**
 * Selects all cells in the grid view.
 */
- (void)selectAll;

/**
 * Selects all cells in the row with key.
 * @param rowKey Key of the row to select.
 */
- (void)selectRowWithKey:(NSInteger)rowKey;

/**
 * Selects all cells in the column with key.
 * @param columnKey Key of the column to select.
 */
- (void)selectColumnWithKey:(NSInteger)columnKey;

/**
 * Selects specified cell.
 * @param cellKey Key of the cell to select.
 */
- (void)selectCellWithKey:(NGridCellKey *)cellKey;

/**
 * Checks row for selection.
 * @param rowKey Key of the row to test for selection.
 */
- (BOOL)isRowWithKeySelected:(NSInteger)rowKey;

/**
 * Checks column for selection.
 * @param columnKey Key of the column to test for selection.
 */
- (BOOL)isColumnWithKeySelected:(NSInteger)columnKey;

/**
 * Deselects row with key.
 * @param rowKey Key of the row to deselect.
 */
- (void)deselectRowWithKey:(NSInteger)rowKey;

/**
 * Deselects column with key.
 * @param columnKey Key of the column to deselect.
 */
- (void)deselectColumnWithKey:(NSInteger)columnKey;

/**
 * Return all currently selected rows.
 */
- (NSSet *)selectedRows;

/**
 * Return all currently selected columns.
 */
- (NSSet *)selectedColumns;

/**
 * Deselects rows and columns from arrays.
 * @param rows Array with the row keys.
 * @param columns Array with the column keys.
 */
- (void)deselectRows:(NSArray *)rows andColumns:(NSArray *)columns;

#pragma mark - Editing stuff

/**
 * Starts editing the specified cell.
 * @param cellKey Key of the cell.
 */
- (void)beginEditingCellWithKey:(NGridCellKey *)cellKey;

/**
 * Finishes editing.
 */
- (void)finishEditing;

#pragma mark - Auto-resizing stuff

/**
 * Resizes all rows and columns to fit content.
 */
- (void)resizeToFitContent;

/**
 * Resizes rows and columns to fit content based on specified settings.
 * @param settings Resize settings.
 */
- (void)resizeToFitContentUsingSettings:(NGridAutoresizeSettings *)settings;

@end
