/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridSelectionArea.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridSelectionDelegate.h"
#import "NGridSelectionStyle.h"

/**
 * Options to specify the area type of the selection.
 */
typedef NS_ENUM(NSInteger, NGridSelectionAreaType) {
    /**
     * No type. If selection has no type it may be the arbitrary user selection.
     * Otherwise it is not showed.
     */
    NGridSelectionAreaTypeNone,
    
    /**
     * Selection area is used only for one row.
     */
    NGridSelectionAreaTypeRow,
    
    /**
     * Selection area is used only for one column.
     */
    NGridSelectionAreaTypeColumn
};

@class NGridView;
@class NGridSelectionArea;
@class NGridRow;
@class NGridColumn;

/**
 * The NGridSelectionArea class provides attributes and behavior for the grid selection.
 */
@interface NGridSelectionArea : UIView

/**
 * The object acts as selection delegate.
 */
@property (nonatomic, assign) id<NGridSelectionDelegate> delegate;

/**
 * Related grid.
 */
@property (nonatomic, assign) NGridView *parentGrid;

/**
 * Type of the selection.
 */
@property (assign) NGridSelectionAreaType type;

/**
 * Key of the selected row or column.
 */
@property (assign) NSInteger elementKey;

/**
 * Style of the selection.
 */
@property (readonly) NGridSelectionStyle *style;

/**
 * Creates selection area.
 * @param gridView Related grid view object.
 * @param style Style for selection area.
 * @param delegate Selection delegate.
 */
+ (NGridSelectionArea *)createSelectionAreaForGrid:(NGridView *)gridView
                                          withStyle:(NGridSelectionStyle *)style
                                       withDelegate:(id<NGridSelectionDelegate>)delegate;

/**
 * Shows balloons on the edges of the selection area.
 */
- (void)showBalloons;

/**
 * Hides balloons on the edges of the selection area.
 */
- (void)hideBalloons;

/**
 * Checks if selection area is empty.
 */
- (BOOL)isEmpty;

/**
 * Return all currently selected rows.
 */
- (NSArray *)selectedRows;

/**
 * Return all currently selected columns.
 */
- (NSArray *)selectedColumns;

@end
