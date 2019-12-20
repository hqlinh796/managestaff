/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridFilterSettings.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import "NGridFilterSettingsProtocol.h"

/**
 * Options specifying grid elements filtering type.
 */
typedef NS_ENUM(NSInteger, NGridFilterElementType) {
    /**
     * The filter does not applied to the grid elements.
     */
    NGridFilterElementTypeNone,
    
    /**
     * The filter applied to the rows.
     */
    NGridFilterElementTypeRow,
    
    /**
     * The filter applied to the columns.
     */
    NGridFilterElementTypeColumn
};

/**
 * Options to specify filter type.
 */
typedef NS_ENUM(NSInteger, NGridFilterType) {
    /**
     * Filter has no type and is not used.
     */
    NGridFilterTypeNone,
    
    /**
     * Filter elements that are equal to the filter value.
     */
    NGridFilterTypeEqual,
    
    /**
     * Filter elements that are not equal to filter value.
     */
    NGridFilterTypeNotEqual,
    
    /**
     * Filter elements that are greater than the filter value.
     */
    NGridFilterTypeGreater,
    
    /**
     * Filter elements that are less than the filter value.
     */
    NGridFilterTypeLess,
    
    /**
     * Filter elements that are greater or equal to the filter value.
     */
    NGridFilterTypeGreaterOrEqual,
    
    /**
     * Filter elements that are less or equal to the filter value.
     */
    NGridFilterTypeLessOrEqual,
    
    /**
     * Filter elements that are in the interval between filter values.
     */
    NGridFilterTypeBetween,
    
    /**
     * Filter elements that are less than the first filter value and greater than the second one.
     */
    NGridFilterTypeLessOrGreater
};

/**
 * The NGridFilterSetting class describes grid filter setting.
 */
@interface NGridFilterSetting : NSObject

/**
 * Key of the base filter element.
 */
@property (assign) NSInteger elementKey;

/**
 * Type of the base filter element.
 */
@property (assign) NGridFilterElementType elementType;

/**
 * Type of the filter.
 */
@property (assign) NGridFilterType filterType;

/**
 * First value.
 */
@property (retain) NSObject *valueA;

/**
 * Second value.
 */
@property (retain) NSObject *valueB;

/**
 * A Boolean value that determines whether the case insensitive compare function should be used to compare strings.
 */
@property (assign) BOOL caseInsensitive;

@end

/**
 * The NGridFilterSettings class describes grid filter settings.
 */
@interface NGridFilterSettings : NSObject <NGridFilterSettingsProtocol>

/**
 * A Boolean value that determines whether the filter should remove zero rows.
 */
@property (assign) BOOL filterZeroRows;

/**
 * A Boolean value that determines whether the filter should remove zero columns.
 */
@property (assign) BOOL filterZeroColumns;

/**
 * A Boolean value that determines whether the filter should remove empty rows.
 */
@property (assign) BOOL filterEmptyRows;

/**
 * A Boolean value that determines whether the filter should remove empty columns.
 */
@property (assign) BOOL filterEmptyColumns;

/**
 * A Boolean value that determines whether the filter should remove non-numeric rows.
 */
@property (assign) BOOL filterNonNumericRows;

/**
 * A Boolean value that determines whether the filter should remove non-numeric columns.
 */
@property (assign) BOOL filterNonNumericColumns;

/**
 * Settings of the filter.
 */
@property (readonly) NSMutableArray *settings;

@end
