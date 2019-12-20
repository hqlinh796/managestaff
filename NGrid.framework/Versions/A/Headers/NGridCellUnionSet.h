/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellUnionSet.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridCellUnion.h"

/**
 * The NGridCellUnionSet class is used as a smart container for unions.
 */
@interface NGridCellUnionSet : NSObject

/**
 * Adds <NGridCellUnion> object to the set.
 * @param cellUnion Union object.
 */
- (void)addUnion:(NGridCellUnion *)cellUnion;

/**
 * Removes <NGridCellUnion> object from the set.
 * @param cellUnion Union object.
 */
- (void)removeUnion:(NGridCellUnion *)cellUnion;

/**
 * Returns all unions in the set.
 */
- (NSArray *)allUnions;

/**
 * Retrieves unions which contain cell key as included key.
 * @param cellKey Key of the cell included to union.
 */
- (NGridCellUnion *)unionWithUnitedCellKey:(NGridCellKey *)cellKey;

/**
 * Retrieves unions which contain cell key as primary key.
 * @param cellKey Key of the primary cell.
 */
- (NGridCellUnion *)unionWithPrimaryCellKey:(NGridCellKey *)cellKey;

@end
