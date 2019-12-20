/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellKey.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridCellType.h"

/**
 * The NGridCellKey class represents cell key and defines position of the cell in the data source.
 * The key includes type, row component and column component.
 */
@interface NGridCellKey : NSObject <NSCopying>

/**
 * Key type.
 */
@property (readonly) NGridCellType type;

/**
 * Row component of the key.
 */
@property (readonly) NSInteger rowKey;

/**
 * Column component of the key.
 */
@property (readonly) NSInteger columnKey;

/**
 * Creates the cell key object.
 * @param type Type of the cell key.
 * @param rowKey Row component of the cell key.
 * @param columnKey Column component of the cell key.
 */
+ (NGridCellKey *)keyForCellWithType:(NGridCellType)type
                               rowKey:(NSInteger)rowKey
                            columnKey:(NSInteger)columnKey;

@end
