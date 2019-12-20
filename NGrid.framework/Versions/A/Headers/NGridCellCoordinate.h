/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellCoordinate.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridCellType.h"

/**
 * The NGridCellCoordinate class represents cell coordinate and defines a place of the cell in the grid.
 * The coordinate includes type, row component and column component.
 */
@interface NGridCellCoordinate : NSObject <NSCopying>

/**
 * Type of coordinate.
 */
@property (readonly) NGridCellType type;

/**
 * Row component of the coordinate.
 */
@property (readonly) NSInteger rowCoordinate;

/**
 * Column component of the coordinate.
 */
@property (readonly) NSInteger columnCoordinate;

/**
 * Creates cell coordinate object.
 * @param type Type of the cell coordinate.
 * @param rowCoordinate Row component of the cell coordinate.
 * @param columnCoordinate Column component of the cell coordinate.
 */
+ (NGridCellCoordinate *)coordinateForCellWithType:(NGridCellType)type
                                      rowCoordinate:(NSInteger)rowCoordinate
                                   columnCoordinate:(NSInteger)columnCoordinate;

@end
