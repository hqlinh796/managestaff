/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridDelegate.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>

#import "NGridCellKey.h"
#import "NGridCellEditorBase.h"

@class NGridView;
@class NGridCell;
@class NGridRow;
@class NGridColumn;
@class NGridSelectionArea;

/**
 * The NGridDelegate protocol defines methods that should be implemented to provide the appearance and behavior of the grid.
 */
@protocol NGridDelegate <UIScrollViewDelegate>

/**
 * Asks the delegate to return width of the column.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column.
 */
- (CGFloat)gridView:(NGridView *)gridView widthForColumnWithKey:(NSInteger)columnKey;

/**
 * Asks the delegate to return height of the column.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row.
 */
- (CGFloat)gridView:(NGridView *)gridView heightForRowWithKey:(NSInteger)rowKey;

@optional

/**
 * Asks the delegate to return width of the row header.
 * @param gridView Related grid view object.
 * @param key Key of the row header.
 */
- (CGFloat)gridView:(NGridView *)gridView widthForHeaderRowWithKey:(NSInteger)key;

/**
 * Asks the delegate to return height of the column header.
 * @param gridView Related grid view object.
 * @param key Key of the column header.
 */
- (CGFloat)gridView:(NGridView *)gridView heightForHeaderColumnWithKey:(NSInteger)key;

/**
 * Asks the delegate whether the grid view should highlight the cell on touch. Return YES if the cell should be highlighted on touch.
 * @param gridView Related grid view object.
 * @param cell Cell object to test if the cell should be highlighted on touch down.
 */
- (BOOL)gridView:(NGridView *)gridView cellShouldHighlightOnTouchDown:(NGridCell *)cell;

/**
 * Asks the delegate whether grid view should highlight cell on touch of the expander. Return YES if cell should be highlighted on the touch of the expander.
 * @param gridView Related grid view object.
 * @param cell Cell object to test if the cell should be highlighted on touch down on the expander.
 */
- (BOOL)gridView:(NGridView *)gridView cellShouldHighlightOnExpanderTouchDown:(NGridCell *)cell;

/**
 * Asks the delegate to change the width of the cell in the grid view.
 * @param gridView Related grid view object.
 * @param newWidth New width of the cell column.
 * @param key Key of the column.
 */
- (void)gridView:(NGridView *)gridView widthChangeNeeded:(CGFloat)newWidth forColumnWithKey:(NSInteger)key;

/**
 * Asks the delegate to change the height of the cell in the grid view.
 * @param gridView Related grid view object.
 * @param newHeight New height of the cell row.
 * @param key Key of the row.
 */
- (void)gridView:(NGridView *)gridView heightChangeNeeded:(CGFloat)newHeight forRowWithKey:(NSInteger)key;

/**
 * Asks the delegate to change the width of the cell in the grid view.
 * @param gridView Related grid view object.
 * @param newWidth New width of the cell column.
 * @param key Key of the column from row headers.
 */
- (void)gridView:(NGridView *)gridView widthChangeNeeded:(CGFloat)newWidth forRowHeaderWithKey:(NSInteger)key;

/**
 * Asks the delegate to change the height of the cell in the grid view.
 * @param gridView Related grid view object.
 * @param newHeight New height of the cell row.
 * @param key Key of the row from column headers.
 */
- (void)gridView:(NGridView *)gridView heightChangeNeeded:(CGFloat)newHeight forColumnHeaderWithKey:(NSInteger)key;


/**
 * Called before the start of data source updating in the grid view.
 * @param gridView Related grid view object.
 */
- (void)gridViewWillUpdate:(NGridView *)gridView;

/**
 * Called after the end of data source updating in the grid view.
 * @param gridView Related grid view object.
 */
- (void)gridViewDidUpdate:(NGridView *)gridView;

/**
 * Called before layouting in the grid view.
 * @param gridView Related grid view object.
 */
- (void)gridViewWillLayout:(NGridView *)gridView;

/**
 * Called after layouting in the grid view.
 * @param gridView Related grid view object.
 */
- (void)gridViewDidLayout:(NGridView *)gridView;

/**
 * Called after touch in the cell of the grid view.
 * @param gridView Related grid view object.
 * @param cell Cell which was touched.
 */
- (void)gridView:(NGridView *)gridView didTapCell:(NGridCell *)cell;

/**
 * Called after double tap in the cell of the grid view.
 * @param gridView Related grid view object.
 * @param cell Cell which was touched.
 */
- (void)gridView:(NGridView *)gridView didDoubleTapCell:(NGridCell *)cell;

/**
 * Called after long tap in the cell of the grid view and only if selection is off.
 * @param gridView Related grid view object.
 * @param cell Cell which was touched.
 */
- (void)gridView:(NGridView *)gridView didLongTapCell:(NGridCell *)cell;

/**
 * Called after selection changes in the grid view.
 * @param gridView Related grid view object.
 */
- (void)gridViewDidChangeSelection:(NGridView *)gridView;

/**
 * Called after the area was selected in the grid view.
 * @param gridView Related grid view object.
 * @param area Selection area identify selected cells.
 */
- (void)gridView:(NGridView *)gridView didSelectArea:(NGridSelectionArea *)area;

/**
 * Called before the row with number rowKey was selected in the grid view.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row.
 */
- (void)gridView:(NGridView *)gridView willSelectRowWithKey:(NSInteger)rowKey;

/**
 * Called before the column with number columnKey was selected in the grid view.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column.
 */
- (void)gridView:(NGridView *)gridView willSelectColumnWithKey:(NSInteger)columnKey;

/**
 * Called after the row with number rowKey was selected in the grid view.
 * @param gridView Related grid view object.
 * @param rowKey Key of the row.
 */
- (void)gridView:(NGridView *)gridView didSelectRowWithKey:(NSInteger)rowKey;

/**
 * Called after the column with number columnKey was selected in the grid view.
 * @param gridView Related grid view object.
 * @param columnKey Key of the column.
 */
- (void)gridView:(NGridView *)gridView didSelectColumnWithKey:(NSInteger)columnKey;

/**
 * Called before the grid view frame changed.
 * @param gridView Related gridView.
 * @param fromFrame Frame before change (current frame).
 * @param toFrame Frame after change.
 */
- (void)gridView:(NGridView *)gridView willChangeFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame;

/**
 * Called after the grid view frame changed.
 * @param gridView Related gridView.
 * @param fromFrame Frame before change.
 * @param toFrame Frame after change (current frame).
 */
- (void)gridView:(NGridView *)gridView didChangeFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame;

/**
 * Called if touch in the selection area is caught.
 * @param gridView Related gridView.
 * @param selectionArea Selection area.
 */
- (void)gridView:(NGridView *)gridView didTapSelectionArea:(NGridSelectionArea *)selectionArea;

/**
 * Asks the delegate whether the grid view should use an external editor.
 * @param gridView Related gridView.
 * @param cellKey Key of the cell.
 */
- (BOOL)gridView:(NGridView *)gridView shouldUseExternalEditorForCellWithKey:(NGridCellKey *)cellKey;

/**
 * Asks the delegate to return editor for the specified cell.
 * @param gridView Related gridView.
 * @param cellKey Key of the cell.
 */
- (NGridCellEditorBase *)gridView:(NGridView *)gridView editorForCellWithKey:(NGridCellKey *)cellKey;

/**
 * Called before the grid view is about to go into editing mode.
 * @param gridView Related gridView.
 * @param cellKey Key of the cell.
 */
- (void)gridView:(NGridView *)gridView willBeginEditingCellWithKey:(NGridCellKey *)cellKey;

/**
 * Called after the grid view has left editing mode.
 * @param gridView Related gridView.
 * @param cellKey Key of the cell.
 */
- (void)gridView:(NGridView *)gridView didFinishEditingCellWithKey:(NGridCellKey *)cellKey;

@end
