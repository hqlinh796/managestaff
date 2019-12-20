/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridHighlightSettings.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import "NGridHighlightSettingsProtocol.h"

/**
 * Options to specify highlight settings type.
 */
typedef NS_ENUM(NSInteger, NGridHighlightType) {
    /**
     * Highlight settings have no type and are not used.
     */
    NGridHighlightTypeNone,
    
    /**
     *  Highlight the cells with the values equal to the value of highlight settings.
     */
    NGridHighlightTypeEqual,
    
    /**
     * Highlight the cells with the values not equal to the value of highlight settings.
     */
    NGridHighlightTypeNotEqual,
    
    /**
     * Highlight the cells with the values greater than the value of highlight settings.
     */
    NGridHighlightTypeGreater,
    
    /**
     * Highlight the cells with the values less than the value of highlight settings.
     */
    NGridHighlightTypeLess,
    
    /**
     * Highlight the cells with the values greater or equal to the value of highlight settings.
     */
    NGridHighlightTypeGreaterOrEqual,
    
    /**
     * Highlight the cells with the values less or equal to the value of highlight settings.
     */
    NGridHighlightTypeLessOrEqual,
    
    /**
     * Highlight the cells with the values in the interval between first and second highlight settings values.
     */
    NGridHighlightTypeBetween,
    
    /**
     * Highlight the cells with the values less than the first highlight value and greater than the second one.
     */
    NGridHighlightTypeLessOrGreater,
    
    /**
     * Highlight the cells with the greatest value. The number of highlighted cells equals to the highlight settings value.
     */
    NGridHighlightTypeGreatest,
    
    /**
     * Highlight the cells with the lowest value. The number of highlighted cells equals to the highlight settings value.
     */
    NGridHighlightTypeLowest,
    
    /**
     * Highlight the cells with the values containing the highlight settings value.
     */
    NGridHighlightTypeContain,
    
    /**
     * Highlight cells with the suffix equal to the highlight settings value.
     */
    NGridHighlightTypeSuffix,
    
    /**
     * Highlight cells with the prefix equal to the highlight settings value.
     */
    NGridHighlightTypePrefix,
    
    /**
     * Highlight the cells without the values containing the highlight settings value.
     */
    NGridHighlightTypeNotContain,
    
    /**
     * Highlight cells without the suffix equal to the highlight settings value.
     */
    NGridHighlightTypeNotSuffix,
    
    /**
     * Highlight cells without the prefix equal to the highlight settings value.
     */
    NGridHighlightTypeNotPrefix,
};

/**
 * The NGridHighlightSettings class describes grid highlight settings.
 */
@interface NGridHighlightSettings : NSObject <NGridHighlightSettingsProtocol>

/**
 * Type of the highlight.
 */
@property (assign) NGridHighlightType highlightType;

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
