/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridStyleLevel.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridCellStyle.h"
#import "NGridCellKey.h"

/**
 * The NGridStyleLevel class stores grid styles.
 */
@interface NGridStyleLevel : NSObject <NSCoding>

/**
 * Sets style for cell.
 * @param style Style of the grid.
 * @param cellKey Key of the cell.
 */
- (void)setStyle:(NGridCellStyle *)style forCellWithKey:(NGridCellKey *)cellKey;

/**
 * Sets style for row.
 * @param style Style of the grid.
 * @param rowKey Key of the row.
 */
- (void)setStyle:(NGridCellStyle *)style forRow:(NSInteger)rowKey;

/**
 * Sets style for column.
 * @param style Style of the grid.
 * @param columnKey Key of the column.
 */
- (void)setStyle:(NGridCellStyle *)style forColumn:(NSInteger)columnKey;

/**
 * Sets style for header of row.
 * @param style Style of the grid.
 * @param rowKey Key of the row.
 */
- (void)setStyle:(NGridCellStyle *)style forHeaderForRow:(NSInteger)rowKey;

/**
 * Sets style for row header column.
 * @param style Style of the grid.
 * @param columnKey Key of the column.
 */
- (void)setStyle:(NGridCellStyle *)style forRowHeaderColumn:(NSInteger)columnKey;

/**
 * Sets style for corner header column.
 * @param style Style of the grid.
 * @param columnKey Key of the column.
 */
- (void)setStyle:(NGridCellStyle *)style forCornerHeaderColumn:(NSInteger)columnKey;

/**
 * Sets style for header of column.
 * @param style Style of the grid.
 * @param columnKey Key of the column.
 */
- (void)setStyle:(NGridCellStyle *)style forHeaderForColumn:(NSInteger)columnKey;

/**
 * Sets style for column header row.
 * @param style Style of the grid.
 * @param rowKey Key of the row.
 */
- (void)setStyle:(NGridCellStyle *)style forColumnHeaderRow:(NSInteger)rowKey;

/**
 * Sets style for corner header row.
 * @param style Style of the grid.
 * @param rowKey Key of the row.
 */
- (void)setStyle:(NGridCellStyle *)style forCornerHeaderRow:(NSInteger)rowKey;

/**
 * Sets default style.
 * @param style Style of the grid.
 */
- (void)setDefaultStyle:(NGridCellStyle *)style;

/**
 * Sets default row header style.
 * @param style Style of the grid.
 */
- (void)setDefaultStyleForRowHeader:(NGridCellStyle *)style;

/**
 * Sets default column header style.
 * @param style Style of the grid.
 */
- (void)setDefaultStyleForColumnHeader:(NGridCellStyle *)style;

/**
 * Sets default corner header style.
 * @param style Style of the grid.
 */
- (void)setDefaultStyleForCornerHeader:(NGridCellStyle *)style;

/**
 * Returns style of the cell.
 * @param cellKey Key of the cell.
 */
- (NGridCellStyle *)styleForCellWithKey:(NGridCellKey *)cellKey;

/**
 * Returns style of the row.
 * @param rowKey Key of the row.
 */
- (NGridCellStyle *)styleForRow:(NSInteger)rowKey;

/**
 * Returns style of the column.
 * @param columnKey Key of the column.
 */
- (NGridCellStyle *)styleForColumn:(NSInteger)columnKey;

/**
 * Returns style of header of the row.
 * @param rowKey Key of the row.
 */
- (NGridCellStyle *)styleForHeaderForRow:(NSInteger)rowKey;

/**
 * Returns style of the row header column.
 * @param columnKey Key of the column.
 */
- (NGridCellStyle *)styleForRowHeaderColumn:(NSInteger)columnKey;

/**
 * Returns style of the corner header column.
 * @param columnKey Key of the column.
 */
- (NGridCellStyle *)styleForCornerHeaderColumn:(NSInteger)columnKey;

/**
 * Returns style of header of the column.
 * @param columnKey Key of the column.
 */
- (NGridCellStyle *)styleForHeaderForColumn:(NSInteger)columnKey;

/**
 * Returns style of the column header row.
 * @param rowKey Key of the row.
 */
- (NGridCellStyle *)styleForColumnHeaderRow:(NSInteger)rowKey;

/**
 * Returns style of the corner header row.
 * @param rowKey Key of the row.
 */
- (NGridCellStyle *)styleForCornerHeaderRow:(NSInteger)rowKey;

/**
 * Returns default style.
 */
- (NGridCellStyle *)defaultStyle;

/**
 * Returns default style of the row header.
 */
- (NGridCellStyle *)defaultStyleForRowHeader;

/**
 * Returns default style of the column header.
 */
- (NGridCellStyle *)defaultStyleForColumnHeader;

/**
 * Returns default style of the corner header.
 */
- (NGridCellStyle *)defaultStyleForCornerHeader;

/**
 * Removes style of the cell.
 * @param cellKey Key of the cell.
 */
- (void)removeStyleForCellWithKey:(NGridCellKey *)cellKey;

/**
 * Removes style of the row.
 * @param rowKey Key of the row.
 */
- (void)removeStyleForRow:(NSInteger)rowKey;

/**
 * Removes style of the column.
 * @param columnKey Key of the column.
 */
- (void)removeStyleForColumn:(NSInteger)columnKey;

/**
 * Removes style of header of the row.
 * @param rowKey Key of the row.
 */
- (void)removeStyleForHeaderForRow:(NSInteger)rowKey;

/**
 * Removes style of the row header column.
 * @param columnKey Key of the column.
 */
- (void)removeStyleForRowHeaderColumn:(NSInteger)columnKey;

/**
 * Removes style of the corner header column.
 * @param columnKey Key of the column.
 */
- (void)removeStyleForCornerHeaderColumn:(NSInteger)columnKey;

/**
 * Removes style of header of the column.
 * @param columnKey Key of the column.
 */
- (void)removeStyleForHeaderForColumn:(NSInteger)columnKey;

/**
 * Removes style of the column header row.
 * @param rowKey Key of the row.
 */
- (void)removeStyleForColumnHeaderRow:(NSInteger)rowKey;

/**
 * Removes style of the corner header row.
 * @param rowKey Key of the row.
 */
- (void)removeStyleForCornerHeaderRow:(NSInteger)rowKey;

/**
 * Removes default style.
 */
- (void)removeDefaultStyle;

/**
 * Removes default style of the row header.
 */
- (void)removeDefaultStyleForRowHeader;

/**
 * Removes default style of the column header.
 */
- (void)removeDefaultStyleForColumnHeader;

/**
 * Removes default style of the corner header.
 */
- (void)removeDefaultStyleForCornerHeader;

/**
 * Returns assembled style for the cell.
 * This method finds all appropriate styles for the cell and merges them into result style.
 * @param cellKey Key of the cell.
 */
- (NGridCellStyle *)assembledStyleForCellWithKey:(NGridCellKey *)cellKey;

/**
 * Returns all styles in the level.
 */
- (NSArray *)allStyles;

/**
 * Removes all styles from the level.
 */
- (void)removeAllStyles;

@end
