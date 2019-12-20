/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellUnion.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridCellKey.h"

/**
 * The NGridCellUnion class is used to define cell unions. 
 * Cell unions include:
 * <ul>
 * <li>Primary cell – this cell stretches over the other cells in the union and should be the top left cell.</li>
 * <li>United cells – grid does not display these cells but they define the rectangle for the primary cell.</li>
 * </ul>
 */
@interface NGridCellUnion : NSObject

/**
 * Primary cell key.
 *
 * Primary cell key is the key of top left cell that stretch over the other united cells.
 */
@property (readonly) NGridCellKey *primaryCellKey;

/**
 * Array of the cell keys included in this union.
 */
@property (readonly) NSArray *unitedCellKeys;

/**
 * Array of the row keys included in this union.
 */
@property (readonly) NSArray *unitedRowKeys;

/**
 * Array of the column keys included in this union.
 */
@property (readonly) NSArray *unitedColumnKeys;

/**
 * Creates union object.
 * @param cellKey Key of the primary cell for this union.
 * @param cellKeys Array with the cell keys included in this union.
 * @note Cell keys order is significant in some cases. You should list cell keys in sequence
 * when rows go in ascending order and columns in each rows go in ascending order too.
 */
+ (NGridCellUnion *)unionForCell:(NGridCellKey *)cellKey unitedWith:(NSArray *)cellKeys;

@end
