/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridSortSettings.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import "NGridSortSettingsProtocol.h"

/**
 * Options specify which element of the grid should be sorted.
 */
typedef NS_ENUM(NSInteger, NGridSortElementType) {
    /**
     * No element. Sort is not used.
     */
    NGridSortElementTypeNone,
    
    /**
     * Grid should be sorted by row.
     */
    NGridSortElementTypeRow,
    
    /**
     * Grid should be sorted by column.
     */
    NGridSortElementTypeColumn
};

/**
 * Options to specify the sort direction.
 */
typedef NS_ENUM(NSInteger, NGridSortDirection) {
    /**
     * No direction. Sort is not used.
     */
    NGridSortDirectionNone,
    
    /**
     * Grid should be sorted by elements in the ascending direction.
     */
    NGridSortDirectionAsc,
    
    /**
     * Grid should be sorted by elements in the descending direction.
     */
    NGridSortDirectionDesc
};

/**
 * The NGridSortSettings class describes grid sort settings.
 */
@interface NGridSortSettings : NSObject <NGridSortSettingsProtocol>

/**
 * Element key of the sort settings base grid.
 */
@property (assign) NSInteger elementKey;

/**
 * Element type of the sort settings base grid.
 */
@property (assign) NGridSortElementType elementType;

/**
 * Sort direction.
 */
@property (assign) NGridSortDirection direction;

/**
 * A Boolean value that determines whether the case insensitive compare function should be used to compare strings.
 */
@property (assign) BOOL caseInsensitive;

@end
