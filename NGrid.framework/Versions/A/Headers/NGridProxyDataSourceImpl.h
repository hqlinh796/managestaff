/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridProxyDataSourceImpl.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "NGridDataSource.h"
#import "NGridProxyDataSource.h"
#import "NGridProxyDataSourceImpl.h"
#import "NGridSortSettings.h"
#import "NGridFilterSettings.h"
#import "NGridHighlightSettings.h"
#import "NGridStyleManager.h"
#import "NGridScale.h"

/**
 * The NGridProxyDataSourceConsts defines constants used by proxy data source.
 */
typedef NS_ENUM(NSInteger, NGridProxyDataSourceConsts) {
    /**
     * Force proxy data source to ask sparkline data from the data source.
     */
    NGridProxyDataSourceSparklineRowKey = NSIntegerMax - 1,
    /**
     * Force proxy data source to ask sparkline data from the data source.
     */
    NGridProxyDataSourceSparklineColumnKey = NSIntegerMax - 1
};

/**
 * The NGridProxyDataSourceImpl class implements default functionality for <NGridProxyDataSource> protocol.
 */
@interface NGridProxyDataSourceImpl : NSObject <NGridProxyDataSource>

/**
 * Grid data source that provides data for the current proxy data source.
 */
@property (assign) id<NGridDataSource> dataSource;

/**
 * Image indicating ascending sort.
 */
@property (retain) UIImage *sortAscImage;

/**
 * Image indicating descending sort.
 */
@property (retain) UIImage *sortDescImage;

/**
 * Image indicating filter.
 */
@property (retain) UIImage *filterImage;

/**
 * Asks the proxy data source to return style manager.
 * Style manager used to set up styles in the grid.
 */
- (NGridStyleManager *)styleManager;

/**
 * Asks the proxy data source to perform filter operation and put remaining rows and columns 
 * into filteredRows and filteredColumns parameters.
 *
 * Proxy data source invokes this method to perform filtering.
 *
 * @param filteredRows Remaining after filtering rows.
 * @param filteredColumns Remaining after filtering columns.
 * @param gridView Related grid view object.
 * @param settings Filter settings.
 */
- (void)filteredRows:(NSMutableSet *)filteredRows
          andColumns:(NSMutableSet *)filteredColumns
          inGridView:(NGridView *)gridView
        withSettings:(id<NGridFilterSettingsProtocol>)settings;

/**
 * Asks the proxy data source to perform sort operation and put new rows and column sequences
 * into newRowSequence and newColumnSequence parameters.
 *
 * Proxy data source invokes this method to perform sorting.
 *
 * @param newRowSequence Rows sequence after sorting.
 * @param newColumnSequence Columns sequence after sorting.
 * @param gridView Related grid view object.
 * @param settings Sort settings.
 */
- (void)sortedRows:(NSMutableArray *)newRowSequence
        andColumns:(NSMutableArray *)newColumnSequence
        inGridView:(NGridView *)gridView
      withSettings:(id<NGridSortSettingsProtocol>)settings;

/**
 * Asks the proxy data source to find cells to highlight and put them into cellKeys parameter.
 *
 * Proxy data source invokes this method then highlight settings or data changed.
 *
 * @param cellKeys Keys of highlighted cells.
 * @param gridView Related grid view object.
 * @param settings Highlight settings.
 */
- (void)highlightedCellKeys:(NSMutableSet *)cellKeys
                 inGridView:(NGridView *)gridView
               withSettings:(id<NGridHighlightSettingsProtocol>)settings;

/**
 * Asks the proxy data source to set conditional formatting for the specified cell
 * and return result as value scale.
 *
 * @param cellKey Key of the cell.
 * @param gridView Related grid view object.
 * @param settings Conditional formatting settings.
 */
- (id<NGridScale>)conditionalFormattingScaleCellWithKey:(NGridCellKey *)cellKey
                                             inGridView:(NGridView *)gridView
               withSettings:(id<NGridConditionalFormattingSettingsProtocol>)settings;

/**
 * Asks the proxy data source to apply concrete conditional formatting rule to the specified cell.
 *
 * @param rule Conditional formatting rule.
 * @param cell Cell that needs to be configured.
 */
- (void)applyConditionalFormattingRule:(id<NGridConditionalFormattingRuleProtocol>)rule toCell:(NGridCell *)cell;

@end
